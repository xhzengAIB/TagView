//
//  XHBranchPoint.h
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XHTagHeader.h"

@interface XHBranchPoint : NSObject

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

+ (instancetype)initlizerStartPoint:(CGPoint)startPoint
                           midPoint:(CGPoint)midPoint
                           endPoint:(CGPoint)endPoint
                          direction:(XHBranchLayerDirection)direction;

@end