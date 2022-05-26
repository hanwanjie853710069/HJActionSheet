//
//  HJActionSheet.h
//  HJSelector
//
//  Created by 王木木 on 2018/3/26.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJActionSheet;

//协议
@protocol HJActionSheetDelegate <NSObject>

@optional

/**
 *  actionsheet 消失
 *
 *  @param actionSheet ActionSheet
 */
- (void)actionSheetCancel:(HJActionSheet *)actionSheet;

/**
 *  确定按钮点击
 *
 *  @param actionSheet ActionSheet
 *  @param buttonIndex button的点击 tag值  从上到下  0 ++
 */
- (void)actionSheet:(HJActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface HJActionSheet : UIView

/**
 *初始化 customActionSheet
 *title  标题
 *delegate  协议代理
 *cancelButtonTitle  返回按钮标题
 *destructiveButtonTitle  强调按钮标题
 *otherButtonTitles  其他按钮 <数组>
 */
- (id)initWithTitle:(NSString *)title
           delegate:(id<HJActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles,...;

-(void)show;

/**
 *  取消
 */
-(void)cancel;

@end



/// 测试
