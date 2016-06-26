//
//  IPConfigCell.m
//  XKSSettingModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "IPConfigCell.h"
#import "XKSGlobalSetting.h"


@interface IPConfigCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipField;

@end

@implementation IPConfigCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _ipField.text = [XKSGlobalSetting shareXKSGlobalSetting].ipAdress;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _ipField.text = textField.text;
}

@end
