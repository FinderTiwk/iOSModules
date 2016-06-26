//
//  QRCodeView.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/16.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  @author _Finder丶Tiwk, 16-01-16 02:01:48
 *
 *  @brief 扫码视图类
 *  @since v0.1.0
 */
@interface QRCodeView : UIView

/*! 扫描动画类型  1-扫描网从上到下铺满(默认)  非1一条扫描线从上到下做往复运动 */
@property (nonatomic,assign) NSUInteger animationType;
/*! 四个边距遮罩 默认为 {80(上),40(左),80(下),40(右)}*/
@property (nonatomic,assign) UIEdgeInsets maskInsets;
/*! 扫码成功回调*/
@property (nonatomic,copy) void(^scanBlock)(NSString *scanResult);

/**
 *  @author _Finder丶Tiwk, 16-06-02 10:06:30
 *
 *  @brief 设置扫码视图的默认方向
 *  @since v1.1.0
 */
- (void)setDefaultOrientation:(UIInterfaceOrientation)orientation;


/**
 *  @author _Finder丶Tiwk, 16-01-16 02:01:59
 *
 *  @brief 开始扫描
 *  @since v0.1.0
 */
- (void)startScan;

/**
 *  @author _Finder丶Tiwk, 16-02-17 14:02:32
 *
 *  @brief 暂停扫描
 *  @since v0.1.0
 */
- (void)pauseScan;

/**
 *  @author _Finder丶Tiwk, 16-01-16 02:01:42
 *
 *  @brief 停止扫描(停止后此视图将会自动从父视图中移除)
 *  @since v0.1.0
 */
- (void)stopScan;


@end
