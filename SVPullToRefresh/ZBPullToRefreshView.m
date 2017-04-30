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

#pragma mark - Private

- (void)initSelf {
    self.backgroundColor = [UIColor greenColor];
    [self setCustomView:[[UIView alloc] init] forState:SVPullToRefreshStateAll];
}

@end
