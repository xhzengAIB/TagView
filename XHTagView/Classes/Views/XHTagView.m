//
//  XHTagView.m
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHTagView.h"

#import "XHBranchLayer.h"
#import "XHCenterView.h"
#import "XHBranchTextView.h"
#import "XHBranchPoint.h"

#import "XHTagHeader.h"

@interface XHTagView ()

@property (nonatomic, assign, readwrite) BOOL showing;

@property (nonatomic, strong) XHBranchLayer *topBranchLayer;
@property (nonatomic, strong) XHBranchLayer *midBranchLayer;
@property (nonatomic, strong) XHBranchLayer *bottomBranchLayer;

@property (nonatomic, strong) XHBranchTextView *topBranchTextView;
@property (nonatomic, strong) XHBranchTextView *midBranchTextView;
@property (nonatomic, strong) XHBranchTextView *bottomBranchTextView;

@property (nonatomic, strong) XHCenterView *centerView;

@property (nonatomic, assign) XHTagAnimationStyle tagAnimationStyle;
@property (nonatomic, strong) NSMutableArray *branchPoints;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

// C6 3的组合，有4种可能是我们想要的

@end

@implementation XHTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    self.radius = 3;
    self.panGestureOnTagViewed = YES;
    
    [self.layer addSublayer:self.topBranchLayer];
    [self.layer addSublayer:self.midBranchLayer];
    [self.layer addSublayer:self.bottomBranchLayer];
    
    [self addSubview:self.topBranchTextView];
    [self addSubview:self.midBranchTextView];
    [self addSubview:self.bottomBranchTextView];
    
    [self addSubview:self.centerView];
}

- (void)showInPoint:(CGPoint)point {
    // 带有脉冲的中心点位置
    self.center = point;
    
    CGPoint center = [self tagCenterPoint];
    
    [self.centerView show];
    self.centerView.alpha = 1.0;
    self.centerView.center = center;
    
    self.tagAnimationStyle = XHTagAnimationStyleDoubleRight;
    [self animation];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.showing = NO;
    }];
}

- (void)animation {
    switch (self.tagAnimationStyle) {
        case XHTagAnimationStyleAllLeft: {
            [self setupBranchLayer:self.topBranchLayer branchPoint:self.branchPoints[2]];
            [self setupBranchLayer:self.midBranchLayer branchPoint:self.branchPoints[1]];
            [self setupBranchLayer:self.bottomBranchLayer branchPoint:self.branchPoints[0]];
            break;
        }
        case XHTagAnimationStyleAllRight: {
            [self setupBranchLayer:self.topBranchLayer branchPoint:self.branchPoints[5]];
            [self setupBranchLayer:self.midBranchLayer branchPoint:self.branchPoints[4]];
            [self setupBranchLayer:self.bottomBranchLayer branchPoint:self.branchPoints[3]];
            break;
        }
        case XHTagAnimationStyleDoubleLeft: {
            [self setupBranchLayer:self.topBranchLayer branchPoint:self.branchPoints[2]];
            [self setupBranchLayer:self.midBranchLayer branchPoint:self.branchPoints[4]];
            [self setupBranchLayer:self.bottomBranchLayer branchPoint:self.branchPoints[0]];
            break;
        }
        case XHTagAnimationStyleDoubleRight: {
            [self setupBranchLayer:self.topBranchLayer branchPoint:self.branchPoints[5]];
            [self setupBranchLayer:self.midBranchLayer branchPoint:self.branchPoints[1]];
            [self setupBranchLayer:self.bottomBranchLayer branchPoint:self.branchPoints[3]];
            break;
        }
        default:
            break;
    }
    
    [self.centerView stopAnimation];
    [self.topBranchTextView dismiss];
    [self.midBranchTextView dismiss];
    [self.bottomBranchTextView dismiss];
    
    __weak typeof(self) weakSelf = self;
    [self.topBranchLayer animationDelay:0.0 completion:^(BOOL finished, XHBranchLayer *branchLayer) {
        if (finished) {
            [weakSelf.topBranchTextView showInPoint:branchLayer.endPoint direction:branchLayer.direction];
            [weakSelf.centerView startAnimation];
        }
    }];
    [self.midBranchLayer animationDelay:0.0 completion:^(BOOL finished, XHBranchLayer *branchLayer) {
        if (finished) {
            [weakSelf.midBranchTextView showInPoint:branchLayer.endPoint direction:branchLayer.direction];
        }
    }];
    [self.bottomBranchLayer animationDelay:0.0 completion:^(BOOL finished, XHBranchLayer *branchLayer) {
        if (finished) {
            [weakSelf.bottomBranchTextView showInPoint:branchLayer.endPoint direction:branchLayer.direction];
        }
    }];
}

- (void)centerButtonClick:(UIButton *)sender {
    if (self.tagAnimationStyle == XHTagAnimationStyleAllLeft) {
        self.tagAnimationStyle = XHTagAnimationStyleAllRight;
    } else if (self.tagAnimationStyle == XHTagAnimationStyleAllRight) {
        self.tagAnimationStyle = XHTagAnimationStyleDoubleLeft;
    } else if (self.tagAnimationStyle == XHTagAnimationStyleDoubleLeft) {
        self.tagAnimationStyle = XHTagAnimationStyleDoubleRight;
    } else if (self.tagAnimationStyle == XHTagAnimationStyleDoubleRight) {
        self.tagAnimationStyle = XHTagAnimationStyleAllLeft;
    } else if (self.tagAnimationStyle == XHTagAnimationStyleAllLeft) {
        self.tagAnimationStyle = XHTagAnimationStyleAllRight;
    }
    [self animation];
}

- (void)setupBranchLayer:(XHBranchLayer *)branchLayer branchPoint:(XHBranchPoint *)branchPoint {
    [self setupBranchLayer:branchLayer
                startPoint:branchPoint.startPoint
                  midPoint:branchPoint.midPoint
                  endPoint:branchPoint.endPoint
                 direction:branchPoint.direction];
}

- (void)setupBranchLayer:(XHBranchLayer *)branchLayer startPoint:(CGPoint)startPoint midPoint:(CGPoint)midPoint endPoint:(CGPoint)endPoint direction:(XHBranchLayerDirection)direction {
    branchLayer.startPoint = startPoint;
    branchLayer.direction = direction;
    branchLayer.midPoint = midPoint;
    branchLayer.endPoint = endPoint;
    branchLayer.radius = self.radius;
}

#pragma mark - Gesture Handles

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    
    self.center = CGPointMake(self.center.x + point.x, self.center.y + point.y);
    
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
}

#pragma mark - Propertys

- (void)setPanGestureOnTagViewed:(BOOL)panGestureOnTagViewed {
    _panGestureOnTagViewed = panGestureOnTagViewed;
    if (panGestureOnTagViewed) {
        if (![self validatePanGesture]) {
            [self addGestureRecognizer:self.panGestureRecognizer];
        }
    } else {
        if ([self validatePanGesture]) {
            [self removeGestureRecognizer:self.panGestureRecognizer];
        }
    }
}

- (BOOL)validatePanGesture {
    return [self.gestureRecognizers containsObject:self.panGestureRecognizer];
}

- (XHBranchLayer *)topBranchLayer {
    if (!_topBranchLayer) {
        _topBranchLayer = [XHBranchLayer new];
    }
    return _topBranchLayer;
}

- (XHBranchLayer *)midBranchLayer {
    if (!_midBranchLayer) {
        _midBranchLayer = [XHBranchLayer new];
        _midBranchLayer.toValue = 0.62;
    }
    return _midBranchLayer;
}

- (XHBranchLayer *)bottomBranchLayer {
    if (!_bottomBranchLayer) {
        _bottomBranchLayer = [XHBranchLayer new];
    }
    return _bottomBranchLayer;
}

- (XHBranchTextView *)topBranchTextView {
    if (!_topBranchTextView) {
        _topBranchTextView = [[XHBranchTextView alloc] initWithFrame:CGRectZero];
    }
    return _topBranchTextView;
}

- (XHBranchTextView *)midBranchTextView {
    if (!_midBranchTextView) {
        _midBranchTextView = [[XHBranchTextView alloc] initWithFrame:CGRectZero];
    }
    return _midBranchTextView;
}

- (XHBranchTextView *)bottomBranchTextView {
    if (!_bottomBranchTextView) {
        _bottomBranchTextView = [[XHBranchTextView alloc] initWithFrame:CGRectZero];
    }
    return _bottomBranchTextView;
}

- (XHCenterView *)centerView {
    if (!_centerView) {
        _centerView = [[XHCenterView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        _centerView.alpha = 0.0;
        _centerView.center = [self tagCenterPoint];
        [_centerView.button addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerView;
}

- (NSMutableArray *)branchPoints {
    if (!_branchPoints) {
        _branchPoints = [[NSMutableArray alloc] init];
        
        CGPoint center = [self tagCenterPoint];
        
        [_branchPoints addObject:[XHBranchPoint initlizerStartPoint:center
                                                           midPoint:CGPointMake(center.x - 20, center.y + 35)
                                                           endPoint:CGPointMake(center.x - 40, center.y + 35)
                                                          direction:XHBranchLayerDirectionLeft]];
        [_branchPoints addObject:[XHBranchPoint initlizerStartPoint:center
                                                           midPoint:CGPointMake(center.x - 10, center.y)
                                                           endPoint:CGPointMake(center.x - 30, center.y)
                                                          direction:XHBranchLayerDirectionLeft]];
        [_branchPoints addObject:[XHBranchPoint initlizerStartPoint:center
                                                           midPoint:CGPointMake(center.x - 20, center.y - 35)
                                                           endPoint:CGPointMake(center.x - 40, center.y - 35)
                                                          direction:XHBranchLayerDirectionLeft]];
        
        [_branchPoints addObject:[XHBranchPoint initlizerStartPoint:center
                                                           midPoint:CGPointMake(center.x + 20, center.y + 35)
                                                           endPoint:CGPointMake(center.x + 40, center.y + 35)
                                                          direction:XHBranchLayerDirectionRight]];
        [_branchPoints addObject:[XHBranchPoint initlizerStartPoint:center
                                                           midPoint:CGPointMake(center.x + 10, center.y)
                                                           endPoint:CGPointMake(center.x + 30, center.y)
                                                          direction:XHBranchLayerDirectionRight]];
        [_branchPoints addObject:[XHBranchPoint initlizerStartPoint:center
                                                           midPoint:CGPointMake(center.x + 20, center.y - 35)
                                                           endPoint:CGPointMake(center.x + 40, center.y - 35)
                                                          direction:XHBranchLayerDirectionRight]];
    }
    return _branchPoints;
}

- (void)setBranchTexts:(NSArray *)branchTexts {
    if (_branchTexts == branchTexts) {
        return;
    }
    _branchTexts = branchTexts;
    _topBranchTextView.branchText = [self.branchTexts firstObject];
    _midBranchTextView.branchText = (self.branchTexts.count > 1 ? self.branchTexts[1] : @"");
    _bottomBranchTextView.branchText = [self.branchTexts lastObject];
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}

- (NSArray *)initlizerTagAnimationBranchWithTopBranchPoint:(XHBranchPoint *)topBranchPoint
                                            midBranchPoint:(XHBranchPoint *)midBranchPoint
                                            endBranchPoint:(XHBranchPoint *)endBranchPoint {
    NSArray *tagAnimationBranch = @[topBranchPoint, midBranchPoint, endBranchPoint];
    return tagAnimationBranch;
}


- (CGPoint)tagCenterPoint {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    return center;
}

@end