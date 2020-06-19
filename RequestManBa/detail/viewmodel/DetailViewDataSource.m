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
    }
    return self;
}
- (void)bindTableView:(UITableView *)tableView{
    _tableView = tableView;
    [self registerCells];
//    [self send];
}
- (void)send{
    if (!_item) return;
    NSDate *startDate = [NSDate date];
    [[RequestTool sharedInstance] requestItem:_item success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval deltaTime = [[NSDate date] timeIntervalSinceDate:startDate]*1000;
        NSLog(@"Status: %zd",((NSHTTPURLResponse *)task.response).statusCode)
        NSLog(@"Time: %.fs",deltaTime)
        self.responseDesp = [NSString stringWithFormat:@"Status:%zd Time:%.fs",((NSHTTPURLResponse *)task.response).statusCode,deltaTime];
        self.response = [responseObject jsonPrettyStringEncoded];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSTimeInterval deltaTime = [[NSDate date] timeIntervalSinceDate:startDate]*1000;
        NSLog(@"Status: %zd",((NSHTTPURLResponse *)task.response).statusCode)
        NSLog(@"Time: %.fs",deltaTime)
        self.responseDesp = [NSString stringWithFormat:@"Status:%zd Time:%.fs",((NSHTTPURLResponse *)task.response).statusCode,deltaTime];
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
    if (indexPath.section == 0) {
        SendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SendTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(SendTableViewCell.class) owner:self options:nil].lastObject;
        }
        cell.sendBlock = [self sendBlock];
        cell.chooseMethodBlock = [self chooseMethodBlock];
        NSString *urlstr = @"https://videoapi.lifevc.com/video/List/10/1?deviceId=123&itemInfoId=0";
        __block NSString *path = @"";
        [_item.request.url.path enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            path = [path stringByAppendingFormat:@"/%@",obj];
        }];
        NSString *host = [_item.request.url.host.firstObject stringByReplacingOccurrencesOfString:@"{{baseurl}}" withString:@"http://videoapi.lifevc.com"];
        
        urlstr = [NSString stringWithFormat:@"%@%@",host,path];
        cell.urlTextField.text = urlstr;
        return cell;
    }else if (indexPath.section == 1){
        HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
        }
        cell.keyTextfield.text = _item.request.url.query[indexPath.row].key;
        cell.valueTextfield.text = _item.request.url.query[indexPath.row].value;
        if (indexPath.row == _item.request.url.query.count-1) {
            cell.addHeaderItemButton.hidden = NO;
        }else{
            cell.addHeaderItemButton.hidden = YES;
        }
        return cell;
    }else if (indexPath.section == 2){
        HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
        }
        cell.keyTextfield.text = _item.request.header[indexPath.row].key;
        cell.valueTextfield.text = _item.request.header[indexPath.row].value;
        if (indexPath.row == _item.request.header.count-1) {
            cell.addHeaderItemButton.hidden = NO;
        }else{
            cell.addHeaderItemButton.hidden = YES;
        }
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
    DTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DTableViewCell.class)];
    if (cell == nil) {
        cell = [[DTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DTableViewCell.class)];
    }
    return cell;
}
- (void(^)(void))sendBlock{
    __weak typeof(self) weakself = self;
    return ^{
        [weakself send];
    };
}
- (void(^)(NSString * _Nonnull methodName))chooseMethodBlock{
//    __weak typeof(self) weakself = self;
    return ^(NSString * _Nonnull methodName){
        NSLog(@"methodName == %@",methodName);
    };
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
