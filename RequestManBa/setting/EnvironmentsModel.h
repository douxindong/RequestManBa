//
//  EnvironmentsModel.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/17.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ValuesItem :NSObject
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic , assign) BOOL              enabled;

@end
@interface EnvironmentsModel : NSObject
@property (nonatomic , copy) NSString              * envId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray <ValuesItem *>              * values;
@property (nonatomic , copy) NSString              * _postman_variable_scope;
@property (nonatomic , copy) NSString              * _postman_exported_at;
@property (nonatomic , copy) NSString              * _postman_exported_using;
@end

NS_ASSUME_NONNULL_END
