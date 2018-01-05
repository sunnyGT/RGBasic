//
//  XMPopWindown.m
//  RGBasic
//
//  Created by robin on 2017/11/24.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMPopView.h"

@interface XMPopView(){
    
}
@end

@implementation XMPopView

+ (XMPopView *)popToView:(UIView *)view contentView:(UIView *)contentView {
    XMPopView *popView = [[self alloc] initWithView:view];
    popView.contentView = contentView;
    [popView show];
    return popView;
}

- (instancetype)initWithView:(UIView *)view{
    self = [super initWithFrame:view.frame];
    if (self) {
        [view addSubview:self];
        [self setup];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
}

- (void)setup{
    
    self.backgroundViewColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6];

    [self addSubview:self.backgroundView];
}

- (void)setContentView:(UIView *)contentView{
    if ([_contentView isEqual:contentView]) return;
    _contentView = contentView;
    [self addSubview:_contentView];
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = self.backgroundViewColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_backgroundView addGestureRecognizer:tap];
        
    }
    return _backgroundView;
}
- (void)hide{
    
    [self hideAnimated:YES];
}

- (void)show{
    
    if ([self.delegate respondsToSelector:@selector(customAnimationForShow:)]) {
        [self.delegate customAnimationForShow:self];
    }else{
        self.backgroundView.layer.opacity = 0.f;
        self.contentView.layer.affineTransform = CGAffineTransformMakeScale(5, 5);
        self.contentView.layer.opacity = 0.f;
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundView.layer.opacity = 0.3f;
            self.contentView.layer.affineTransform = CGAffineTransformIdentity;
            self.contentView.layer.opacity = 1.f;
        } completion:^(BOOL finished) {
            if (finished) {
                self.backgroundView.layer.opacity = 1.f;
                self.contentView.layer.affineTransform = CGAffineTransformIdentity;
            }
        }];
    }
}

- (void)hideAnimated:(BOOL)animation{
    if (!animation) {
        [self removeFromSuperview];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(customAnimationForHide:)]) {
        [self.delegate customAnimationForHide:self];
    }else{
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundView.layer.opacity = 0.f;
            self.contentView.layer.opacity = 0.f;
            self.contentView.layer.affineTransform = CGAffineTransformMakeScale(0.5, 0.5);
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    XMPopView *pop = [self popViewForView:view];
    if (pop != nil) {
        [pop hideAnimated:animated];
        return YES;
    }
    return NO;
}

+ (XMPopView *)popViewForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (XMPopView *)subview;
        }
    }
    return nil;
}
@end
