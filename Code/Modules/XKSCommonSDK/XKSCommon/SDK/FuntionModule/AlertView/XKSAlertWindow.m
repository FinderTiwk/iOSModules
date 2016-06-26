//
//  XKSAlertWindow.m
//  TestCAShapeLayer
//
//  Created by _Finder丶Tiwk on 16/1/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSCommonFunction.h"
#import "XKSAlertWindow.h"
#import "XKSShapeLayer.h"

/*! 弹窗窗体 Tag*/
NSUInteger kXKSAlertView_SUB_TAG = 10;
/*! 主标题Label Tag*/
NSUInteger kXKSAlertView_SUB_TAG_0 = 100;
/*! 动画Layer所在的视图 Tag*/
NSUInteger kXKSAlertView_SUB_TAG_1 = 101;
/*! 提示内容Label Tag*/
NSUInteger kXKSAlertView_SUB_TAG_2 = 102;
/*! 确定按钮 Tag*/
NSUInteger kXKSAlertView_SUB_TAG_3 = 103;
/*! 取消按钮 Tag*/
NSUInteger kXKSAlertView_SUB_TAG_4 = 104;

@implementation XKSAlertWindow

static XKSEmptyBlock _closeAction;
static XKSEmptyBlock _cancleAction;

static UIWindow *_alertWindow;
static UIViewController *_rootViewController;

#pragma mark - 生命周期
+ (UIWindow *)alertWindow{
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.windowLevel = CGFLOAT_MAX;
    }
    return _alertWindow;
}

+ (void)alertViewWithIndex:(NSUInteger)index t1:(NSString *)t1 t2:(NSString *)t2{
    
    _rootViewController = [[UIViewController alloc] init];
    
    NSArray *array  = xibArray(XKSCommonSDKBundleName, @"XKSAlertView");

    UIView *alert = array[index];
    
    alert.frame = [UIScreen mainScreen].bounds;
    
    {//主窗体样式
        UIView *container             = [alert viewWithTag:kXKSAlertView_SUB_TAG];
        container.layer.cornerRadius  = 8;
        container.layer.shadowColor   = [UIColor blackColor].CGColor;
        container.layer.shadowOffset  = CGSizeMake(0, 5);
        container.layer.shadowOpacity = 0.3f;
        container.layer.shadowRadius  = 10.0f;
        container.layer.masksToBounds = YES;
        
        //缩放动画
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.duration = 0.2f;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [container.layer addAnimation:scaleAnimation forKey:nil];
    }
    
    {//确定按钮
        UIButton *button  = (UIButton *)[alert viewWithTag:kXKSAlertView_SUB_TAG_3];
        if (isStringWithAnyText(t1)) {
            [button setTitle:t1 forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {//取消按钮
        UIButton *button  = (UIButton *)[alert viewWithTag:kXKSAlertView_SUB_TAG_4];
        if (isStringWithAnyText(t2)) {
            [button setTitle:t2 forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    alert.tag = 10086;
    _rootViewController.view = alert;

    [self alertWindow].rootViewController = _rootViewController;
}

#pragma mark - 对外暴露API方法
#pragma mark 样式一：主标题与内容

+ (void)showWithTitle:(NSString *)title message:(NSString *)message{
    [self showWithTitle:title message:message action:NULL];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message action:(void (^)())action{
    [self showWithTitle:title message:message action:action cancle:NULL];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message action:(void (^)())action cancle:(void (^)())cancle{
    [self showWithTitle:title message:message action:action t1:nil cancle:cancle t2:nil];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message t1:(NSString *)t1{
    [self showWithTitle:title message:message action:NULL t1:t1];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message action:(void (^)())action t1:(NSString *)t1{
    [self showWithTitle:title message:message action:action t1:title cancle:NULL t2:nil];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message action:(void (^)())action t1:(NSString *)t1 cancle:(void (^)())cancle t2:(NSString *)t2{
    if (cancle && action) {
        [self alertViewWithIndex:1 t1:t1 t2:t2];
    }else{
        [self alertViewWithIndex:0 t1:t1 t2:t2];
    }
    _closeAction  = action;
    _cancleAction = cancle;
    
    UIView *alert = [_rootViewController.view viewWithTag:10086];
    UILabel *titleLabel = [alert viewWithTag:kXKSAlertView_SUB_TAG_0];
    titleLabel.text     = title;
    
    UILabel *messageLabel = (UILabel *)[alert viewWithTag:kXKSAlertView_SUB_TAG_2];
    messageLabel.text     = message;
    [UIView animateWithDuration:0.2 animations:^{
        [self alertWindow].hidden = NO;
        [self alertWindow].backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.2];
    }];
}

#pragma mark 样式二：主标题与内容
+ (void)showWithType:(XKSAlertType)type message:(NSString *)message{
    [self showWithType:type message:message action:NULL];
}

+ (void)showWithType:(XKSAlertType)type message:(NSString *)message action:(void (^)())action{
    [self showWithType:type message:message action:action cancle:NULL];
}

+ (void)showWithType:(XKSAlertType)type message:(NSString *)message action:(void (^)())action cancle:(void (^)())cancle{
    
    [self showWithType:type message:message action:action t1:nil cancle:cancle t2:nil];
}

+ (void)showWithType:(XKSAlertType)type message:(NSString *)message t1:(NSString *)t1{
    [self showWithType:type message:message action:nil t1:t1];
}

+ (void)showWithType:(XKSAlertType)type message:(NSString *)message action:(void (^)())action t1:(NSString *)t1{
    [self showWithType:type message:message action:action t1:t1 cancle:nil t2:nil];
}

+ (void)showWithType:(XKSAlertType)type message:(NSString *)message action:(void (^)())action t1:(NSString *)t1 cancle:(void (^)())cancle t2:(NSString *)t2{
    if (cancle && action) {
        [self alertViewWithIndex:3 t1:t1 t2:t2];
    }else{
        [self alertViewWithIndex:2 t1:t1 t2:t2];
    }
    _closeAction  = action;
    _cancleAction = cancle;
    
    UIView *alert = [_rootViewController.view viewWithTag:10086];
    UIView *shapeView   = [alert viewWithTag:kXKSAlertView_SUB_TAG_1];
    CGFloat radius      = shapeView.frame.size.width/2;
    
    XKSShapeLayer *layer;
    CGFloat lineWidth = 3;
    UIColor *lineColor = [UIColor greenColor];
    XKSShapeLayerType layerType = XKSShapeLayerType_SUCCESS;
    if (type == XKSAlertType_SUCCESS) {
        layerType = XKSShapeLayerType_SUCCESS;
        lineColor = [UIColor greenColor];
    }
    if (type == XKSAlertType_FAILURE) {
        layerType = XKSShapeLayerType_FAILURE;
        lineColor = [UIColor redColor];
    }
    if (type == XKSAlertType_WARNING) {
        layerType = XKSShapeLayerType_WARNING;
        lineColor = [UIColor orangeColor];
    }
    layer = [XKSShapeLayer layerWithRadius:radius color:lineColor lineWidth:lineWidth type:layerType];
    [shapeView.layer addSublayer:layer];
    
    UILabel *messageLabel = (UILabel *)[alert viewWithTag:kXKSAlertView_SUB_TAG_2];
    messageLabel.text     = message;
    [UIView animateWithDuration:0.2 animations:^{
        [self alertWindow].hidden = NO;
        [self alertWindow].backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.2];
    }];
}

#pragma mark - 按钮点击事件
+ (void)buttonAction:(UIButton *)sender{
    _alertWindow.hidden = YES;
    NSUInteger tag      = sender.tag;
    if (tag == kXKSAlertView_SUB_TAG_3) {
        if (_closeAction) {
            _closeAction();
        }
    }else{
        if (_cancleAction) {
            _cancleAction();
        }
    }
    _closeAction  = NULL;
    _cancleAction = NULL;
    _alertWindow  = nil;
    _rootViewController =nil;
}

@end
