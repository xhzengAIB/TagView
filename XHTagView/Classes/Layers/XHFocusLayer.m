//
//  XHFocusLayer.m
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHFocusLayer.h"

@interface XHFocusLayer ()

@property (nonatomic, strong) CALayer *targetLayer;
@property (nonatomic, strong) CAAnimationGroup *animationGroup;

@end

@implementation XHFocusLayer
@dynamic repeatCount;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupLayer];
        
        [self setup];
    }
    return self;
}

- (void)setup {
    _fromValueForRadius = 0.0;
    _fromValueForAlpha = 0.45;
    _keyTimeForHalfOpacity = 0.2;
    _animationDuration = 1.0;
    
    self.repeatCount = INFINITY;
    self.radius = 15;
    self.focusLayerNumber = 1;
    self.instanceDelay = 1;
    self.backgroundColor = [[UIColor whiteColor] CGColor];
    
    [self stopAnimation];
}

- (void)setupLayer {
    self.targetLayer = [CALayer new];
    self.targetLayer.contentsScale = [UIScreen mainScreen].scale;
    self.targetLayer.opacity = 0;
    [self addSublayer:self.targetLayer];
}

- (void)startAnimation {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        if (!self.animationGroup) {
            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = self.animationDuration;
            animationGroup.repeatCount = self.repeatCount;
            animationGroup.removedOnCompletion = NO;
            
            CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            animationGroup.timingFunction = defaultCurve;
            
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
            scaleAnimation.fromValue = @(self.fromValueForRadius);
            scaleAnimation.toValue = @1.0;
            scaleAnimation.duration = self.animationDuration;
            
            CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
            opacityAnimation.duration = self.animationDuration;
            opacityAnimation.values = @[@(self.fromValueForAlpha), @0.45, @0];
            opacityAnimation.keyTimes = @[@0, @(self.keyTimeForHalfOpacity), @1];
            opacityAnimation.removedOnCompletion = NO;
            
            NSArray *animations = @[scaleAnimation, opacityAnimation];
            
            animationGroup.animations = animations;
            
            self.animationGroup = animationGroup;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.opacity = 1.0;
            [self.targetLayer addAnimation:self.animationGroup forKey:@"focus"];
        });
    });
}

- (void)stopAnimation {
    self.opacity = 0.0;
    [self.targetLayer removeAllAnimations];
}

- (void)setBackgroundColor:(CGColorRef)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.targetLayer.backgroundColor = backgroundColor;
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    
    CGFloat diameter = self.radius * 2;
    
    self.targetLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    self.targetLayer.cornerRadius = self.radius;
}

- (void)setFocusLayerNumber:(NSInteger)focusLayerNumber {
    _focusLayerNumber = focusLayerNumber;
    self.instanceCount = focusLayerNumber;
    self.instanceDelay = (self.animationDuration) / focusLayerNumber;
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    self.animationGroup.duration = animationDuration;
    for (CAAnimation *anAnimation in self.animationGroup.animations) {
        anAnimation.duration = animationDuration;
    }
    [self stopAnimation];
    [self.targetLayer addAnimation:self.animationGroup forKey:@"focus"];
    self.instanceDelay = (self.animationDuration) / self.focusLayerNumber;
}

@end