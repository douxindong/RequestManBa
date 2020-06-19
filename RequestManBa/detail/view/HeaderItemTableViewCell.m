//
//  HeaderItemTableViewCell.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import "HeaderItemTableViewCell.h"

@implementation HeaderItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.enableSwitch.transform = CGAffineTransformMakeScale( 0.7, 0.7);//缩放
}
- (IBAction)addHeaderItemButtonClick:(id)sender {
}

- (IBAction)enableSwitchClick:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
