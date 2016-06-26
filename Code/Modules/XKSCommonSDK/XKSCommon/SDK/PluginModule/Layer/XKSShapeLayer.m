//
//  XKSShapeLayer.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/17.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//
#import "XKSShapeLayer.h"
/*! 默认动画时间*/
static CFTimeInterval const kXKSShapeLayerAnimationDuration = 0.8;

@implementation XKSShapeLayer

static CGFloat _radius;
static CGFloat _lineWidth;

+ (instancetype)layerWithRadius:(CGFloat)radius color:(UIColor *)color lineWidth:(CGFloat)lineWidth type:(XKSShapeLayerType)type duration:(CFTimeInterval)duration{
    _radius            = radius;
    _lineWidth         = lineWidth;
    
    XKSShapeLayer *layer = [super layer];
    layer.anchorPoint  = (CGPoint){0.5,0.5};
    layer.position     = (CGPoint){radius,radius};
    layer.bounds       = (CGRect){{0,0},{2*radius,2*radius}};
    layer.lineWidth    = lineWidth;
    layer.lineJoin     = kCALineJoinRound;
    layer.lineCap      = kCALineCapRound;
    layer.strokeColor  = color.CGColor;
    layer.fillColor    = [UIColor clearColor].CGColor;
    
    [layer addAnimationWithType:type duration:duration];
    return layer;
}

+ (instancetype)layerWithRadius:(CGFloat)radius
                          color:(UIColor *)color
                      lineWidth:(CGFloat)lineWidth
                           type:(XKSShapeLayerType)type{
    return [self layerWithRadius:radius color:color lineWidth:lineWidth type:type duration:kXKSShapeLayerAnimationDuration];
}


- (void)addAnimationWithType:(XKSShapeLayerType)type duration:(CFTimeInterval)duration{
    
    CAAnimationGroup *group   = [CAAnimationGroup animation];
    group.duration            = duration;
    group.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    group.fillMode            = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeStart))];
    startAnimation.fromValue = @0;
    startAnimation.toValue   = @0.10;
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    endAnimation.fromValue = @0;
    endAnimation.toValue   = @1;
    
    if (type == XKSShapeLayerType_SUCCESS) {
        [self successPath];
    }
    if (type == XKSShapeLayerType_FAILURE) {
        [self failurePath];
    }
    if (type == XKSShapeLayerType_WARNING) {
        [self warningPath];
    }
    group.animations  = @[startAnimation,endAnimation];
    [self addAnimation:group forKey:nil];
}


#pragma mark - 具体的UIBezierPath
#pragma mark 一个圆圈里一个对勾的UIBezierPath
- (void)successPath{
    CGFloat widthAndHeight = 2*_radius;
    
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:(CGPoint){_radius,_radius} radius:_radius startAngle:0 endAngle:M_PI*2 + M_PI/6 clockwise:YES];
    NSUInteger sectionRatio = 10;
    //勾的起点
    CGPoint p0 = (CGPoint){widthAndHeight*2/sectionRatio,widthAndHeight*5/sectionRatio};
    [path moveToPoint:p0];
    //勾的最底端
    CGPoint p1 = (CGPoint){widthAndHeight*4/sectionRatio,widthAndHeight*7/sectionRatio};
    [path addLineToPoint:p1];
    //勾的最上端
    CGPoint p2 = (CGPoint){widthAndHeight*8/sectionRatio,widthAndHeight*3/sectionRatio};
    [path addLineToPoint:p2];
    
    self.path = path.CGPath;
}

#pragma mark 一个圆形里面一个叉的UIBezierPath
- (void)failurePath{
    CGFloat widthAndHeight = 2*_radius;
    
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:(CGPoint){_radius,_radius} radius:_radius startAngle:0 endAngle:M_PI*2 + M_PI/6 clockwise:YES];
    NSUInteger sectionRatio = 10;
    //第一条对角线起点
    CGPoint p0 = (CGPoint){widthAndHeight*3/sectionRatio,widthAndHeight*3/sectionRatio};
    [path moveToPoint:p0];
    //第一条对角线终点
    CGPoint p1 = (CGPoint){widthAndHeight*7/sectionRatio,widthAndHeight*7/sectionRatio};
    [path addLineToPoint:p1];
    
    //第二条对角线起点
    CGPoint p2 = (CGPoint){widthAndHeight*7/sectionRatio,widthAndHeight*3/sectionRatio};
    [path moveToPoint:p2];
    
    CGPoint p3 = (CGPoint){widthAndHeight*3/sectionRatio,widthAndHeight*7/sectionRatio};
    [path addLineToPoint:p3];

    self.path = path.CGPath;
}

#pragma mark 一个三角形里面一个叹号的UIBezierPath
- (void)warningPath{
    
    CGFloat widthAndHeight = 2*_radius;
    
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:(CGPoint){_radius,_radius} radius:_radius startAngle:0 endAngle:M_PI*2 + M_PI/6 clockwise:YES];
    NSUInteger sectionRatio = 10;
    //叹号上半部分
    CGPoint p0 = (CGPoint){_radius,widthAndHeight*2/sectionRatio};
    [path moveToPoint:p0];
    
    CGPoint p1 = (CGPoint){_radius,widthAndHeight*6/sectionRatio};
    [path addLineToPoint:p1];
    
    //叹号下半部分
    CGPoint p2 = (CGPoint){_radius,widthAndHeight*8/sectionRatio};
    [path moveToPoint:p2];
    
    [path addArcWithCenter:p2 radius:1 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    self.path = path.CGPath;
}


@end
