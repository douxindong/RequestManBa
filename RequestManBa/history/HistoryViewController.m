//
//  HistoryViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "HistoryViewController.h"
#import "RequestFileModel.h"
#import "DetailViewController.h"
@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RequestFileModel *requestFileModel;
@property (nonatomic, strong) ItemItemData *itemData;
@end

@implementation HistoryViewController

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}
- (UIButton *)rightNavBtn{
    if (_rightNavBtn == nil) {
        _rightNavBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_rightNavBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
//        _rightNavBtn.tintColor = [UIColor blackColor];
    }
    return _rightNavBtn;
}
- (void)addClick{
    NSLog(@"新建请求");
    @weakify(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"request api name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"request api name 1";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        //获取第1个输入框；
        UITextField *textField = alertController.textFields.firstObject;
        NSLog(@"textField.text == %@",textField.text);
        if (textField.text.length) {
            if (self.requestFileModel.needSection) {
                ItemItem *itemModel = [ItemItem getDefaultItemItem];
                itemModel.name = textField.text;
                NSMutableArray *items = [self.requestFileModel.itemDatas.lastObject.items mutableCopy];
                [items addObject:itemModel];
                self.requestFileModel.itemDatas.lastObject.items = [items copy];
                [CacheTool saveData:[[self.requestFileModel yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                    NSLog(@"filePath == %@",filePath);
                }];
                [self refresh];
            }else{
                ItemItem *itemModel = [ItemItem getDefaultItemItem];
                itemModel.name = textField.text;
                NSMutableArray *items = [self.itemData.items mutableCopy];
                [items addObject:itemModel];
                self.itemData.items = [items copy];
                [CacheTool saveData:[[self.itemData yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                    NSLog(@"filePath == %@",filePath);
                }];
                [self refresh];
            }
        }
    }]];
    [self presentViewController:alertController animated:true completion:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)refresh{
    NSDictionary *dic;
//    dic = [Tools getJsonDataFromBundleWithName:@"Postman Echo.postman_collection.json"];
//    dic = [Tools getJsonDataFromBundleWithName:@"VideoApi.postman_collection.json"];
//    NSLog(@"filepath == %@",[CacheTool userDocumentDirectory]);
    dic = [CacheTool getDataWithKey:_filePath];
    NSLog(@"dic == %@",dic);
    _requestFileModel = [RequestFileModel yy_modelWithJSON:dic];
    
    [_requestFileModel.itemDatas enumerateObjectsUsingBlock:^(ItemItemData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.items.count) {
            _requestFileModel.needSection = YES;
            *stop = YES;
        }
    }];
    if (!_requestFileModel.needSection) {
        _itemData = [ItemItemData yy_modelWithJSON:dic];
        self.title = _itemData.name;
        NSLog(@"_itemData == %@",[_itemData yy_modelDescription]);
    }else{
        self.title = _requestFileModel.info.name;
        NSLog(@"_requestFileModel == %@",[_requestFileModel yy_modelDescription]);
    }
    [self.tableview reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (_requestFileModel.needSection) {
        cell.textLabel.text = _requestFileModel.itemDatas[indexPath.section].items[indexPath.row].name;
    }else{
        cell.textLabel.text = _itemData.items[indexPath.row].name;
    }
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_requestFileModel.needSection) {
        return _requestFileModel.itemDatas[section].items.count;
    }
    return _itemData.items.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _requestFileModel.needSection?_requestFileModel.itemDatas.count:1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.text = _requestFileModel.itemDatas[section].name;
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    return _requestFileModel.needSection?view:nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _requestFileModel.needSection?20:CGFLOAT_MIN;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    @weakify(self)
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (self.requestFileModel.needSection) {
            if (self.requestFileModel.itemDatas[indexPath.section].items.count>1) {
                NSMutableArray *items = [self.requestFileModel.itemDatas[indexPath.section].items mutableCopy];
                [items removeObjectAtIndex:indexPath.row];
                self.requestFileModel.itemDatas[indexPath.section].items = [items copy];
                [CacheTool saveData:[[self.requestFileModel yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                    NSLog(@"filePath == %@",filePath);
                }];
                [self refresh];
            }else{
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:@"至少保留一项"];
            }
        }else{
            if (self.itemData.items.count>1) {
                NSMutableArray *items = [self.itemData.items mutableCopy];
                [items removeObjectAtIndex:indexPath.row];
                self.itemData.items = [items copy];
                [CacheTool saveData:[[self.itemData yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                    NSLog(@"filePath == %@",filePath);
                }];
                [self refresh];
            }else{
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:@"至少保留一项"];
            }
        }
    }];
    deleteAction.backgroundColor = [UIColor blackColor];
    
    UITableViewRowAction *RenameAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Rename" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"create collection" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //定义第一个输入框；
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"name";
            if (self.requestFileModel.needSection) {
                textField.text = self.requestFileModel.itemDatas[indexPath.section].items[indexPath.row].name;
            }else{
                textField.text = self.itemData.items[indexPath.row].name;
            }
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self)
            //获取第1个输入框；
            UITextField *textField = alertController.textFields.firstObject;
            NSLog(@"textField.text == %@",textField.text);
            if (textField.text.length) {
                if (self.requestFileModel.needSection) {
                    self.requestFileModel.itemDatas[indexPath.section].items[indexPath.row].name = textField.text;
                    [CacheTool saveData:[[self.requestFileModel yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                        NSLog(@"filePath == %@",filePath);
                    }];
                    [self refresh];
                }else{
                    self.itemData.items[indexPath.row].name = textField.text;
                    [CacheTool saveData:[[self.itemData yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                        NSLog(@"filePath == %@",filePath);
                    }];
                    [self refresh];
                }
            }
        }]];
        [self presentViewController:alertController animated:true completion:nil];
    }];
    RenameAction.backgroundColor = [UIColor blueColor];
    
    return @[deleteAction,RenameAction];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [DetailViewController new];
    @weakify(self);
    if (_requestFileModel.needSection) {
        detailVC.item = _requestFileModel.itemDatas[indexPath.section].items[indexPath.row];
        detailVC.itemItemChangeBlock = ^(ItemItem * _Nonnull itemItem) {
            @strongify(self);
            NSMutableArray *items = [self.requestFileModel.itemDatas[indexPath.section].items mutableCopy];
            [items replaceObjectAtIndex:indexPath.row withObject:itemItem];
            self.requestFileModel.itemDatas[indexPath.section].items = [items copy];
            [CacheTool saveData:[[self.requestFileModel yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                NSLog(@"filePath == %@",filePath);
            }];
            [self refresh];
        };
    }else{
        detailVC.item = _itemData.items[indexPath.row];
        detailVC.itemItemChangeBlock = ^(ItemItem * _Nonnull itemItem) {
            @strongify(self);
            NSMutableArray *items = [self.itemData.items mutableCopy];
            [items replaceObjectAtIndex:indexPath.row withObject:itemItem];
            self.itemData.items = [items copy];
            [CacheTool saveData:[[self.itemData yy_modelToJSONObject] jsonPrettyStringEncoded] key:self.filePath dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                NSLog(@"filePath == %@",filePath);
            }];
            [self refresh];
        };
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
