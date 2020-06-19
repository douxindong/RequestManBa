//
//  EnvironmentsModel.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/17.
//  Copyright © 2020 maba. All rights reserved.
//

#import "EnvironmentsModel.h"
@implementation ValuesItem
@end

@implementation EnvironmentsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"envId"  : @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"values" : [ValuesItem class]};
}
@end
