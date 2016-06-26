//
//  SignatureView.m
//  SignatureView
//
//  Created by _Finder丶Tiwk on 15/12/4.
//  Copyright © 2015年 _Finder丶Tiwk. All rights reserved.
//

#import "SignatureView.h"

static CGFloat const kXKSSignatureLineWidth = 12.f;

@interface SignatureView ()

@property (nonatomic,strong) NSMutableArray *layerArray;

@end

@implementation SignatureView{
    UIBezierPath *_currentPath;
    CAShapeLayer *_currentLayer;
}

+ (instancetype)signatureView{
    SignatureView *view  = [[SignatureView alloc] init];
    view.lineWith        = kXKSSignatureLineWidth;
    view.lineColor       = [UIColor blackColor];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSMutableArray *)layerArray{
    if (!_layerArray) {
        _layerArray = [NSMutableArray array];
    }
    return _layerArray;
}

#pragma mark - 手势触摸

- (CGPoint)pointWithTouches:(NSSet<UITouch *> *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(signatureBegin)]) {
        [self.delegate signatureBegin];
    }
    CGPoint startPoint = [self pointWithTouches:touches];
    if ([event allTouches].count == 1) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        bezierPath.lineWidth     = self.lineWith;
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        bezierPath.lineCapStyle  = kCGLineCapRound;
        [bezierPath moveToPoint:startPoint];
        
        CAShapeLayer * layer  = [CAShapeLayer layer];
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.fillColor       = [UIColor clearColor].CGColor;
        layer.lineCap         = kCALineCapRound;
        layer.lineJoin        = kCALineJoinRound;
        layer.strokeColor     = [UIColor blackColor].CGColor;
        layer.lineWidth       = bezierPath.lineWidth;
        layer.path            = bezierPath.CGPath;
        
        _currentPath  = bezierPath;
        _currentLayer = layer;
        [self.layer addSublayer:layer];
        [self.layerArray addObject:_currentLayer];
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [self pointWithTouches:touches];
    
    if ([event allTouches].count > 1){
        [self.superview touchesMoved:touches withEvent:event];
    }
    else if ([event allTouches].count == 1) {
        [_currentPath addLineToPoint:currentPoint];
        _currentLayer.path = _currentPath.CGPath;
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

#pragma mark - 对外暴露的方法
- (UIImage *)currentSignature{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  screenshot;
}

- (void)clearSignature{
    [self.layerArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layerArray removeAllObjects];
    _currentPath = nil;
}

@end
