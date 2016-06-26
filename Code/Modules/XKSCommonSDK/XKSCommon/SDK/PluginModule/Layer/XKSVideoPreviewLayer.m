//
//  XKSVideoPreviewLayer.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSVideoPreviewLayer.h"

@implementation XKSVideoPreviewLayer

//柯里化（Currying）是把接受多个参数的函数变换成接受一个单一参数(最初函数的第一个参数)的函数，并且返回接受余下的参数且返回结果的新函数的技术
+ (instancetype)layerWithSession:(AVCaptureSession *)session frame:(CGRect)frame{
    return [self layerWithSession:session frame:frame cornerColor:[UIColor clearColor]];
}

+ (instancetype)layerWithSession:(AVCaptureSession *)session frame:(CGRect)frame cornerColor:(UIColor *)color{
    return [self layerWithSession:session frame:frame cornerColor:color edgeInsets:(UIEdgeInsets){80,40,80,40}];
}

+ (instancetype)layerWithSession:(AVCaptureSession *)session
                           frame:(CGRect)frame
                     cornerColor:(UIColor *)color
                      edgeInsets:(UIEdgeInsets)edgeInsets{
    return [self layerWithSession:session frame:frame cornerColor:color edgeInsets:edgeInsets animationType:1];
}

+ (instancetype)layerWithSession:(AVCaptureSession *)session
                           frame:(CGRect)frame
                     cornerColor:(UIColor *)color
                      edgeInsets:(UIEdgeInsets)edgeInsets
                   animationType:(NSUInteger)type{
    XKSVideoPreviewLayer *layer = [super layerWithSession:session];
    QRMaskLayer *mask = [QRMaskLayer layerWithSize:frame.size edgeInsets:edgeInsets];
    layer.mask = mask;
    return layer;
}


- (void)stopAnimation{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed                = 0.0;
    self.timeOffset           = pausedTime;
}

- (void)startAnimation{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed                = 1.0;
    self.timeOffset           = 0.0;
    self.beginTime            = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end
