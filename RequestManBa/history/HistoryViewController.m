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
        _tableview.editing = YES;
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
    DetailViewController *detailVC = [DetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
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
    self.title = _requestFileModel.info.name;
    [_requestFileModel.itemDatas enumerateObjectsUsingBlock:^(ItemItemData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.items.count) {
            _requestFileModel.needSection = YES;
            *stop = YES;
        }
    }];
    if (!_requestFileModel.needSection) {
        _itemData = [ItemItemData yy_modelWithJSON:dic];
        NSLog(@"_itemData == %@",[_itemData yy_modelDescription]);
    }else{
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
    }];
    deleteAction.backgroundColor = [UIColor blackColor];
    
    UITableViewRowAction *RenameAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Rename" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
    }];
    RenameAction.backgroundColor = [UIColor blueColor];
    
    return @[deleteAction,RenameAction];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == (UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert)) {
//        [self.dataSoure removeObject:[self.dataSoure objectAtIndex:indexPath.row]];
        //animation后面有好几种删除的方法
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [DetailViewController new];
    if (_requestFileModel.needSection) {
        detailVC.item = _requestFileModel.itemDatas[indexPath.section].items[indexPath.row];
    }else{
        detailVC.item = _itemData.items[indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
