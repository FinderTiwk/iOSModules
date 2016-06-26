//
//  XKSShapeLayer.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/17.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 *  @author _Finder丶Tiwk, 16-01-19 14:01:03
 *
 *  @brief ShapeLayer类型
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger,XKSShapeLayerType) {
    /*! 圆圈对勾*/
    XKSShapeLayerType_SUCCESS,
    /*! 圆角矩形里面一个叉*/
    XKSShapeLayerType_FAILURE,
    /*! 三角形里面一个叹号*/
    XKSShapeLayerType_WARNING
};

/**
 *  @author _Finder丶Tiwk, 16-01-19 14:01:44
 *
 *  @brief 用来做动画的形状图层
 *  @since v0.1.0
 */
@interface XKSShapeLayer : CAShapeLayer


/**
*  @author _Finder丶Tiwk, 16-01-21 00:01:27
*
*  @brief 类实例方法
*  @param radius    半径
*  @param color     shapeLayer颜色
*  @param lineWidth 线宽
*  @param type      shapeLayer的类
*  @return 实例对象
*  @since v0.1.0
*/
+ (instancetype)layerWithRadius:(CGFloat)radius
                          color:(UIColor *)color
                      lineWidth:(CGFloat)lineWidth
                           type:(XKSShapeLayerType)type;


/**
 *  @author _Finder丶Tiwk, 16-01-19 14:01:11
 *
 *  @brief 类实例方法
 *  @param radius    半径
 *  @param color     shapeLayer颜色
 *  @param lineWidth 线宽
 *  @param type      shapeLayer的类型
 *  @param duration  动画持续时间
 *  @return 实例对象
 *  @since v0.1.0
 */
+ (instancetype)layerWithRadius:(CGFloat)radius
                          color:(UIColor *)color
                      lineWidth:(CGFloat)lineWidth
                           type:(XKSShapeLayerType)type
                       duration:(CFTimeInterval)duration;

@end
