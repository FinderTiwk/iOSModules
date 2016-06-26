//
//  XKSBillViewController.h
//  XKSCommonSDK
//
//  Created by wangyangcc on 16/5/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! 打印纸质账单的通知，传入printDic，可能为nil*/
static NSString *const kXKSBillView_PrintPaperBill_Notification = @"kXKSBillView_PrintPaperBill_Notification";

@interface XKSBillViewController : UIViewController

@property (copy, nonatomic) void (^dismissBlock)();

@property (copy, nonatomic) void (^submitBlock)(NSString *mobileStr);

@property (copy, nonatomic) NSDictionary *printDic;



@end
