//
//  ParamConfigDetailViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/17.
//  Copyright © 2020 maba. All rights reserved.
//

#import "ParamConfigDetailViewController.h"
#import "HeaderItemTableViewCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface ParamConfigDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UIButton *backNavBtn;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *nameTf;
@property (nonatomic, strong) NSMutableArray *paramDatas;
@property (nonatomic, strong) MBGloabsModel *gloabsModel;
@property (nonatomic, assign) BOOL changed;
@end

@implementation ParamConfigDetailViewController
//- (NSMutableArray *)paramDatas{
//    if (_paramDatas == nil) {
//        _paramDatas = [NSMutableArray array];
//    }
//    return _paramDatas;
//}
- (UIButton *)rightNavBtn{
    if (_rightNavBtn == nil) {
        _rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightNavBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_rightNavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightNavBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBtn;
}
- (UIButton *)backNavBtn{
    if (_backNavBtn == nil) {
        _backNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backNavBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];;
        [_backNavBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backNavBtn;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass(HeaderItemTableViewCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
    }
    return _tableview;
}
- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = @"Add Environment";
        nameLabel.left = nameLabel.top = 10;
        [nameLabel sizeToFit];
        [_headerView addSubview:nameLabel];
        [_headerView addSubview:self.nameTf];
        self.nameTf.top = nameLabel.bottom + 10;
        _headerView.height = self.nameTf.bottom + 10;
    }
    return _headerView;
}
- (UITextField *)nameTf{
    if (_nameTf == nil) {
        _nameTf = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 30)];
        _nameTf.placeholder = @" Environment Name";
        _nameTf.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _nameTf.layer.cornerRadius = 2;
        _nameTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTf.keyboardType = UIKeyboardTypeURL;
        _nameTf.returnKeyType = UIReturnKeyGo;
        _nameTf.leftViewMode = UITextFieldViewModeAlways;
        _nameTf.backgroundColor = BGColor;
        
    }
    return _nameTf;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self saveClick];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backNavBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)backClick{
    if (self.changed) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存更改？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self saveClick];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }]];
        [self presentViewController:alertController animated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)saveClick{
    [self saveDataShowStatus:YES];
}
- (void)saveDataShowStatus:(BOOL)show{
    [CacheTool saveData:[[self.gloabsModel yy_modelToJSONObject] jsonPrettyStringEncoded] key:UserCustomizationGloabStr dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
        self.changed = NO;
        NSLog(@"filePath == %@",filePath);
        if (show) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
}
- (void)setVcType:(ParamConfigVCType)vcType{
    _vcType = vcType;
    switch (_vcType) {
        case ParamConfigVCTypeManager:
        {
            self.tableview.tableHeaderView = self.headerView;
        }
            break;
        case ParamConfigVCTypeGloabs:
        {
            NSDictionary *dics = [CacheTool getDataWithKey:UserCustomizationGloabStr];
            if (dics) {
                self.gloabsModel = [MBGloabsModel yy_modelWithJSON:dics];
            }else{
                self.gloabsModel = [MBGloabsModel getDefaultMBGloabsModel];
                [CacheTool saveData:[[self.gloabsModel yy_modelToJSONObject] jsonPrettyStringEncoded] key:UserCustomizationGloabStr dirType:CacheDriTypeCache completion:^(NSString * _Nonnull filePath) {
                    NSLog(@"filePath == %@",filePath);
                }];
            }
        }
            break;
            
        default:
            break;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
    }
    cell.valueItem = self.gloabsModel.values[indexPath.row];
    @weakify(self);
    if (indexPath.row == self.gloabsModel.values.count-1) {
        cell.addHeaderItemButton.hidden = NO;
    }else{
        cell.addHeaderItemButton.hidden = YES;
    }
    cell.addItemBlock = ^{
        @strongify(self);
        ValuesItem *vl = [ValuesItem getDefaultValueItem];
        vl.key = [NSString stringWithFormat:@"%zd",indexPath.row];
        NSMutableArray *values = [self.gloabsModel.values mutableCopy];
        [values addObject:vl];
        self.gloabsModel.values = [values copy];
        [self.tableview reloadData];
    };
    cell.valuesItemChangeBlock = ^(ValuesItem * _Nonnull valueItem) {
        @strongify(self);
        self.changed = YES;
        NSMutableArray *values = [self.gloabsModel.values mutableCopy];
        [values replaceObjectAtIndex:indexPath.row withObject:valueItem];
        self.gloabsModel.values = [values copy];
    };
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gloabsModel.values.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"enable   key  :  value";
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.centerY.equalTo(view);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
        if (self.gloabsModel.values.count>1) {
            NSMutableArray *values = [self.gloabsModel.values mutableCopy];
            [values removeObjectAtIndex:indexPath.row];
            self.gloabsModel.values = [values copy];
            [self.tableview reloadData];
            [self saveDataShowStatus:NO];
        }else{
          [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showInfoWithStatus:@"至少保留一项"];
        }
    }];
    
    
    return @[deleteAction];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
