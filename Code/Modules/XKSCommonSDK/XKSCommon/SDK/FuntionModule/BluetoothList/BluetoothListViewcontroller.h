//
//  BluetoothListViewcontroller.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/25.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSCommonMacro.h"

/**
 *  @author _Finder丶Tiwk, 16-01-25 15:01:40
 *
 *  @brief 蓝牙列表选择界面
 *  建议使用modal的方式推出此控制器,如下
 *  CGSize size = [UIScreen mainScreen].bounds.size;
 *  controller.preferredContentSize   = CGSizeMake(size.width/2, size.height*2/3);
 *  controller.modalPresentationStyle = UIModalPresentationFormSheet;
 *  controller.modalTransitionStyle   = UIModalTransitionStyleCoverVertical;
 *  [self presentViewController:controller animated:YES completion:nil];
 *  @since v0.1.0
 */
@interface BluetoothListViewcontroller : UIViewController


/*! 蓝牙选择回调,identifier:蓝牙设备标识符*/
@property (nonatomic,copy) void (^selectBlock)(NSString *identifier);
/*! 点击左上角返回按钮回调*/
@property (nonatomic,copy) void (^cancelBlock)();

@end
