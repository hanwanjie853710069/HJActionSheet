//
//  HJActionSheet.m
//  HJSelector
//
//  Created by 王木木 on 2018/3/26.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

#import "HJActionSheet.h"
#import "UIView+Extension.h"
#define CELLSEPARATORLCOLOR [UIColor colorWithRed:188/255.0 green:187/255.0 blue:192/255.0 alpha:1.0]

@interface HJActionSheet ()
{
    CGFloat _screenWidth;         /**< 屏幕的宽 */
    
    CGFloat _screenHeight;        /**< 屏幕的高 */
    
    UIView *_itemsView;           /**< 整个sheet的view */
    
    BOOL _destructiveButtonTitle; /**< 是否存在描述按钮 */
}

/** 当前弹出试图的 window */
@property (nonatomic,strong) UIWindow *window;

/** 代理 */
@property (nonatomic,assign) id<HJActionSheetDelegate>delegate;

@end

@implementation HJActionSheet

-(UIWindow *)window
{
    
    return [[UIApplication sharedApplication] delegate].window;
}

-(id)initWithTitle:(NSString *)title
          delegate:(id<HJActionSheetDelegate>)delegate
 cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
 otherButtonTitles:(NSString *)otherButtonTitles,...
{
    self = [super init];
    
    if (self) {
        
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        //初始化背景
        self.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
        
        //背景点击
        UIButton *bgButton = [[UIButton alloc] initWithFrame:self.frame];
        [bgButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        bgButton.tag = 999998;
        [self addSubview:bgButton];
        
        
        _itemsView = [[UIView alloc]initWithFrame:CGRectMake(8, _screenHeight, _screenWidth-16, 45)];
        [self addSubview:_itemsView];
        
        //title 和 otherButton的View
        UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _itemsView.width, 45)];
        otherView.backgroundColor = [UIColor clearColor];
        otherView.layer.cornerRadius = 5.0;
        otherView.layer.masksToBounds = YES;
        [_itemsView addSubview:otherView];
        
        //总得高度
        CGFloat height = 0.0;
        
        //title
        if (title) {
            
            //计算文本高度
            CGFloat labelHeight = [self getSizeByString:title].height;
            
            //label的view
            UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, otherView.width, labelHeight+30)];
            labelView.backgroundColor = [UIColor whiteColor];
            [otherView addSubview:labelView];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, labelView.width-30, labelHeight)];
            label.text = title;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label.numberOfLines = 5;
            label.textColor = [UIColor grayColor];
            [labelView addSubview:label];
            
            height += labelView.maxY;
            
            //直线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height, otherView.width, 0.5)];
            lineView.backgroundColor = CELLSEPARATORLCOLOR;
            [otherView addSubview:lineView];
            
            height += lineView.height;
        }
        
        
        //destructive
        if (destructiveButtonTitle) {
            
            _destructiveButtonTitle = YES;
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, height, otherView.width, 45)];
            [button setTitle:destructiveButtonTitle forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            button.backgroundColor = [UIColor whiteColor];
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
            button.tag = 1000000;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [otherView addSubview:button];
            
            height += button.height;
            
            //直线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height, otherView.width, 0.5)];
            lineView.backgroundColor = CELLSEPARATORLCOLOR;
            [otherView addSubview:lineView];
            height += lineView.height;
            
        }
        
        //获取 参数数组
        NSMutableArray *otherButtons = [[NSMutableArray alloc] init];
        va_list params; //定义一个指向个数可变的参数列表指针;
        va_start(params,otherButtonTitles);//va_start 得到第一个可变参数地址,
        NSString *arg;
        if (otherButtonTitles) {
            //将第一个参数添加到array
            NSString *prev = otherButtonTitles;
            [otherButtons addObject:prev];
            //va_arg 指向下一个参数地址
            while((arg = va_arg(params,NSString*))){
                if (arg){
                    [otherButtons addObject:arg];
                }
            }
            //置空
            va_end(params);
        }
        
        //otherButtonTitles
        if (otherButtons.count > 0) {
            for (int i = 0; i < otherButtons.count; i ++) {
                
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, height, otherView.width, 45)];
                [button setTitle:otherButtons[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
                button.backgroundColor = [UIColor whiteColor];
                button.titleLabel.font = [UIFont systemFontOfSize:18];
                button.tag = i+1000001;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [otherView addSubview:button];
                
                height += button.height;
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height, otherView.width, 0.5)];
                lineView.backgroundColor = CELLSEPARATORLCOLOR;
                [otherView addSubview:lineView];
                height += lineView.height;
            }
        }
        
        otherView.height = height;
        
        //cancelButtonTitle
        if (cancelButtonTitle) {
            UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, height+7.5, _screenWidth-16, 45)];
            cancelButton.layer.cornerRadius = 5.0;
            cancelButton.layer.masksToBounds = YES;
            [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
            cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
            cancelButton.backgroundColor = [UIColor whiteColor];
            cancelButton.tag = 999999;
            [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_itemsView addSubview:cancelButton];
            
            height += 51;
        }
        
        _itemsView.height = height;
        
        
    }
    
    [self.window addSubview:self];
    
    return self;
}

#pragma mark -- 弹出动画
-(void)animation
{
    CGRect frame = _itemsView.frame;
    frame.origin.y = _screenHeight - _itemsView.frame.size.height-10;
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        _itemsView.frame = frame;
    }];
}

#pragma mark - 计算文字所占空间的方法
-(CGSize)getSizeByString:(NSString*)string
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(_screenWidth-16-30, 999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    return size;
}

-(void)show
{
    [self animation];
}

#pragma mark -- buttonClick
-(void)buttonClick:(UIButton *)btn
{
    //返回按钮
    if (btn.tag == 999999 || btn.tag == 999998) {
        
        [self cancel];
        
        return;
    }
    
    //item按钮
    if (btn.tag >= 1000000) {
        
        CGRect frame = _itemsView.frame;
        frame.origin.y = _screenHeight;
        
        [UIView animateWithDuration:0.2 animations:^{
            _itemsView.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
                
                if ([self.delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
                    if (_destructiveButtonTitle) {
                        [self.delegate actionSheet:self didDismissWithButtonIndex:btn.tag - 1000000];
                    }else {
                        [self.delegate actionSheet:self didDismissWithButtonIndex:btn.tag - 1000001];
                    }
                }
            }];
        }];
        
        return;
    }
}

#pragma mark -- cancel
-(void)cancel
{
    CGRect frame = _itemsView.frame;
    frame.origin.y = _screenHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        _itemsView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
    
            [self removeFromSuperview];
            if ([self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
                [self.delegate actionSheetCancel:self];
            }
        }];
    }];
}

#pragma mark -- 根据uicolor 生成图片
-(UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 5.0;
    CGFloat imageH = 5.0;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)dealloc
{
    NSLog(@"释放了");
}

@end
