//
//  RequestTool.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

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
+ (AFHTTPSessionManager *)defaultSessionManager;
@end

NS_ASSUME_NONNULL_END
