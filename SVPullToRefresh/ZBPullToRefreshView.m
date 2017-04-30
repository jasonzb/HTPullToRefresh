//
//  ZBPullToRefreshView.m
//  HTPullToRefreshDemo
//
//  Created by zhaobin on 2017/4/30.
//  Copyright © 2017年 Hoang Tran. All rights reserved.
//

#import "ZBPullToRefreshView.h"

@interface ZBPullToRefreshView ()

- (void)initSelf;

@end

@implementation ZBPullToRefreshView

- (instancetype)init {
    if (self = [super init]) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initSelf];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
    path.lineWidth = 1.0;
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path addQuadCurveToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height) controlPoint:CGPointMake(0, self.bounds.size.height / 2)];
    [path closePath];
    [path stroke];
    [path fill];
}

#pragma mark - Private

- (void)initSelf {
    self.backgroundColor = [UIColor clearColor];
    [self setCustomView:[[UIView alloc] init] forState:SVPullToRefreshStateAll];
}

@end
