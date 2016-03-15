//
//  XHTagView.h
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHTagView : UIView

/**
 *  分支动画末梢圆圈的半径
 *
 *  默认值 3.0
 */
@property (nonatomic, assign) CGFloat radius;

/**
 *  获取标签视图是否显示，仅仅用于获取，不能赋值
 */
@property (nonatomic, assign, readonly) BOOL showing;

/**
 *  是否支持手势滑动TagView，默认是YES
 */
@property (nonatomic, assign) BOOL panGestureOnTagViewed;

/**
 *  标签分支的文本，总共三个
 */
@property (nonatomic, strong) NSArray *branchTexts;

- (void)showInPoint:(CGPoint)point;
- (void)dismiss;

@end