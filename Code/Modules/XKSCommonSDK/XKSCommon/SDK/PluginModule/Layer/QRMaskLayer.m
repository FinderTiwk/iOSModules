//
//  QRMaskLayer.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "QRMaskLayer.h"

@implementation QRMaskLayer

+ (instancetype)layerWithSize:(CGSize)size edgeInsets:(UIEdgeInsets)edgeInsets{
    QRMaskLayer *layer = [super layer];
    layer.bounds       = (CGRect){CGPointZero,size};
    layer.anchorPoint  = CGPointZero;
    
    CGFloat top    = edgeInsets.top;
    CGFloat left   = edgeInsets.left;
    CGFloat bottom = edgeInsets.bottom;
    CGFloat right  = edgeInsets.right;

    UIColor *blurColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    { //中间显示区域
        CALayer *mask = [CALayer layer];
        mask.frame = (CGRect){{left,top},{size.width- left - right,size.height - top - bottom}};
        mask.backgroundColor = [UIColor blackColor].CGColor;
        [layer addSublayer:mask];
    }
    
    { //上半部分遮罩
        CALayer *mask = [CALayer layer];
        mask.frame = (CGRect){CGPointZero,{size.width,top}};
        mask.backgroundColor = blurColor.CGColor;
        [layer addSublayer:mask];
    }
    
    { //下半部分遮罩
        CALayer *mask = [CALayer layer];
        mask.frame = (CGRect){{0,size.height-bottom},{size.width,bottom}};
        mask.backgroundColor = blurColor.CGColor;
        [layer addSublayer:mask];
    }
    
    { //左半部分遮罩
        CALayer *mask = [CALayer layer];
        mask.frame = (CGRect){{0,top},{left,size.height - top - bottom}};
        mask.backgroundColor = blurColor.CGColor;
        [layer addSublayer:mask];   
    }
    
    { //右半部分遮罩
        CALayer *mask = [CALayer layer];
        mask.frame = (CGRect){{size.width-right,top},{right,size.height - top -bottom}};
        mask.backgroundColor = blurColor.CGColor;
        [layer addSublayer:mask];
    }
    
    return layer;
}

@end
