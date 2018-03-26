//
//  ViewController.m
//  HJActionSheet
//
//  Created by Mr.H on 2018/3/26.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

#import "ViewController.h"
#import "HJActionSheet/HJActionSheet.h"
@interface ViewController ()<HJActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    
    label.text = @"请点击屏幕";
    
    label.font = [UIFont systemFontOfSize:30];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor redColor];
    
    [self.view addSubview:label];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    HJActionSheet *actionSheet = [[HJActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"按钮一",@"按钮二",@"按钮三",nil];
    
    [actionSheet show];
    
}

#pragma mark -- HJActionSheetDelegate代理
- (void)actionSheetCancel:(HJActionSheet *)actionSheet {
    
    
}

- (void)actionSheet:(HJActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld",buttonIndex);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
