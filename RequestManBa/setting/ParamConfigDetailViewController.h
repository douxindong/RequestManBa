//
//  ParamConfigDetailViewController.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/17.
//  Copyright © 2020 maba. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,ParamConfigVCType) {
    ParamConfigVCTypeNone,
    ParamConfigVCTypeManager,
    ParamConfigVCTypeGloabs,
};
@interface ParamConfigDetailViewController : BaseViewController
@property (nonatomic, assign) ParamConfigVCType vcType;
@end

NS_ASSUME_NONNULL_END
