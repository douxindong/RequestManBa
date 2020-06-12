//
//  RequestFileModel.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

@end
@interface Url :NSObject
@property (nonatomic , copy) NSString              * raw;
@property (nonatomic , copy) NSString              * protocol;
@property (nonatomic , strong) NSArray <NSString *>              * host;
@property (nonatomic , strong) NSArray <NSString *>              * path;
@property (nonatomic , strong) NSArray <QueryItem *>              * query;

@end

@interface HeaderItem :NSObject
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic , copy) NSString              * type;

@end

@interface Request :NSObject
@property (nonatomic , copy) NSString              * method;
@property (nonatomic , strong) Url              * url;
@property (nonatomic , copy) NSString              * request_description;
@property (nonatomic , strong) NSArray <HeaderItem *>              * header;

@end


@interface ResponseItem :NSObject

@end


@interface ItemItem :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <EventItem *>              * event;
@property (nonatomic , strong) Request              * request;
@property (nonatomic , strong) NSArray <ResponseItem *>              * response;

@end


@interface ProtocolProfileBehavior :NSObject

@end


@interface ItemItemData :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <ItemItem *>              * items;
@property (nonatomic , copy) NSString              * item_description;

@end



@interface RequestFileModel :NSObject
@property (nonatomic , strong) Info              * info;
@property (nonatomic , strong) NSArray <ItemItemData *>              * itemDatas;
@property (nonatomic, assign) BOOL needSection;

@end

NS_ASSUME_NONNULL_END
