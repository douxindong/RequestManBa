//
//  ParamConfigDetailViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/17.
//  Copyright © 2020 maba. All rights reserved.
//

#import "ParamConfigDetailViewController.h"
#import "HeaderItemTableViewCell.h"
@interface ParamConfigDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *nameTf;

@end

@implementation ParamConfigDetailViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.tableview];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
            
        }
            break;
            
        default:
            break;
    }
}

- (NSArray *)arr{
    return @[@"manager environments",@"gloabs",@"manager environments",@"gloabs",@"manager environments",@"gloabs",@"manager environments",@"gloabs",@"manager environments",@"gloabs",@"manager environments",@"gloabs",@"manager environments",@"gloabs",@"manager environments",@"gloabs"];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HeaderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HeaderItemTableViewCell.class)];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(HeaderItemTableViewCell.class) owner:self options:nil].lastObject;
    }
    cell.keyTextfield.text = @"{{key}}";
    cell.valueTextfield.text = @"value";
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.filePathList.count;
    return [self arr].count;
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
