//
//  ViewController.m
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "ViewController.h"
#import "XKSLoginServices.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorIDLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XKSOperator *operator = [XKSLoginServices LoginOperator];
    
    _userNameLabel.text   = operator.name;
    _operatorIDLabel.text = operator.operatorID;
}


- (IBAction)logoutAction:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [XKSLoginServices logout];
    });
}


@end
