//
//  RequestFileItemModel.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestFileModel.h"
NS_ASSUME_NONNULL_BEGIN
@class Info;
@class ItemItem;

@interface RequestFileItemModel :NSObject
@property (nonatomic , strong) Info              * info;
@property (nonatomic , strong) NSArray <ItemItem *>              * item;

@end

NS_ASSUME_NONNULL_END
