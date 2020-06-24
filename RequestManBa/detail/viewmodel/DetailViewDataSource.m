//
//  DetailViewDataSource.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import "DetailViewDataSource.h"
#import "SendTableViewCell.h"
#import "HeaderItemTableViewCell.h"
#import "DescpTableViewCell.h"
#import "DTableViewCell.h"
@interface DetailViewDataSource ()
@property (nonatomic, strong) ItemItem *item;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) NSString *responseDesp;
@end

@implementation DetailViewDataSource
- (instancetype)initWithItem:(ItemItem *)item{
    if (self = [super init]) {
        _item = item;
        NSArray *arr = @[];
        if (!_item.request.url.query.count) {
            ValuesItem *vl = [ValuesItem getDefaultValueItem];
            NSMutableArray *values = [arr mutableCopy];
            [values addObject:vl];
            _item.request.url.query = [values copy];
        }
        if (!_item.request.header.count){
            ValuesItem *vl = [ValuesItem getDefaultValueItem];
            NSMutableArray *values = [arr mutableCopy];
            [values addObject:vl];
            _item.request.header = [values copy];
        }
    }
    return self;
}
- (void)bindTableView:(UITableView *)tableView{
    _tableView = tableView;
    [self registerCells];
}
- (void)save{
    if(self.changed){
        CBInvokeBlock(self.itemItemChangeBlock,_item);
    }
}
- (void)send{
    if (!_item) return;
    
    [self save];
    
    NSDate *startDate = [NSDate date];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[RequestTool sharedInstance] requestItem:_item success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSTimeInterval deltaTime = [[NSDate date] timeIntervalSinceDate:startDate]*1000;
        NSLog(@"Status: %zd",((NSHTTPURLResponse *)task.response).statusCode);
        NSLog(@"Time: %.fs",deltaTime);
        self.responseDesp = [NSString stringWithFormat:@"Status:%zd Time:%.fms",((NSHTTPURLResponse *)task.response).statusCode,deltaTime];
        self.response = [responseObject jsonPrettyStringEncoded];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSTimeInterval deltaTime = [[NSDate date] timeIntervalSinceDate:startDate]*1000;
        NSLog(@"Status: %zd",((NSHTTPURLResponse *)task.response).statusCode);
        NSLog(@"Time: %.fs",deltaTime);
        self.responseDesp = [NSString stringWithFormat:@"Status:%zd Time:%.fms",((NSHTTPURLResponse *)task.response).statusCode,deltaTime];
        self.response = error.description;
        [self.tableView reloadData];
    }];
}
- (void)registerCells{
    NSArray <NSString *>*cells = @[@"SendTableViewCell",@"HeaderItemTableViewCell",@"DescpTableViewCell"];
    [cells enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_tableView registerNib:[UINib nibWithNibName:obj bundle:[NSBundle mainBundle]] forCellReuseIdentifier:obj];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    @weakify(self);
    if (indexPath.section == 0) {
        SendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SendTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(SendTableViewCell.class) owner:self options:nil].lastObject;
        }
        cell.request = _item.request;
        cell.sendBlock = ^{
            @strongify(self);
            [self send];
        };
        cell.requestChangeBlock = ^(Request * _Nonnull request) {
            @strongify(self);
            self.changed = YES;
            self.item.request = request;
        };
        return cell;
    }else if (indexPath.section == 1||indexPath.section == 2){
        HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
        }
        NSArray *arr = nil;
        if (indexPath.section == 1) {
            arr = _item.request.url.query;
        }else if (indexPath.section == 2){
            arr = _item.request.header;
        }
        cell.valueItem = arr[indexPath.row];
        if (indexPath.row == arr.count-1) {
            cell.addHeaderItemButton.hidden = NO;
        }else{
            cell.addHeaderItemButton.hidden = YES;
        }
        cell.addItemBlock = ^{
            @strongify(self);
            ValuesItem *vl = [ValuesItem getDefaultValueItem];
            vl.key = [NSString stringWithFormat:@"%zd",indexPath.row];
            NSMutableArray *values = [arr mutableCopy];
            [values addObject:vl];
            if (indexPath.section == 1) {
                self.item.request.url.query = [values copy];
            }else if (indexPath.section == 2){
                self.item.request.header = [values copy];
            }
            [self.tableView reloadData];
        };
        cell.valuesItemChangeBlock = ^(ValuesItem * _Nonnull valueItem) {
            @strongify(self);
            self.changed = YES;
            NSMutableArray *values = [arr mutableCopy];
            [values replaceObjectAtIndex:indexPath.row withObject:valueItem];
            if (indexPath.section == 1) {
                self.item.request.url.query = [values copy];
            }else if (indexPath.section == 2){
                self.item.request.header = [values copy];
            }
        };
        return cell;
    }else if (indexPath.section == 3){
        DescpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DescpTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(DescpTableViewCell.class) owner:self options:nil].lastObject;
        }
        cell.tb = _tableView;
        cell.topLabel.text = self.responseDesp;
        cell.textView.text = self.response;
        return cell;
    }
    return nil;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return _item.request.url.query.count;
    }else if (section == 2) {
        return _item.request.header.count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    if (section == 0) {
        label.text = _item.name;
    }else if (section == 1){
        label.text = @"params";
    }else if (section == 2){
        label.text = @"header";
    }else if (section == 3){
        label.text = @"response";
    }
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
        NSArray *arr = nil;
        if (indexPath.section == 1) {
            arr = self.item.request.url.query;
        }else if (indexPath.section == 2){
            arr = self.item.request.header;
        }
        if (arr.count>1) {
            NSMutableArray *values = [arr mutableCopy];
            [values removeObjectAtIndex:indexPath.row];
            if (indexPath.section == 1) {
                self.item.request.url.query = [values copy];
            }else if (indexPath.section == 2){
                self.item.request.header = [values copy];
            }
            [self.tableView reloadData];
            [self save];
        }else{
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showInfoWithStatus:@"至少保留一项"];
        }
    }];
    return @[deleteAction];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
