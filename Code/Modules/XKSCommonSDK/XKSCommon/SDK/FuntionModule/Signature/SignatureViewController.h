//
//  SignatureViewController.h
//  XKSCommonSDKDemo
//
//  Created by _Finder丶Tiwk on 16/1/21.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureViewController : UIViewController

/*! 是否显示左上角返回按钮*/ 
@property (nonatomic,assign) BOOL showBackButton;

/**
 *  @author _Finder丶Tiwk, 16-01-22 14:01:03
 *
 *  @brief 点击左上角返回按钮事件回调
 *  @since v0.1.0
 */
@property (nonatomic,copy) void (^dismissBlock)();
/**
 *  @author _Finder丶Tiwk, 16-01-22 14:01:22
 *
 *  @brief 点击确认按钮事件回调
 *  @since v0.1.0
 */
@property (nonatomic,copy) void (^submitBlock)(UIImage *image);

@end
