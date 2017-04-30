//
//  ZBPullToRefreshView.m
//  HTPullToRefreshDemo
//
//  Created by zhaobin on 2017/4/30.
//  Copyright © 2017年 Hoang Tran. All rights reserved.
//

#import "ZBPullToRefreshView.h"

static CGFloat const kSVPullToRefreshViewWidth = 60;

@interface ZBPullToRefreshView ()
{
    NSMutableAttributedString *attributedString;
    NSMutableParagraphStyle *paragraphStyle;
}

@property (nonatomic, strong) UILabel *tLabel;

- (void)initSelf;
- (NSString *)verticalString:(NSString *)string;

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

#pragma mark - Accessor

- (UILabel *)tLabel {
    if (!_tLabel) {
        _tLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height)];
        _tLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _tLabel.textAlignment = NSTextAlignmentCenter;
        _tLabel.font = [UIFont systemFontOfSize:11.0];
        _tLabel.numberOfLines = 0;
        _tLabel.text = [self verticalString:@"更多"];
        _tLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_tLabel];
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:_tLabel.text];
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5.0f];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, 0)];
        _tLabel.attributedText = attributedString;
    }
    return _tLabel;
}

#pragma mark - Private

- (void)initSelf {
    self.backgroundColor = [UIColor clearColor];
    [self setCustomView:[[UIView alloc] init] forState:SVPullToRefreshStateAll];
    [self tLabel];
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
}

- (NSString *)verticalString:(NSString *)string {
    NSMutableString *str = [[NSMutableString alloc] initWithString:string];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if ([object isEqual:self] && [keyPath isEqualToString:@"frame"]) {
        id newVal = [change objectForKey:NSKeyValueChangeNewKey];
        CGRect frame = [newVal CGRectValue];
        if (frame.size.width >= kSVPullToRefreshViewWidth) {
            _tLabel.text = [self verticalString:@"释放查看"];
            attributedString = [[NSMutableAttributedString alloc] initWithString:_tLabel.text];
            _tLabel.attributedText = attributedString;
        } else {
            _tLabel.text = [self verticalString:@"更多"];
            attributedString = [[NSMutableAttributedString alloc] initWithString:_tLabel.text];
            _tLabel.attributedText = attributedString;
        }
        [_tLabel setNeedsDisplay];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
