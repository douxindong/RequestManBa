//
//  DescpTableViewCell.h
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DescpTableViewCell : UITableViewCell
@property (nonatomic, strong) UITableView *tb;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
//@property (weak, nonatomic) IBOutlet UILabel *despLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstain;

@end

NS_ASSUME_NONNULL_END
