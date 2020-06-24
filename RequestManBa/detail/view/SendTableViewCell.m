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
    [self.urlTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    self.methodButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}
- (void)textChange:(UITextField *)textfiled{
    if (textfiled == self.urlTextField) {
        _request.url.raw = textfiled.text;
    }
    CBInvokeBlock(_requestChangeBlock,_request);
}
- (IBAction)chooseMethod:(id)sender {
    [YBPopupMenu showRelyOnView1:sender titles:[RequestTool methods] icons:nil menuWidth:100 delegate:self];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    _request.method = [RequestTool methods][index];
    [self.methodButton setTitle:_request.method forState:UIControlStateNormal];
    CBInvokeBlock(_requestChangeBlock,_request);
}
- (IBAction)send:(id)sender {
    CBInvokeBlock(_sendBlock);
}
- (void)setRequest:(Request *)request{
    _request = request;
    [self.methodButton setTitle:_request.method forState:UIControlStateNormal];
    self.urlTextField.text = _request.url.raw;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
