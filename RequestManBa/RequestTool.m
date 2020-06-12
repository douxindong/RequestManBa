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

@end
