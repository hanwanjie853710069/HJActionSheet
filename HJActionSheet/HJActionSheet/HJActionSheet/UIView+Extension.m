//
//  UIView+Extension.m
//
//  Created by 王木木 on 2018/3/26.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

#import "UIView+Extension.h"
#define SCREEN_SCALE [UIScreen mainScreen].scale                // 点相对于不同屏幕的缩放比例

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    self.width = size.width;
    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(UIViewController *)viewController
{
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[UIViewController class]])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}


#pragma mark - 圆角


- (void)sc_addCornerWithRadius:(CGFloat ) radius{
    [self sc_addCornerWithRadius:radius borderWidth:1.0 backgroundColor:[UIColor clearColor] borderColor:[UIColor blackColor]];
}

- (void)sc_addCornerWithRadius:(CGFloat ) radius borderWidth:(CGFloat ) borderWidth backgroundColor:(UIColor *) backgroundColor borderColor:(UIColor *) borderColor{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self sc_drawRectWithRoundedCornerRadius:radius borderWidth:borderWidth backgroundColor:backgroundColor borderColor:borderColor]];
        imageView.tag = 1111;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insertSubview:imageView atIndex:0];
        });
    });
}


- (UIImage *)sc_drawRectWithRoundedCornerRadius:(CGFloat ) radius borderWidth:(CGFloat ) borderWidth backgroundColor:(UIColor *) backgroundColor borderColor:(UIColor *) borderColor{
    
    CGSize sizeToFit = CGSizeMake([self pixelWithNum:self.width], self.height);
    
    CGFloat halfBorderWidth = borderWidth * 0.5;
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, SCREEN_SCALE);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    
    CGFloat width = sizeToFit.width, height = sizeToFit.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);   // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);                             // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius);                                              // 左下角角度
    
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius);                                                       // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius);                                                     // 右上角

    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}


#pragma mark - 私有方法
- (double)roundbyunitWithNum:(double) num unit:(double) unit {
    double remain = modf(num, &unit);
    if (remain > unit / 2.0) {
        return [self ceilbyunitWithNum:num unit:unit];
    }else{
        return [self floorbyunitWithnum:num unit:unit];
    }
}

- (double)ceilbyunitWithNum:(double) num unit:(double) unit{
    return num - modf(num, &unit) + unit;
}

- (double)floorbyunitWithnum:(double) num unit:(double) unit {
    return num - modf(num, &unit);
}

- (double)pixelWithNum:(double) num {
    double unit;
    switch ((int)SCREEN_SCALE) {
        case 1: unit = 1.0 / 1.0;  break;
        case 2: unit = 1.0 / 2.0;  break;
        case 3: unit = 1.0 / 3.0;  break;
        default: unit = 0.0;       break;
    }
    return [self roundbyunitWithNum:num unit:unit];
}


@end
