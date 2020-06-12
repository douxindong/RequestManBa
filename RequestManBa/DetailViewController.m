//
//  DetailViewController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "DetailViewController.h"
#import "TextCollectionViewCell.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSString *response;
@end

@implementation DetailViewController
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        _tableview registerNib:[UINib nibWithNibName:<#(nonnull NSString *)#> bundle:<#(nullable NSBundle *)#>] forCellReuseIdentifier:<#(nonnull NSString *)#>
//        [_tableview registerClass:[<#CellClass#> class] forCellReuseIdentifier:<#KReuseCellIdentifier#>];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _item.name;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self requestData];
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(10);
        make.top.equalTo(cell.contentView).offset(10);
        make.bottom.right.equalTo(cell.contentView).offset(-10);
    }];
    if (indexPath.section == 0) {
        label.text = [_item.request.url yy_modelDescription];
    }else if (indexPath.section == 1){
        label.text = [_item.request.header[indexPath.row] yy_modelDescription];
    }else if (indexPath.section == 2){
        label.text = _item.request.request_description;
    }else if (indexPath.section == 3){
        label.text = _response;
    }
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
        label.text = _item.request.method;
    }else if (section == 1){
        label.text = @"header";
    }else if (section == 2){
        label.text = @"request_description";
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






NSString *getApiToken(NSString *url){
    NSString *ApiToken = ApiTokenRest;
    if ([url containsString:@"w2api"]) {
        ApiToken = ApiTokenW2api;//抹茶站点的ApiToken
    }else if ([url containsString:@"videoapi"]){
        ApiToken = ApiTokenVideo;//视频站点
    }
    return ApiToken;
}
- (void)requestData{
    AFHTTPSessionManager *manager = [RequestTool defaultSessionManager];
    NSString *urlstr = @"https://videoapi.lifevc.com/video/List/10/1?deviceId=123&itemInfoId=0";
    //    NSURL *url = [NSURL new];
    //    url.host = @"http://videoapi.lifevc.com";
    
    __block NSString *path = @"";
    [_item.request.url.path enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        path = [path stringByAppendingFormat:@"/%@",obj];
    }];
    NSString *host = [_item.request.url.host.firstObject stringByReplacingOccurrencesOfString:@"{{baseurl}}" withString:@"http://videoapi.lifevc.com"];
    
    urlstr = [NSString stringWithFormat:@"%@%@",host,path];
    __block NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    [_item.request.header enumerateObjectsUsingBlock:^(HeaderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [headers addEntriesFromDictionary:@{obj.key:[obj.value stringByReplacingOccurrencesOfString:@"{{apitoken}}" withString:getApiToken(urlstr)]}];
    }];
    __block NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [_item.request.url.query enumerateObjectsUsingBlock:^(QueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parameters addEntriesFromDictionary:@{obj.key:obj.value}];
    }];
    
    [manager GET:urlstr parameters:parameters headers:headers progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.response = [responseObject yy_modelToJSONString];
        [self.tableview reloadData];
        [self LogRequest:urlstr Head:headers method:self->_item.request.method withParameter:parameters withResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self LogRequest:urlstr Head:headers method:self->_item.request.method withParameter:parameters withResponseObject:error];
    }];
    
}

- (void)setItem:(ItemItem *)item{
    _item = item;
}



- (void)LogRequest:(NSString *)relativeUrl Head:(NSDictionary *)customerHead
                                         method:(NSString *)method
                                  withParameter:(NSDictionary *)parameters
                             withResponseObject:(id)responseObject{
    NSString *res ;
    if ([responseObject isKindOfClass:[NSError class]]) {
        res = [responseObject description];
    }else{
        res = [responseObject yy_modelDescription];
    }
    NSString *log = [NSString stringWithFormat:@"请求方式method ：%@ \n请求接口url：%@\n 请求头 header：%@\n 参数parameters：%@\n\n 返回数据： %@",method,relativeUrl,[customerHead yy_modelDescription],[parameters yy_modelDescription],res];
    NSLog(@"%@",log);
}
- (MBRequestMethod)methodTypeWithName:(NSString *)methodName{
    MBRequestMethod methodType = MBRequest_GET;
    if ([methodName isEqualToString:@"GET"]) {
        methodType = MBRequest_GET;
    } else if ([methodName isEqualToString:@"POST"]) {
        methodType = MBRequest_POST;
    } else if ([methodName isEqualToString:@"PUT"]) {
        methodType = MBRequest_PUT;
    } else if ([methodName isEqualToString:@"MULTIPOST"]) {
        methodType = MBRequest_MULTIPOST;
    } else if ([methodName isEqualToString:@"HEAD"]) {
        methodType = MBRequest_HEAD;
    } else if ([methodName isEqualToString:@"DELETE"]) {
        methodType = MBRequest_DELETE;
    }
    return methodType;
}
- (NSString *)methodNameWithType:(MBRequestMethod)methodType{
    NSString *methodName = @"GET";
    switch (methodType) {
        case MBRequest_GET:
        {
            methodName = @"GET";
        }
            break;
        case MBRequest_POST:
        {
            methodName = @"POST";
        }
            break;
        case MBRequest_MULTIPOST:
        {
            methodName = @"MULTIPOST";
        }
            break;
        case MBRequest_HEAD:
        {
            methodName = @"HEAD";
        }
            break;
        case MBRequest_PUT:
        {
            methodName = @"PUT";
        }
            break;
        case MBRequest_DELETE:
        {
            methodName = @"DELETE";
        }
            break;
            
        default:
            break;
    }
    return methodName;
    
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
