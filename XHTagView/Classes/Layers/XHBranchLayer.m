//
//  XHBranchLayer.m
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com. All rights reserved.
//

#import "XHBranchLayer.h"

@interface XHBranchLayer ()

@property (nonatomic, copy) XHBranchLayerAnimationCompletion completion;

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation XHBranchLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.completion = nil;
    [self cancelPrevious];
}

- (void)setup {
    self.strokeStart = 0;
    self.strokeEnd = 1;
    
    self.lineWidth = 1.0;
    
    self.toValue = 0.57;
    self.animationDuration = 0.55;
    
    self.strokeColor = [UIColor blackColor].CGColor;
    self.fillColor = [UIColor clearColor].CGColor;
}

- (void)commitPath {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.path = nil;
    self.fillColor = [UIColor clearColor].CGColor;
    [CATransaction commit];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.midPoint];
    [path addLineToPoint:self.endPoint];
    
    if (self.direction == XHBranchLayerDirectionRight) {
        CGPoint circlePoint = CGPointMake(self.endPoint.x + self.radius, self.endPoint.y);
        [path addArcWithCenter:circlePoint radius:self.radius startAngle:-M_PI endAngle:2 * M_PI / 2 clockwise:YES];
    } else {
        CGPoint circlePoint = CGPointMake(self.endPoint.x - self.radius, self.endPoint.y);
        
        [path addArcWithCenter:circlePoint radius:self.radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    [path addLineToPoint:self.midPoint];
    [path closePath];
    
    self.strokeStart = 0.0;
    self.strokeEnd = 0.0;
    self.path = path.CGPath;
}

- (void)cancelPrevious {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)animationDelay:(NSTimeInterval)delay
            completion:(XHBranchLayerAnimationCompletion)completion {
    [self removeAllAnimations];
    [self cancelPrevious];
    [self commitPath];
    
    self.completion = completion;
    
    self.animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.animation.delegate = self;
    self.animation.beginTime = CACurrentMediaTime() + delay;
    self.animation.fromValue = @(0);
    self.animation.toValue = @(self.toValue);
    self.animation.duration = self.animationDuration;
    self.animation.fillMode = kCAFillModeForwards;
    self.animation.removedOnCompletion = NO;
    [self addAnimation:self.animation forKey:@"strokeEnd"];
    
    [self performSelector:@selector(setFillColor:) withObject:(id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor afterDelay:delay + self.animationDuration];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.completion && anim == self.animation) {
        self.completion(flag, self);
    }
}

@end