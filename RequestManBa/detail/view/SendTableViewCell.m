//
//  SendTableViewCell.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import "SendTableViewCell.h"

@interface SendTableViewCell ()<YBPopupMenuDelegate>

@end

@implementation SendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (NSArray *)titles{
    return @[@"GET",@"POST",@"PUT",@"HEAD",@"DELETE"];
}
- (IBAction)chooseMethod:(id)sender {
    [YBPopupMenu showRelyOnView1:sender titles:[self titles] icons:nil menuWidth:100 delegate:self];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    CBInvokeBlock(_chooseMethodBlock,[self titles][index]);
}
- (IBAction)send:(id)sender {
    CBInvokeBlock(_sendBlock);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
