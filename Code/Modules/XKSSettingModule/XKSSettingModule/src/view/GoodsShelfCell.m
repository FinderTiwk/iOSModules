//
//  GoodsShelfCell.m
//  XKSSettingModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "GoodsShelfCell.h"
#import "XKSGlobalSetting.h"

@interface GoodsShelfCell ()

@property (weak, nonatomic) IBOutlet UISwitch *shelfSwitch;

@end

@implementation GoodsShelfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _shelfSwitch.on = [XKSGlobalSetting shareXKSGlobalSetting].goodsShelf;
}

- (IBAction)switchAction:(UISwitch *)sender {
    [XKSGlobalSetting shareXKSGlobalSetting].goodsShelf = sender.on;
}

@end
