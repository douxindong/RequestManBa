//
//  ViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "ViewController.h"
#import "RequestFileModel.h"
#import "RequestFileItemModel.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RequestFileModel *requestFileModel;
@property (nonatomic, strong) RequestFileItemModel *requestFileItemModel;
@end

@implementation ViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    NSDictionary *dic;
//    dic = [Tools getTestJsonDataWithName:@"Postman Echo.postman_collection.json"];
    dic = [Tools getTestJsonDataWithName:@"VideoApi.postman_collection.json"];
    _requestFileModel = [RequestFileModel yy_modelWithJSON:dic];
    self.title = _requestFileModel.info.name;
    [_requestFileModel.itemDatas enumerateObjectsUsingBlock:^(ItemItemData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.items.count) {
            _requestFileModel.needSection = YES;
            *stop = YES;
        }
    }];
    if (!_requestFileModel.needSection) {
        _requestFileItemModel = [RequestFileItemModel yy_modelWithJSON:dic];
        NSLog(@"_requestFileItemModel == %@",[_requestFileItemModel yy_modelDescription]);
    }else{
        NSLog(@"_requestFileModel == %@",[_requestFileModel yy_modelDescription]);
    }
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (_requestFileModel.needSection) {
        cell.textLabel.text = _requestFileModel.itemDatas[indexPath.section].items[indexPath.row].name;
    }else{
        cell.textLabel.text = _requestFileItemModel.item[indexPath.row].name;
    }
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_requestFileModel.needSection) {
        return _requestFileModel.itemDatas[section].items.count;
    }
    return _requestFileItemModel.item.count;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [DetailViewController new];
    if (_requestFileModel.needSection) {
        detailVC.item = _requestFileModel.itemDatas[indexPath.section].items[indexPath.row];
    }else{
        detailVC.item = _requestFileItemModel.item[indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
