//
//  UIView+Extension.h
//
//  Created by 王木木 on 2018/3/26.
//  Copyright © 2018年 Mr.H. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  UIView的x
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  UIView的y
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  UIView最大的x
 */
@property (nonatomic, assign) CGFloat maxX;
/**
 *  UIView最大的y
 */
@property (nonatomic, assign) CGFloat maxY;
/**
 *  UIView中心x
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  UIView中心y
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  UIView的宽
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  UIView的高
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  UIView的尺寸
 */
@property (nonatomic, assign) CGSize size;

#pragma mark - 获取到当前view所在的控制器

/**
 *  当前view的controller
 *
 *  @return UIViewController
 */
- (UIViewController *)viewController;

#pragma mark - 绘制圆角（控件本身不能设置backgroundColor）

/**
 *  给控件添加默认圆角（填充色为clear，边框色为黑色）
 *
 *  @param radius 圆角度
 */
- (void)sc_addCornerWithRadius:(CGFloat ) radius;

/**
 *  自定义控件添加圆角
 *
 *  @param radius          圆角度
 *  @param borderWidth     边框宽度
 *  @param backgroundColor 圆角内填充色，可用于控件的底色backgroundColor
 *  @param borderColor     边框的颜色
 */
- (void)sc_addCornerWithRadius:(CGFloat ) radius borderWidth:(CGFloat ) borderWidth backgroundColor:(UIColor *) backgroundColor borderColor:(UIColor *) borderColor;


@end
