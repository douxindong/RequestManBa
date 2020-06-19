//
//  EnvironmentViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/17.
//  Copyright © 2020 maba. All rights reserved.
//

#import "EnvironmentViewController.h"
#import "ParamConfigDetailViewController.h"
@interface EnvironmentViewController ()<UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *rightNavBtn;

@end

@implementation EnvironmentViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"manager environments";
    [self.view addSubview:self.tableview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
}
- (void)addClick{
    [YBPopupMenu showRelyOnView:self.rightNavBtn titles:@[@"导入",@"新建",@"导出"] icons:nil menuWidth:100 delegate:self];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            ParamConfigDetailViewController *paramVC = [ParamConfigDetailViewController new];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:paramVC];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            
        }
            break;
        case 2:{
            

        }
            break;
            
        default:
            break;
    }
}
- (NSArray *)arr{
    return @[@"environment1",@"environment2"];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self arr][indexPath.row];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.filePathList.count;
    return [self arr].count;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ParamConfigDetailViewController *paramVC = [ParamConfigDetailViewController new];
    paramVC.title = [self arr][indexPath.row];
    paramVC.vcType = ParamConfigVCTypeManager;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:paramVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
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
