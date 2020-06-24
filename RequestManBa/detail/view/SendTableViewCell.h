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
typedef void(^RequestChangeBlock)(Request *request);
@interface SendTableViewCell : UITableViewCell
@property (nonatomic, strong) Request *request;
@property (weak, nonatomic) IBOutlet UIButton *methodButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, copy) SendBlock sendBlock;
@property (nonatomic, copy) RequestChangeBlock requestChangeBlock;
@end

NS_ASSUME_NONNULL_END
