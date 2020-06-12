//
//  DTableViewCell.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/12.
//  Copyright © 2020 maba. All rights reserved.
//

#import "DTableViewCell.h"

@interface DTableViewCell ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;

@end

@implementation DTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
            make.height.offset(100);
        }];
    }
    return self;
    
}
-(UITextView *)textView{
    if (!_textView) {
        //http://www.cnblogs.com/xiaofeixiang/
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(30, 200, CGRectGetWidth([[UIScreen mainScreen] bounds])-60, 30)];
        [_textView setTextColor:[UIColor redColor]];
        _textView.text = @"shhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhhshhahshahshahsahshhh";
        [_textView.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [_textView setFont:[UIFont systemFontOfSize:15]];
        [_textView.layer setBorderWidth:1.0f];
        [_textView setDelegate:self];
        _textView.scrollEnabled = NO;
    }
    return _textView;
}
-(void)textViewDidChange:(UITextView *)textView{
    //博客园-FlyElephant
    static CGFloat maxHeight =60.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
//        if (size.height >= maxHeight)
//        {
//            size.height = maxHeight;
//            textView.scrollEnabled = YES;   // 允许滚动
//        }
//        else
//        {
//            textView.scrollEnabled = NO;    // 不允许滚动
//        }
    }
//    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(size.height);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
