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
        return cell;
    }else if (indexPath.section == 1){
        HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
        }
        return cell;
    }else if (indexPath.section == 2){
        HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
        }
        return cell;
    }else if (indexPath.section == 3){
        DescpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DescpTableViewCell.class)];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(DescpTableViewCell.class) owner:self options:nil].lastObject;
        }
        cell.tb = _tableView;
        return cell;
    }
    DTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DTableViewCell.class)];
    if (cell == nil) {
        cell = [[DTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(DTableViewCell.class)];
    }
//    cell.textLabel.font = [UIFont systemFontOfSize:12];
//    if (indexPath.section == 0) {
//        cell.textLabel.text = [_item.request.url yy_modelDescription];
//    }else if (indexPath.section == 1){
//        cell.textLabel.text = [_item.request.header[indexPath.row] yy_modelDescription];
//    }else if (indexPath.section == 2){
//        cell.textLabel.text = _item.request.request_description;
//    }else if (indexPath.section == 3){
////        cell.textLabel.text = _response;
//    }
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
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
