//
//  XKSGoodsCell.m
//  XKSHomeModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSGoodsCell.h"

@interface XKSGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XKSGoodsCell

- (void)setImageName:(NSString *)imageName title:(NSString *)title{
    _iconImageView.image = [UIImage imageNamed:imageName];
    _titleLabel.text     = title;
}

@end
