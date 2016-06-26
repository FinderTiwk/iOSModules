//
//  XKSVideoPreviewLayer.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/18.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "QRMaskLayer.h"

@interface XKSVideoPreviewLayer : AVCaptureVideoPreviewLayer

+ (instancetype)layerWithSession:(AVCaptureSession *)session
                           frame:(CGRect)frame;

+ (instancetype)layerWithSession:(AVCaptureSession *)session
                           frame:(CGRect)frame
                     cornerColor:(UIColor *)color;

+ (instancetype)layerWithSession:(AVCaptureSession *)session
                           frame:(CGRect)frame
                     cornerColor:(UIColor *)color
                      edgeInsets:(UIEdgeInsets)edgeInsets;


+ (instancetype)layerWithSession:(AVCaptureSession *)session
                           frame:(CGRect)frame
                     cornerColor:(UIColor *)color
                      edgeInsets:(UIEdgeInsets)edgeInsets
                   animationType:(NSUInteger)type;

- (void)startAnimation;

- (void)stopAnimation;

@end
