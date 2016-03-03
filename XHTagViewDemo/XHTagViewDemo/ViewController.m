//
//  ViewController.m
//  XHTagViewDemo
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com. All rights reserved.
//

#import "ViewController.h"
#import <XHTagView/XHTagView.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet XHTagView *tagView;

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagView.branchTexts = @[@"我在吃广州美食",
                                 @"天猫可以买",
                                 @"Link: https://www...."];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint point = [tapGestureRecognizer locationInView:tapGestureRecognizer.view];
    
    [self.tagView showInPoint:point];
}

- (void)showTagView {
    [self.tagView showInPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))];
}

- (void)dismissTagView {
    [self.tagView dismiss];
    self.tagView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
