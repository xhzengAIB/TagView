//
//  XHBranchTextView.m
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHBranchTextView.h"

@interface XHBranchTextView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation XHBranchTextView

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
    [self addSubview:self.arrowImageView];
    [self addSubview:self.textLabel];
    
    [self dismiss];
}

- (void)showInPoint:(CGPoint)point direction:(XHBranchLayerDirection)direction {
    [self.textLabel sizeToFit];
    
    CGFloat width = CGRectGetWidth(self.textLabel.bounds) + 20;
    CGFloat height = 24;
    
    CGRect frame = CGRectMake(point.x - width - 8, point.y - height / 2.0, width, 24);
    
    if (direction == XHBranchLayerDirectionRight) {
        frame = CGRectMake(point.x + 8, point.y - height / 2.0, width, 24);
    }
    
    if (!self.textLabel.text.length) {
        frame.size = CGSizeZero;
    }
    
    self.textLabel.center = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetHeight(frame) / 2.0);
    
    [self setupArrowImageWithDirection:direction];
    self.frame = frame;
    self.arrowImageView.frame = self.bounds;
    
    
    self.alpha = 0.0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    self.alpha = 0.0;
}

- (void)animation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.35;
    opacityAnimation.fromValue = @(0.0);
    opacityAnimation.toValue = @(1.0);
    opacityAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.numberOfLines = 1.0;
        _textLabel.font = [UIFont systemFontOfSize:11];
        _textLabel.textColor = [UIColor whiteColor];
    }
    return _textLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
    }
    return _arrowImageView;
}

- (void)setBranchText:(NSString *)branchText {
    _branchText = branchText;
    self.textLabel.text = branchText;
}

- (void)setupArrowImageWithDirection:(XHBranchLayerDirection)direction {
    self.arrowImageView.image = [[UIImage imageNamed:(direction == XHBranchLayerDirectionRight ? @"tag-background-right" : @"tag-background-left")] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
}

@end