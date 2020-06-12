//
//  SendTableViewCell.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *methodButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIMenu *inlineMenu;

@end

NS_ASSUME_NONNULL_END
