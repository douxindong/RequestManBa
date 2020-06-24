//
//  HeaderItemTableViewCell.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddItemBlock)(void);
typedef void(^ValuesItemChangeBlock)(ValuesItem *valueItem);

@interface HeaderItemTableViewCell : UITableViewCell
@property (nonatomic, strong) ValuesItem *valueItem;
@property (weak, nonatomic) IBOutlet UITextField *keyTextfield;

@property (weak, nonatomic) IBOutlet UIButton *addHeaderItemButton;
@property (weak, nonatomic) IBOutlet UITextField *valueTextfield;

@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;

@property (nonatomic, copy) AddItemBlock addItemBlock;
@property (nonatomic, copy) ValuesItemChangeBlock valuesItemChangeBlock;
@end

NS_ASSUME_NONNULL_END
