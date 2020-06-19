//
//  Tools.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+ (NSDictionary *)getJsonDataFromBundleWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    return [CacheTool getJsonDataWithPath:path];
}
@end
