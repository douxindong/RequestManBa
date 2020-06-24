//
//  RequestFileModel.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ValuesItem;
@interface Info :NSObject
@property (nonatomic , copy) NSString              * _postman_id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * info_description;
@property (nonatomic , copy) NSString              * schema;

@end


@interface Script :NSObject
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , strong) NSArray <NSString *>              * exec;

@end


@interface EventItem :NSObject
@property (nonatomic , copy) NSString              * listen;
@property (nonatomic , strong) Script              * script;

@end

@interface QueryItem :NSObject
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic, assign) BOOL enabled;

@end
@interface Url :NSObject
@property (nonatomic , copy) NSString              * raw;
@property (nonatomic , copy) NSString              * protocol;
@property (nonatomic , strong) NSArray <NSString *>              * host;
@property (nonatomic , strong) NSArray <NSString *>              * path;
@property (nonatomic , strong) NSArray <ValuesItem *>              * query;

@end


@interface Request :NSObject
@property (nonatomic , copy) NSString              * method;
@property (nonatomic , strong) Url              * url;
@property (nonatomic , copy) NSString              * request_description;
@property (nonatomic , strong) NSArray <ValuesItem *>              * header;

@end


@interface ResponseItem :NSObject

@end


@interface ItemItem :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <EventItem *>              * event;
@property (nonatomic , strong) Request              * request;
@property (nonatomic , strong) NSArray <ResponseItem *>              * response;
+ (ItemItem *)getDefaultItemItem;
@end


@interface ProtocolProfileBehavior :NSObject

@end


@interface ItemItemData :NSObject
@property (nonatomic , strong) Info              * info;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <ItemItem *>              * items;
@property (nonatomic , copy) NSString              * item_description;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *createDate;
+ (ItemItemData *)getDefaultItemItemData;
@end



@interface RequestFileModel :NSObject
@property (nonatomic , strong) Info              * info;
@property (nonatomic , strong) NSArray <ItemItemData *>              * itemDatas;
@property (nonatomic, assign) BOOL needSection;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *createDate;
@end

NS_ASSUME_NONNULL_END
