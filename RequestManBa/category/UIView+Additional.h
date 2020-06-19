//
//  UIView+Additional.h
//  
//
//  Created by 曾陆洋 on 15/7/13.
//  Copyright (c) 2015年 曾陆洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additional)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * ViewController for view
 */
@property(nonatomic,readonly)UIViewController* viewController;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/*设置阴影*/
- (void)shadowColor:(UIColor*)color shadowOffset:(CGSize)offset shadowRadius:(CGFloat)radius shadowOpacity:(CGFloat)opacity;

- (void)round;

- (void)roundWithCornerRadius:(CGFloat)cornerRadius;

- (void)roundWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (void)shake;

+ (instancetype)viewFromNib;

- (UIImage *)snapshot;

- (void)render:(id)model;
/**
 检查当前view是否显示在最前边
 */
- (BOOL)intersectWthView:(UIView *)view;

@end
