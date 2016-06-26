//
//  UIImage+Xkeshi.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "UIImage+Xkeshi.h"
#import "XKSCommonFunction.h"

@implementation UIImage (Xkeshi)

+ (UIImage *)xks_imageNamed:(NSString *)name fromBundle:(NSString *)bundleName{
    NSBundle *bundle = externBundle(bundleName);
    if (!bundle) {
        return [self imageNamed:name];
    }else{
        return [self imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    }

}

+ (UIImage *)xks_imageWithColor:(UIColor *)color{
    CGRect rect = (CGRect){CGPointZero,(CGSize){1,1}};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 图片裁剪
+ (UIImage *)xks_stretchImage:(UIImage *)image{
    return [self xks_stretchImage:image leftRatio:0.5 topRatio:0.5];
}

+ (UIImage *)xks_stretchImageWithName:(NSString *)name{
    return [self xks_stretchImageWithName:name leftRatio:0.5 topRatio:0.5];
}

+ (UIImage *)xks_stretchImageWithName:(NSString *)name leftRatio:(CGFloat)left topRatio:(CGFloat)top{
    UIImage *image   = [UIImage imageNamed:name];
    if (!image) {
        NSAssert(NO, @"没有找<%@>到对应的图片",name);
    }
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)xks_stretchImage:(UIImage *)image leftRatio:(CGFloat)left topRatio:(CGFloat)top{
    NSAssert(image, @"图片不能为空");
    NSAssert(left>0 && left<1, @"leftRatio 必须是 0~1之间的小数");
    NSAssert(top>0 && top<1, @"topRatio 必须是 0~1之间的小数");
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

#pragma mark - 截屏
+ (UIImage *)xks_screenshotInView:(UIView *)aView{
    UIGraphicsBeginImageContext(aView.bounds.size);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  screenshot;
}


#pragma mark - 打水印
+ (UIImage *)xks_waterMarkInImage:(UIImage *)image waterImage:(UIImage *)waterImage position:(XKSRectPosition)position scale:(CGFloat)scale{
    
    NSAssert(image, @"原始图片为空");
    NSAssert(waterImage, @"水印图片为空");
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    //1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
    
    CGFloat waterW = waterImage.size.width;
    CGFloat WaterH = waterImage.size.height;

    CGFloat padding=10;
    CGFloat cW = waterW * scale;
    CGFloat cH = WaterH * scale;
    CGFloat cX = 0;
    CGFloat cY = 0;

    //根据水印的位置,计算水印所要打在的地方
    if (position == XKSRectPositionTopLeft) {
        cX = padding;
        cY = padding;
    }
    
    if (position == XKSRectPositionTopRight) {
        cX = (imageW - cW - padding);
        cY = padding;
    }
    
    if (position == XKSRectPositionCenter) {
        cX = (imageW - cW)/2;
        cY = (imageH - cH)/2;
    }
    
    if (position == XKSRectPositionBottomLeft) {
        cX = padding;
        cY = (imageH-cH-padding);
    }
    
    if (position == XKSRectPositionBottomRight) {
        cX = (imageW-cW-padding);
        cY = (imageH-cH-padding);
    }
    
    [waterImage drawInRect:CGRectMake(cX, cY, cW, cH)];
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)xks_waterMarkInImage:(UIImage *)image waterImage:(UIImage *)waterImage position:(XKSRectPosition)position{
    return [self xks_waterMarkInImage:image waterImage:waterImage position:position scale:1];
}

+ (UIImage *)xks_waterMarkInImage:(UIImage *)image waterImage:(UIImage *)waterImage{
    return [self xks_waterMarkInImage:image waterImage:waterImage position:XKSRectPositionDefault];
}

+ (UIImage *)xks_waterMarkWithName:(NSString *)imageName waterImageName:(NSString *)waterImageName position:(XKSRectPosition)position scale:(CGFloat)scale{
    UIImage *image      = [UIImage imageNamed:imageName];
    UIImage *waterImage = [UIImage imageNamed:waterImageName];
    return [self xks_waterMarkInImage:image waterImage:waterImage position:position scale:scale];
}

+ (UIImage *)xks_waterMarkWithName:(NSString *)imageName waterImageName:(NSString *)waterImageName position:(XKSRectPosition)position{
    return [self xks_waterMarkWithName:imageName waterImageName:waterImageName position:position scale:1];
}

+ (UIImage *)xks_waterMarkWithName:(NSString *)imageName waterImageName:(NSString *)waterImageName{
    return [self xks_waterMarkWithName:imageName waterImageName:waterImageName position:XKSRectPositionDefault];
}

@end
