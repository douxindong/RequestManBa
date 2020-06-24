//
//  DetailViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailViewDataSource.h"
@interface DetailViewController ()
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *nameTf;
@property (nonatomic, strong) DetailViewDataSource *dataSource;
@end

@implementation DetailViewController

- (DetailViewDataSource *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[DetailViewDataSource alloc] initWithItem:_item];
    }
    return _dataSource;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self.dataSource;
        _tableview.dataSource = self.dataSource;
        _tableview.tableFooterView = [UIView new];
//        _tableview.tableHeaderView = self.headerView;
////        _tableview.rowHeight = UITableViewAutomaticDimension;
//        _tableview.estimatedRowHeight = 44;
    }
    return _tableview;
}
- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = @"API Name";
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
        _nameTf.placeholder = @"InPut API Name";
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _item.name;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.dataSource bindTableView:self.tableview];
    self.dataSource.itemItemChangeBlock = self.itemItemChangeBlock;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_dataSource save];
}
- (void)setItem:(ItemItem *)item{
    _item = item;
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
