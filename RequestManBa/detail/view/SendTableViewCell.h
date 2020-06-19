//
//  SendTableViewCell.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SendBlock)(void);
typedef void(^ChooseMethodBlock)(NSString *methodName);
@interface SendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *methodButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, copy) SendBlock sendBlock;
@property (nonatomic, copy) ChooseMethodBlock chooseMethodBlock;
@end

NS_ASSUME_NONNULL_END
