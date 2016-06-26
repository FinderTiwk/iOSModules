//
//  UIImage+Xkeshi.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSCommonEnumeration.h"

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:04
 *
 *  @brief 爱客仕图片方法扩展,方法名都以xks_为前缀
 *  @since v0.1.0
 */
@interface UIImage (Xkeshi)

/**
 *  @author _Finder丶Tiwk, 16-05-04 18:05:33
 *
 *  @brief 从指定Bundle中加载图片
 *  @param name       图片名称
 *  @param bundleName 资源Bundle名称
 *  @return 指定Bundle中的图片
 *  @since v1.0.0
 */
+ (UIImage *)xks_imageNamed:(NSString *)name fromBundle:(NSString *)bundleName;


/**
 *  @author _Finder丶Tiwk, 16-05-09 00:05:44
 *
 *  @brief 通过颜色生成一个图片
 *  @param color 颜色对象
 *  @return 颜色对应的图片
 *  @since v1.0.0
 */
+ (UIImage *)xks_imageWithColor:(UIColor *)color;

#pragma mark - 图片裁剪
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:34
 *
 *  @brief 返回一个从图片中点开始拉伸的图片
 *  @param image 原始图片
 *  @return 拉伸好的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_stretchImage:(UIImage *)image;
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:07
 *
 *  @brief 返回一个从图片中点开始拉伸的图片
 *  @param name 图片名称字符串
 *  @return 拉伸好的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_stretchImageWithName:(NSString *)name;

#pragma mark - 截屏
/**
 *  @author _Finder丶Tiwk, 16-01-12 17:01:13
 *
 *  @brief 将一个视图截图保存为图片
 *  @param aView 要截图的视图
 *  @return 图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_screenshotInView:(UIView *)aView;


#pragma mark - 打水印
/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:37
 *
 *  @brief 为一个图片打上水印
 *  @param imageName      要加水印的图片名称字符串
 *  @param waterImageName 水印图片名称字符串
 *  @param position       水印在图片上的位置
 *  @param scale          水印图片缩放比例
 *  @return 加水印的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_waterMarkWithName:(NSString *)imageName waterImageName:(NSString *)waterImageName position:(XKSRectPosition)position scale:(CGFloat)scale;
/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:06
 *
 *  @brief 为一个图片打上水印
 *  @param imageName      要加水印的图片名称字符串
 *  @param waterImageName 水印图片名称字符串
 *  @param position       水印在图片上的位置
 *  @return 加水印的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_waterMarkWithName:(NSString *)imageName waterImageName:(NSString *)waterImageName position:(XKSRectPosition)position;

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:54
 *
 *  @brief 为一个图片打上水印
 *  @param imageName      要加水印的图片名称字符串
 *  @param waterImageName 水印图片名称字符串
 *  @return 加水印的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_waterMarkWithName:(NSString *)imageName waterImageName:(NSString *)waterImageName;


/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:31
 *
 *  @brief 为一个图片打上水印
 *  @param image      要加水印的图片
 *  @param waterImage 水印图片
 *  @param position   水印在图片上的位置
 *  @param scale      水印图片缩放比例
 *  @return 加水印的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_waterMarkInImage:(UIImage *)image waterImage:(UIImage *)waterImage position:(XKSRectPosition)position scale:(CGFloat)scale;

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:18
 *
 *  @brief 为一个图片打上水印
 *  @param image      要加水印的图片
 *  @param waterImage 水印图片
 *  @param position   水印在图片上的位置
 *  @return 加水印的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_waterMarkInImage:(UIImage *)image waterImage:(UIImage *)waterImage position:(XKSRectPosition)position;

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:42
 *
 *  @brief 为一个图片打上水印
 *  @param image      要加水印的图片
 *  @param waterImage 水印图片
 *  @return 加水印的图片
 *  @since v0.1.0
 */
+ (UIImage *)xks_waterMarkInImage:(UIImage *)image waterImage:(UIImage *)waterImage;


@end
