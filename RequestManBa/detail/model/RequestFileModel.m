//
//  RequestFileModel.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "RequestFileModel.h"

@implementation Info
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"info_description"  : @"description"};
}
@end


@implementation Script
@end


@implementation EventItem
@end


@implementation Url
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"query" : [ValuesItem class]};
}
@end

@implementation Request
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"request_description"  : @"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"header" : [ValuesItem class]};
}
@end


@implementation ResponseItem
@end


@implementation ItemItem
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [ResponseItem class],
             @"event" : [EventItem class],
    };
}
+ (ItemItem *)getDefaultItemItem{
    NSDictionary *dic = [Tools getJsonDataFromBundleWithName:@"temp.postman_collection.json"];
    NSArray *item = dic[@"item"];
    return [ItemItem yy_modelWithJSON:item.firstObject];
}
@end


@implementation ProtocolProfileBehavior
@end


@implementation ItemItemData

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"items"  : @"item",
             @"item_description"  : @"description"
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [ItemItem class]};
}

+ (ItemItemData *)getDefaultItemItemData{
    NSDictionary *dic = [Tools getJsonDataFromBundleWithName:@"temp.postman_collection.json"];
    return [ItemItemData yy_modelWithJSON:dic];
}
@end



@implementation RequestFileModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemDatas"  : @"item"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemDatas" : [ItemItemData class]};
}
@end
