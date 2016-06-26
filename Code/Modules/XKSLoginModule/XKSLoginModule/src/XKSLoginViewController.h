//
//  XKSLoginViewController.h
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKSLoginViewController : UIViewController

@property (nonatomic,copy) void (^successBlock)(NSString *message);
@property (nonatomic,copy) void (^showSetting)(UIViewController *parent);

@end
