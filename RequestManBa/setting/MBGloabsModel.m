//
//  MBGloabsModel.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/23.
//  Copyright © 2020 maba. All rights reserved.
//

#import "MBGloabsModel.h"

@implementation ValuesItem
+ (ValuesItem *)getDefaultValueItem{
    NSDictionary *dic = [Tools getJsonDataFromBundleWithName:@"temp.gloabs.json"];
    NSArray *values = dic[@"values"];
    return [ValuesItem yy_modelWithJSON:values.firstObject];
}
@end


@implementation MBGloabsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"envId"  : @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"values" : [ValuesItem class]};
}
+ (MBGloabsModel *)getDefaultMBGloabsModel{
    NSDictionary *dic = [Tools getJsonDataFromBundleWithName:@"temp.gloabs.json"];
    return [MBGloabsModel yy_modelWithJSON:dic];
}
@end
