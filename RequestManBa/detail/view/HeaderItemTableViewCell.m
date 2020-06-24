//
//  HeaderItemTableViewCell.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import "HeaderItemTableViewCell.h"

@interface HeaderItemTableViewCell ()

@end

@implementation HeaderItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.enableSwitch.transform = CGAffineTransformMakeScale( 0.7, 0.7);//缩放

    [self.keyTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.valueTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)addHeaderItemButtonClick:(UISwitch *)sender {
    CBInvokeBlock(_addItemBlock);
}

- (IBAction)enableSwitchClick:(UISwitch *)sender {
    _valueItem.enabled = sender.isOn;
    CBInvokeBlock(_valuesItemChangeBlock,_valueItem);
}
- (void)setValueItem:(ValuesItem *)valueItem{
    _valueItem = valueItem;
    self.keyTextfield.text = _valueItem.key;
    self.valueTextfield.text = _valueItem.value;
    self.enableSwitch.on = _valueItem.enabled;
}
- (void)textChange:(UITextField *)textfiled{
    if (textfiled == self.keyTextfield) {
        _valueItem.key = textfiled.text;
    }else if (textfiled == self.valueTextfield){
        _valueItem.value = textfiled.text;
    }
    CBInvokeBlock(_valuesItemChangeBlock,_valueItem);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
