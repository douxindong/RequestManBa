//
//  HeaderItemTableViewCell.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *keyTextfield;

@property (weak, nonatomic) IBOutlet UIButton *addHeaderItemButton;
@property (weak, nonatomic) IBOutlet UITextField *valueTextfield;

@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;
@end

NS_ASSUME_NONNULL_END
