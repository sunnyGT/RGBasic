//
//  UINavigationBar+XMNavigationTool.h
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (XMNavigationTool)

- (void)xm_setBackgroundColor:(UIColor *)customColor;

- (void)xm_setAlpha:(CGFloat)alpha;

- (void)xm_setBackgroundViewAlpha:(CGFloat)alpha;

- (void)xm_setTranslationY:(CGFloat)translationY;

- (void)xm_reset;

@end
