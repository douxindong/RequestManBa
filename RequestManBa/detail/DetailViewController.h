//
//  DetailViewController.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "BaseViewController.h"
#import "RequestFileModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ItemItemChangeBlock)(ItemItem *itemItem);
@interface DetailViewController : BaseViewController
@property (nonatomic, strong) ItemItem *item;
@property (nonatomic, copy) ItemItemChangeBlock itemItemChangeBlock;
@end

NS_ASSUME_NONNULL_END
