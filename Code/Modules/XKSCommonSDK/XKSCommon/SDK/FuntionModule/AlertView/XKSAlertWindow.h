//
//  XKSAlertWindow.h
//  TestCAShapeLayer
//
//  Created by _Finder丶Tiwk on 16/1/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSCommonEnumeration.h"

/**
 *  @author _Finder丶Tiwk, 16-01-19 13:01:09
 *
 *  @brief 通用弹出框（此弹出的UIWindow的Level高达CGFLOAT_MAX,可保证永远出现视图的最顶层）
 *  @since v0.1.0
 */
@interface XKSAlertWindow : NSObject

#pragma mark - 默认按钮标题(确定,取消)

/**
 *  @author _Finder丶Tiwk, 16-05-09 16:05:50
 *
 *  @brief 弹出提示弹窗(主标题与提示内容,只有确定按钮)
 *  @param title   主标题
 *  @param message 提示内容
 *  @since v1.0.0
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message;

/**
 *  @author _Finder丶Tiwk, 16-05-09 16:05:50
 *
 *  @brief 弹出提示弹窗(主标题与提示内容,只有确定按钮)
 *  @param title   主标题
 *  @param message 提示内容
 *  @param action  确定按钮点击事件
 *  @since v1.0.0
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
               action:(void(^)())action;

/**
 *  @author _Finder丶Tiwk, 16-05-09 16:05:50
 *
 *  @brief 弹出提示弹窗(主标题与提示内容,有确定按钮与取消按钮)
 *  @param title   主标题
 *  @param message 提示内容
 *  @param action  确定按钮点击事件
 *  @param cancle  取消按钮点击事件
 *  @since v1.0.0
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
               action:(void(^)())action
               cancle:(void(^)())cancle;

/**
 *  @author _Finder丶Tiwk, 16-01-17 18:01:33
 *
 *  @brief 弹出提示弹窗(只有确定按钮)
 *  @param type    提示弹窗样式
 *  @param message 提示信息
 *  @since v0.1.0
 */
+ (void)showWithType:(XKSAlertType)type
             message:(NSString *)message;

/**
 *  @author _Finder丶Tiwk, 16-01-17 18:01:45
 *
 *  @brief 弹出提示弹窗(只有确定按钮)
 *  @param type    提示弹窗样式
 *  @param message 提示信息
 *  @param action  确定按钮点击事件
 *  @since v0.1.0
 */
+ (void)showWithType:(XKSAlertType)type
             message:(NSString *)message
              action:(void (^)())action;

/**
 *  @author _Finder丶Tiwk, 16-01-17 18:01:30
 *
 *  @brief 弹出提示弹窗(如果Cancle Block不为nil,刚显示取消按钮)
 *  @param type    提示弹窗样式
 *  @param message 提示信息
 *  @param action  确定按钮点击事件
 *  @param cancle  取消按钮点击事件
 *  @since v0.1.0
 */
+ (void)showWithType:(XKSAlertType)type
             message:(NSString *)message
              action:(void (^)())action
              cancle:(void (^)())cancle;


#pragma mark - 下面的方法适用于自定义按钮标题
// t1 为确定按钮的标题  （右边按钮）
// t2 为取消按钮的标题  （左边按钮）

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
                   t1:(NSString *)t1;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
               action:(void(^)())action
                   t1:(NSString *)t1;


+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
               action:(void(^)())action
                   t1:(NSString *)t1
               cancle:(void(^)())cancle
                   t2:(NSString *)t2;


+ (void)showWithType:(XKSAlertType)type
             message:(NSString *)message
              t1:(NSString *)t1;

+ (void)showWithType:(XKSAlertType)type
             message:(NSString *)message
              action:(void (^)())action
              t1:(NSString *)t1;


+ (void)showWithType:(XKSAlertType)type
             message:(NSString *)message
              action:(void (^)())action
              t1:(NSString *)t1
              cancle:(void (^)())cancle
              t2:(NSString *)t2;

@end
