//
//  SignatureViewController.m
//  XKSCommonSDKDemo
//
//  Created by _Finder丶Tiwk on 16/1/21.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "SignatureViewController.h"
#import "SignatureView.h"

#import "XKSCommonMacro.h"
#import "UIImage+Xkeshi.h"

@interface SignatureViewController ()<SignatureViewDelegate>
@property (nonatomic,weak) SignatureView *signatureView;
@end

@implementation SignatureViewController{
    UIButton    *_resetButton;
    UIButton    *_submitButton;
    CALayer     *_maskLayer;
    BOOL        _open;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _showBackButton = NO;
        _submitBlock    = NULL;
        _dismissBlock   = NULL;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];

    [self addMasks];
    
    SignatureView *signature  = [SignatureView signatureView];
    _signatureView            = signature;
    signature.delegate        = self;
    signature.backgroundColor = [UIColor clearColor];
    signature.frame = CGRectMake(0,80, self.view.frame.size.width ,self.view.frame.size.height);
    [self.view addSubview:signature];
    [self addButtons];
}

- (void)addMasks{
    
    CGRect bounds = self.view.bounds;
    
    CALayer *colorLayer        = [CALayer layer];
    colorLayer.bounds          = bounds;
    colorLayer.anchorPoint     = CGPointZero;
    colorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    
    CALayer *textureLayer        = [CALayer layer];
    textureLayer.bounds          = bounds;
    textureLayer.anchorPoint     = CGPointZero;
    UIImage *backImage           = [UIImage xks_imageNamed:@"sg_background" fromBundle:XKSCommonSDKBundleName];
    textureLayer.backgroundColor = [UIColor colorWithPatternImage:backImage].CGColor;
    [self.view.layer addSublayer:textureLayer];
    
    _maskLayer                 = [CALayer layer];
    _maskLayer.bounds          = bounds;
    _maskLayer.anchorPoint     = CGPointZero;
    _maskLayer.backgroundColor = RGBACOLOR(5, 5, 5, 0.2).CGColor;
    
    CATextLayer *tipLayer  = [CATextLayer layer];
    tipLayer.string        = @"请开始签名";
    tipLayer.frame         = (CGRect){{0,bounds.size.height/2},{bounds.size.width,bounds.size.height/2}};
    tipLayer.contentsScale = [UIScreen mainScreen].scale;
    tipLayer.alignmentMode = kCAAlignmentCenter;
    tipLayer.font          = (__bridge CFTypeRef _Nullable)([UIFont boldSystemFontOfSize:26]);

    [_maskLayer addSublayer:tipLayer];
    [self.view.layer addSublayer:_maskLayer];
}

//添加各种按钮
- (void)addButtons{
    if (self.showBackButton) {
        //返回按钮
        UIButton *backBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame           = CGRectMake(20, 20, 54, 54);
        backBtn.backgroundColor = [UIColor clearColor];
        
        [backBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage xks_imageNamed:@"sg_back_button" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage xks_imageNamed:@"sg_back_button_highlight" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateHighlighted];
        [self.view addSubview:backBtn];
    }
    
    CGFloat padding   = 40;
    CGFloat btnWidth  = 70;
    CGRect  bounds    = self.view.bounds;

    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.backgroundColor = [UIColor clearColor];
    _submitButton.enabled = NO;
    
    _submitButton.frame = CGRectMake(bounds.size.width - padding - btnWidth, bounds.size.height - 23 - btnWidth, btnWidth, btnWidth);
    [_submitButton setImage:[UIImage xks_imageNamed:@"sg_ok_button" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
    [_submitButton setImage:[UIImage xks_imageNamed:@"sg_ok_button_highlight" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateHighlighted];
    _submitButton.adjustsImageWhenDisabled = NO;
    [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];
    
    _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetButton.enabled = NO;
    _resetButton.backgroundColor = [UIColor clearColor];
    _resetButton.frame = CGRectMake(bounds.size.width - 2*padding - 2*btnWidth, bounds.size.height - 23 - btnWidth, btnWidth, btnWidth);
    [_resetButton setImage:[UIImage xks_imageNamed:@"sg_reset_button" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
    [_resetButton setImage:[UIImage xks_imageNamed:@"sg_reset_button_highlight" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateHighlighted];
    _resetButton.adjustsImageWhenDisabled = NO;
    [_resetButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetButton];
}

#pragma mark - SignatureViewDelegate
- (void)signatureBegin{
    if (!_open) {
        [_maskLayer removeFromSuperlayer];
        _submitButton.enabled = YES;
        _resetButton.enabled  = YES;
        _open                 = YES;
        _maskLayer            = nil;
    }
}

#pragma mark - ButtonAction
- (void)closeAction:(UIButton *)sender{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)clearAction:(UIButton *)sender{
    [_signatureView clearSignature];
}

- (void)submitAction:(UIButton *)sender{
    if (self.submitBlock) {
        self.submitBlock([_signatureView currentSignature]);
    }
}

@end
