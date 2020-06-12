//
//  DescpTableViewCell.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import "DescpTableViewCell.h"

@interface DescpTableViewCell ()<UITextViewDelegate>
@end

@implementation DescpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//自适应高度的
- (void)textViewDidChange:(UITextView *)textView{
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)];
    CGFloat height = size.height;
    if (height < 50) {
        self.heightConstain.constant = 50;
    }else{
        self.heightConstain.constant = height;
    }
    [UIView performWithoutAnimation:^{
        if (@available(iOS 11.0, *)) {
            [self.tb performBatchUpdates:nil completion:nil];
        } else {
            // Fallback on earlier versions
        }
        [textView sizeToFit];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
