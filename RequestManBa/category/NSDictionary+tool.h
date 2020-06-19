//
//  NSDictionary+tool.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/15.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (tool)
- (NSString *)jsonPrettyStringEncoded;
- (NSString *)descriptionJsonWithLocale:(nullable id)locale;
@end

NS_ASSUME_NONNULL_END
