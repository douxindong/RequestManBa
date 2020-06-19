//
//  DetailViewDataSource.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestFileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>
- (instancetype)initWithItem:(ItemItem *)item;
- (void)bindTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
