//
//  XHBranchLayer.h
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "XHTagHeader.h"

@class XHBranchLayer;

typedef void(^XHBranchLayerAnimationCompletion)(BOOL finished, XHBranchLayer *branchLayer);

@interface XHBranchLayer : CAShapeLayer

/**
 *  分支在动画中的朝向
 *
 *	默认是右边
 */
@property (nonatomic, assign) XHBranchLayerDirection direction;

/**
 *  分支在动画的起始位置
 *
 *	默认值 CGPointZero
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 *  分支在动画的中间位置
 *
 *	默认值 CGPointZero
 */
@property (nonatomic, assign) CGPoint midPoint;

/**
 *  分支在动画的结束位置
 *
 *	默认值 CGPointZero
 */
@property (nonatomic, assign) CGPoint endPoint;

/**
 *  分支动画末梢圆的半径
 *
 *	默认值 3.0
 */
@property (nonatomic, assign) CGFloat radius;

/**
 *  分支动画的结束值
 *
 *	默认值 0.57
 */
@property (nonatomic, assign) CGFloat toValue;

/**
 *	以秒为单位的动画时间.
 *
 *	默认值 0.55
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)animationDelay:(NSTimeInterval)delay
            completion:(XHBranchLayerAnimationCompletion)completion;

@end
