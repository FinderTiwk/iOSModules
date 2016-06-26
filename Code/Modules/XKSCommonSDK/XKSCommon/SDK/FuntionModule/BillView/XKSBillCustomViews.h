//
//  XKSBillCustomViews.h
//  XKSCommonSDK
//
//  Created by wangyangcc on 16/5/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *导航栏*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


@interface XKSBillNavigationBar : UIView

/**
 *  @author wangyangcc, 16-04-27 15:04:47
 *
 *  @brief 点击返回按钮回调
 */
@property (copy, nonatomic) void(^backCallBlock)(void);

/**
 *  @author wangyangcc, 16-04-27 16:04:07
 *
 *  @brief 标题
 */
@property (copy, nonatomic) NSString *title;

@end

#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *账单键盘*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


@protocol XKSBillNumberKeyboardViewDelegate;
@interface XKSBillNumberKeyboardView : UIView

@property (weak, nonatomic) id<XKSBillNumberKeyboardViewDelegate> delegate;

@end

@protocol XKSBillNumberKeyboardViewDelegate <NSObject>

- (void)numberButtonTaped:(NSInteger)number;

- (void)deleteButtonTaped;

- (void)deleteAllButtonTaped;

- (void)doneButtonTaped;

@end


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *账单左侧设置界面*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

@protocol XKSBillSettingViewDelegate <NSObject>

/**
 *  @author wangyangcc, 16-05-13 15:05:13
 *
 *  @brief 回调，通常最多一个参数为YES
 *
 *  @param printPaperBill      是否打印纸质账单
 *  @param printElectronicbill 是否打印电子账单
 */
- (void)settingViewWithPrintPaperBill:(BOOL)printPaperBill
                  printElectronicbill:(BOOL)printElectronicbill;

@end

@interface XKSBillSettingView : UIView

@property (readonly, strong, nonatomic) UITextField *textField;

@property (weak, nonatomic) id<XKSBillSettingViewDelegate> delegate;

@end

@interface XKSBillSettingViewField : UITextField

@end



