//
//  ViewController.m
//  XKSSettingModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "ViewController.h"

#import "XKSSettingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"XKSSettingViewController" bundle:nil];
    XKSSettingViewController *controller = [storyboard instantiateInitialViewController];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    controller.preferredContentSize   = CGSizeMake(size.width/2, size.height*2/3);
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle   = UIModalTransitionStyleCoverVertical;
    [self presentViewController:controller animated:YES completion:nil];
}


@end
