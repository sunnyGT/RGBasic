//
//  UINavigationBar+XMNavigationTool.m
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "UINavigationBar+XMNavigationTool.h"
#import <objc/runtime.h>
#import "UIImage+AHUIImage.h"

@implementation UINavigationBar (XMNavigationTool)

XM_DYNAMIC_PROPERTY_OBJECT(coverLayer, setCoverLayer, RETAIN, UIView *)

- (void)xm_setBackgroundColor:(UIColor *)customColor{
    
    if (!self.coverLayer){
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.coverLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20.f)];
        self.coverLayer.userInteractionEnabled = NO;
        self.coverLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[self.subviews firstObject] insertSubview:self.coverLayer atIndex:0];
        [self setShadowImage:[UIImage new]];
    }
    self.coverLayer.backgroundColor = customColor;
}

- (void)xm_setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)xm_setBackgroundViewAlpha:(CGFloat)alpha{
    
    if (!self.coverLayer){
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.coverLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20.f)];
        self.coverLayer.userInteractionEnabled = NO;
        self.coverLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[self.subviews firstObject] insertSubview:self.coverLayer atIndex:0];
        [self setShadowImage:[UIImage new]];
    }
    self.coverLayer.layer.opacity = alpha;
}

- (void)xm_setAlpha:(CGFloat)alpha{

    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)xm_reset{
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    if (!CGAffineTransformIsIdentity(self.transform))
        self.transform = CGAffineTransformIdentity;
    [self.coverLayer removeFromSuperview];
    self.coverLayer = nil;    
}

@end
