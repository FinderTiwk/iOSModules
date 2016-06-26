//
//  QRCodeView.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/16.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "QRCodeView.h"
#import "XKSCommonTips.h"
#import "XKSCommonMacro.h"
#import "XKSAlertWindow.h"
#import "UIImage+Xkeshi.h"
#import "XKSVideoPreviewLayer.h"

@interface QRCodeView()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) AVCaptureSession           *session;
@property (nonatomic,strong) AVCaptureDevice            *device;
@property (nonatomic,strong) AVCaptureDeviceInput       *input;
@property (nonatomic,strong) AVCaptureMetadataOutput    *output;

@end

@implementation QRCodeView{
    XKSVideoPreviewLayer *_scanLayer;
    CALayer              *_animationLayer;
    CATextLayer          *_tipLayer;
    CAShapeLayer         *_borderLayer;
    CAShapeLayer         *_cornerLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.animationType   = 1;
        self.maskInsets      = (UIEdgeInsets){80,40,80,40};
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


- (void)dealloc{
    [self stopScan];
}

- (AVCaptureDeviceInput *)input{
    if (!_input) {
        _device  = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _session = [[AVCaptureSession alloc]init];
        NSError *error;
        _input   = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
        if (!_input) {
            return nil;
        }
        
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:_input]){
            [_session addInput:_input];
        }
        
        _output = [[AVCaptureMetadataOutput alloc]init];
        if ([_session canAddOutput:_output]){
            [_session addOutput:_output];
        }
        
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 条码类型 AVMetadataObjectTypeQRCode
        if ([_output.availableMetadataObjectTypes containsObject:
             AVMetadataObjectTypeQRCode]||
            [_output.availableMetadataObjectTypes containsObject:
             AVMetadataObjectTypeCode128Code]) {
                _output.metadataObjectTypes =[NSArray arrayWithObjects:
                                              AVMetadataObjectTypeQRCode,
                                              AVMetadataObjectTypeCode39Code,
                                              AVMetadataObjectTypeCode128Code,
                                              AVMetadataObjectTypeCode39Mod43Code,
                                              AVMetadataObjectTypeEAN13Code,
                                              AVMetadataObjectTypeEAN8Code,
                                              AVMetadataObjectTypeCode93Code, nil];
            }
        [self addScanLayer];
    }
    return _input;
}


- (void)addScanLayer{
    _scanLayer = [XKSVideoPreviewLayer layerWithSession:_session frame:self.bounds cornerColor:RGBACOLOR(25, 136, 222, 1) edgeInsets:self.maskInsets animationType:self.animationType];
    _scanLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    [self.layer insertSublayer:_scanLayer atIndex:0];
    
    CGFloat cornerLenght = 30.;
    CGFloat cornerWidth  = 6.;
    CGSize  size         = self.bounds.size;
    
    CGFloat top          = self.maskInsets.top;
    CGFloat left         = self.maskInsets.left;
    CGFloat bottom       = self.maskInsets.bottom;
    CGFloat right        = self.maskInsets.right;
    
    UIColor *color = RGBACOLOR(25, 136, 222, 1);
    
    {
        _tipLayer               = [CATextLayer layer];
        _tipLayer.frame         = (CGRect){{0,top/4},{size.width,top/2}};
        _tipLayer.contentsScale = [UIScreen mainScreen].scale;
        _tipLayer.string        = @"将取景框对准二维码\n即可自动扫描识别";
        _tipLayer.alignmentMode = @"center";
        _tipLayer.fontSize      = 12;
        [self.layer insertSublayer:_tipLayer above:_scanLayer];
    }

    {//白色边框
        _borderLayer             = [CAShapeLayer layer];
        _borderLayer.anchorPoint = CGPointZero;
        _borderLayer.strokeColor = [UIColor whiteColor].CGColor;
        _borderLayer.fillColor   = [UIColor clearColor].CGColor;
        _borderLayer.lineWidth   = cornerWidth/3;

        UIBezierPath *boardPath  = [UIBezierPath bezierPathWithRect:CGRectMake(left-2, top-2, size.width-left-right+4, size.height-top-bottom+4)];
        _borderLayer.path        = boardPath.CGPath;
        [self.layer insertSublayer:_borderLayer above:_scanLayer];
    }
    
    {//四个拐角
        _cornerLayer             = [CAShapeLayer layer];
        _cornerLayer.strokeColor = color.CGColor;
        _cornerLayer.lineWidth   = cornerWidth;
        _cornerLayer.fillColor   = [UIColor clearColor].CGColor;
        UIBezierPath *cornerPath = [UIBezierPath bezierPath];
        CGFloat delta            = cornerWidth/2;
        
        //左上角
        CGFloat currentX = left - delta;
        CGFloat currentY = top + cornerLenght;
        [cornerPath moveToPoint:(CGPoint){currentX,currentY}];
        currentY = top - delta;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        currentX = left + cornerLenght;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        
        //右上角
        currentX = size.width - right - cornerLenght;
        [cornerPath moveToPoint:(CGPoint){currentX,currentY}];
        currentX = size.width - right + delta;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        currentY = top + cornerLenght;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        
        //右下角
        currentY = size.height - bottom - cornerLenght;
        [cornerPath moveToPoint:(CGPoint){currentX,currentY}];
        currentY = size.height - bottom + delta;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        currentX = size.width - right - cornerLenght;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        
        //左下角
        currentX = left + cornerLenght;
        [cornerPath moveToPoint:(CGPoint){currentX,currentY}];
        currentX = left - delta;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        currentY = size.height - bottom - cornerLenght;
        [cornerPath addLineToPoint:(CGPoint){currentX,currentY}];
        
        _cornerLayer.path = cornerPath.CGPath;
        
        [self.layer insertSublayer:_cornerLayer above:_borderLayer];
    }
    
    CATransition *transition = [CATransition animation];
    transition.type          = kCATransitionFade;
    transition.duration      = 0.3;
    [self.layer addAnimation:transition forKey:nil];
}

- (void)addAnimationLayer {
    _scanLayer.anchorPoint    = CGPointZero;
    _scanLayer.frame          = self.bounds;
    CGSize size          = self.bounds.size;
    
    CGFloat top    = self.maskInsets.top;
    CGFloat left   = self.maskInsets.left;
    CGFloat bottom = self.maskInsets.bottom;
    CGFloat right  = self.maskInsets.right;
    
    CALayer *animationLayer = [CALayer layer];
    CABasicAnimation *animation;
    animationLayer.anchorPoint = CGPointZero;
    if (self.animationType == 0) {
        //往复运动的扫描线
        animationLayer.frame       = CGRectMake(left+5,top+10,size.width-left-right-10,2);
        animationLayer.contents    = (id)[UIImage xks_imageNamed:@"scan_line" fromBundle:XKSCommonSDKBundleName].CGImage;
        animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        animation.toValue      = @(size.height - 20 - bottom);
        animation.autoreverses = YES;
    }else{
        //重复从上住下的扫描网
        animationLayer.frame       = CGRectMake(left,top, size.width - left - right, 0);
        animationLayer.contents    = (id)[UIImage xks_imageNamed:@"scan_net" fromBundle:XKSCommonSDKBundleName].CGImage;
        
        animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
        animation.fromValue    = @(0);
        animation.toValue      = @(size.height - top -bottom);
    }
    animation.repeatCount  = CGFLOAT_MAX;
    animation.duration     = 2;
    [animationLayer addAnimation:animation forKey:@"scanAnimation"];
    [_scanLayer addSublayer:animationLayer];
    _animationLayer = animationLayer;
}

- (void)startScan{
    if (self.input) {
        [_session startRunning];
        [_animationLayer removeFromSuperlayer];
        [self addAnimationLayer];
        [_scanLayer startAnimation];
    }else{
        [XKSAlertWindow showWithType:XKSAlertType_WARNING message:kXKSCommon_Tip_Camera];
    }
}

- (void)pauseScan{
    if ([_session isRunning]) {
        [_session stopRunning];
        [_animationLayer removeFromSuperlayer];
        [_scanLayer stopAnimation];
    }
}

- (void)stopScan{
    if ([_session isRunning]) {
        [_session stopRunning];
    }
    [_animationLayer removeFromSuperlayer];
    [_scanLayer removeFromSuperlayer];
    [_tipLayer removeFromSuperlayer];
    [_borderLayer removeFromSuperlayer];
    [_cornerLayer removeFromSuperlayer];
    [self removeFromSuperview];
}

#pragma mark -AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if ([metadataObjects count] > 0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        [self pauseScan];
        if (self.scanBlock) {
            self.scanBlock(metadataObject.stringValue);
        }
        return;
    }
}

- (void)setDefaultOrientation:(UIInterfaceOrientation)orientation{
    if (!_scanLayer) {
        return;
    }
    [CATransaction begin];
    [CATransaction setAnimationDuration: 0.80000000000000004];
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        _scanLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        
    }else if (orientation == UIInterfaceOrientationLandscapeLeft){
        _scanLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        
    }else if (orientation == UIDeviceOrientationPortrait){
        _scanLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        
    }else if (orientation == UIDeviceOrientationPortraitUpsideDown){
        _scanLayer.connection.videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
    }
    [CATransaction commit];
}

@end
