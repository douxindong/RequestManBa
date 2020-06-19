//
//  RequestTool.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "RequestTool.h"

static AFHTTPSessionManager *sessionManager = nil;

@implementation RequestTool
+ (instancetype)sharedInstance {
    static RequestTool *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RequestTool alloc] init];
    });
    
    return _sharedInstance;
}

+ (AFHTTPSessionManager *)defaultSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        //        sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        sessionManager.requestSerializer.timeoutInterval = TIME_OUT;
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    });
    return sessionManager;
}
- (void)requestItem:(ItemItem *)item
            success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    AFHTTPSessionManager *manager = [RequestTool defaultSessionManager];
    NSString *urlstr = @"";
    __block NSString *path = @"";
    [item.request.url.path enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        path = [path stringByAppendingFormat:@"/%@",obj];
    }];
    NSString *host = [item.request.url.host.firstObject stringByReplacingOccurrencesOfString:@"{{baseurl}}" withString:@"http://videoapi.lifevc.com"];
    
    urlstr = [NSString stringWithFormat:@"%@%@",host,path];
    __block NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    [item.request.header enumerateObjectsUsingBlock:^(HeaderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [headers addEntriesFromDictionary:@{obj.key:[obj.value stringByReplacingOccurrencesOfString:@"{{apitoken}}" withString:getApiToken(urlstr)]}];
    }];
    __block NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [item.request.url.query enumerateObjectsUsingBlock:^(QueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parameters addEntriesFromDictionary:@{obj.key:obj.value}];
    }];
    [[manager dataTaskWithHTTPMethod:item.request.method URLString:urlstr parameters:parameters headers:headers uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CBInvokeBlock(success,task,responseObject);
        [self LogRequest:urlstr Head:headers method:item.request.method withParameter:parameters withResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CBInvokeBlock(failure,task,error);
        [self LogRequest:urlstr Head:headers method:item.request.method withParameter:parameters withResponseObject:error];
    }] resume];
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
@end
