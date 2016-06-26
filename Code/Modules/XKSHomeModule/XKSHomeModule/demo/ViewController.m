//
//  ViewController.m
//  XKSHomeModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "ViewController.h"
#import "XKSHomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"XKSHomeViewController" bundle:nil];
    XKSHomeViewController *controller = [storyboard instantiateInitialViewController];
    
    [self presentViewController:controller animated:YES completion:nil];

}

@end
