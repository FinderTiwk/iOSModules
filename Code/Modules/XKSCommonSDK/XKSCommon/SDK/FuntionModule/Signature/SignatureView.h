//
//  SignatureView.h
//  SignatureView
//
//  Created by _Finder丶Tiwk on 15/12/4.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignatureViewDelegate <NSObject>
- (void)signatureBegin;
@end

/**
 *  @author _Finder丶Tiwk, 15-12-04 13:12:57
 *
 *  @brief 签名上传界面
 *  @since v1.1.0
 */
@interface SignatureView : UIView

/**
 *  @author _Finder丶Tiwk, 15-12-04 13:12:43
 *
 *  @brief 实例方法
 *  @return 实例对象
 *  @since v1.1.0
 */
+ (instancetype)signatureView;

/**
 *  @author _Finder丶Tiwk, 15-12-04 13:12:11
 *
 *  @brief 将当前签名保存为图片
 *  @return 签名图片
 *  @since v1.1.0
 */
- (UIImage *)currentSignature;

/**
 *  @author _Finder丶Tiwk, 15-12-04 13:12:40
 *
 *  @brief 清空签名
 *  @since v1.1.0
 */
- (void)clearSignature;

/*! 签名线宽*/
@property (nonatomic,assign) CGFloat lineWith;
/*! 签名颜色*/ 
@property (nonatomic,strong) UIColor *lineColor;
/*! 代理对象*/ 
@property (nonatomic,weak) id<SignatureViewDelegate> delegate;

@end
