//
//  RequestTool.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestFileModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, MBRequestMethod) {
    MBRequest_GET = 0,
    MBRequest_POST,
    MBRequest_MULTIPOST,
    MBRequest_HEAD,
    MBRequest_PUT,
    MBRequest_DELETE
};
@interface RequestTool : NSObject
+ (instancetype)sharedInstance;
+ (AFHTTPSessionManager *)defaultSessionManager;
- (void)requestItem:(ItemItem *)item
            success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
+ (NSArray *)methods;
@end

NS_ASSUME_NONNULL_END
