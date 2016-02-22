//
//  XHBranchLayer.h
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "XHTagHeader.h"

@class XHBranchLayer;

typedef void(^XHBranchLayerAnimationCompletion)(BOOL finished, XHBranchLayer *branchLayer);

@interface XHBranchLayer : CAShapeLayer

@property (nonatomic, assign) XHBranchLayerDirection direction;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint midPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat toValue;
@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)animationDelay:(NSTimeInterval)delay
            completion:(XHBranchLayerAnimationCompletion)completion;

@end
