//
//  XHFocusLayer.h
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface XHFocusLayer : CAReplicatorLayer

/**
 *  缩放动画开始的半径值
 *
 *	默认值 0.0
 */
@property (nonatomic, assign) CGFloat fromValueForRadius;

/**
 *  透明动画开始的透明度值
 *
 *	默认值 0.45
 */
@property (nonatomic, assign) CGFloat fromValueForAlpha;

/**
 *	关键帧动画中，透明度的中间值
 *
 *	默认值 0.2
 */
@property (nonatomic, assign) CGFloat keyTimeForHalfOpacity;

/**
 *  脉冲动画的重复次数
 *
 *	默认值 INFINITY.
 */
@property (nonatomic, assign) float repeatCount;

/**
 *  圆形脉冲的半径
 *
 *	默认值 15pt.
 */
@property (nonatomic, assign) CGFloat radius;

/**
 *	以秒为单位的动画时间.
 *
 *	默认值 1.0
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 *  圆形脉冲的个数
 *
 *	默认值 1
 */
@property (nonatomic, assign) NSInteger focusLayerNumber;

- (void)startAnimation;
- (void)stopAnimation;

@end