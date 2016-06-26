//
//  QRMaskLayer.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/**
 *  @author _Finder丶Tiwk, 16-01-21 11:01:19
 *
 *  @brief 自定义遮罩层(四边半透明,中间完全透明)
 *  @since v0.1.0
 */
@interface QRMaskLayer : CALayer

/**
 *  @author _Finder丶Tiwk, 16-02-18 09:02:08
 *
 *  @brief 类实例方法
 *  @param size       图层大小
 *  @param edgeInsets 四个边距
 *  @return 实例对象
 *  @since v0.1.0
 */
+ (instancetype)layerWithSize:(CGSize)size edgeInsets:(UIEdgeInsets)edgeInsets;
@end
