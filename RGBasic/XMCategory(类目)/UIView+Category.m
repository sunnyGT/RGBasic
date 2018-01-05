//
//  UIView+Category.m
//  意一Test
//
//  Created by 意一yiyi on 2017/5/25.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

#define kStatusBarHeight 20
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation UIView (Category)

#pragma makr - public methods

- (CGFloat)hk_updateOffsetY:(CGFloat)deltaY {
    
    CGFloat viewOffsetY = 0;
    CGFloat newOffsetY = [self hk_offsetYWithDelta:deltaY];
    viewOffsetY = CGRectGetMinY(self.frame) - newOffsetY;
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = newOffsetY;
    self.frame = viewFrame;
    
    return viewOffsetY;
}

- (CGFloat)hk_open {
    
    CGFloat viewOffsetY = 0;
    viewOffsetY = CGRectGetMinY(self.frame) - [self hk_openOffsetY];
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = [self hk_openOffsetY];
    self.frame = viewFrame;
    
    return viewOffsetY;
}

- (CGFloat)hk_close {
    
    CGFloat viewOffsetY = 0;
    viewOffsetY = CGRectGetMinY(self.frame) - [self hk_closeOffsetY];
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = [self hk_closeOffsetY];
    self.frame = viewFrame;
    
    return viewOffsetY;
}

- (BOOL)hk_shouldOpen {
    
    CGFloat viewY = CGRectGetMinY(self.frame);
    CGFloat viewMinY = [self hk_openOffsetY];
    BOOL shouldOpen = YES;
    
    if (self.hk_postion == MovingViewPositionTop) {
        
        viewMinY = [self hk_closeOffsetY] + ([self hk_openOffsetY] - [self hk_closeOffsetY]) * 0.5;
        shouldOpen = viewY >= viewMinY;
    }else if (self.hk_postion == MovingViewPositionBottom) {
        
        viewMinY = [self hk_openOffsetY] + ([self hk_closeOffsetY] - [self hk_openOffsetY]) * 0.5;
        shouldOpen = viewY <= viewMinY;
    }
    
    return shouldOpen;
}


#pragma mark - private methods

- (CGFloat)hk_offsetYWithDelta:(CGFloat)deltaY {
    
    CGFloat newOffsetY = 0;
    CGFloat openOffsetY = [self hk_openOffsetY];
    CGFloat closeOffsetY = [self hk_closeOffsetY];
    
    if (self.hk_postion == MovingViewPositionTop) {
        
        newOffsetY = CGRectGetMinY(self.frame) - deltaY;
        newOffsetY = MAX(closeOffsetY, MIN(openOffsetY, newOffsetY));
    }else if (self.hk_postion == MovingViewPositionBottom) {
        
        newOffsetY = CGRectGetMinY(self.frame) + deltaY;
        newOffsetY = MIN(closeOffsetY, MAX(openOffsetY, newOffsetY));
    }
    
    return newOffsetY;
}

- (CGFloat)hk_openOffsetY {
    
    CGFloat openOffsetY = 0;
    
    if (self.hk_postion == MovingViewPositionTop) {
        
        openOffsetY = kStatusBarHeight;
    }else if (self.hk_postion == MovingViewPositionBottom) {
        
        openOffsetY = kScreenHeight - CGRectGetHeight(self.frame);
    }
    
    return openOffsetY;
}

- (CGFloat)hk_closeOffsetY {
    
    CGFloat closeOffsetY = 0;
    
    if (self.hk_postion == MovingViewPositionTop) {
        
        closeOffsetY = -(CGRectGetHeight(self.frame) + self.hk_extraDistance);
    }else if (self.hk_postion == MovingViewPositionBottom) {
        
        closeOffsetY = kScreenHeight + self.hk_extraDistance;
    }
    
    return closeOffsetY;
}


#pragma mark - setters, getters

- (void)setHk_postion:(MovingViewPosition)hk_postion {
    
    objc_setAssociatedObject(self, @selector(hk_postion), @(hk_postion), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setHk_extraDistance:(CGFloat)hk_extraDistance {
    
    objc_setAssociatedObject(self, @selector(hk_extraDistance), @(hk_extraDistance), OBJC_ASSOCIATION_ASSIGN);
}

- (MovingViewPosition)hk_postion {
    
    NSNumber *postionNumber = objc_getAssociatedObject(self, @selector(hk_postion));
    if (!postionNumber) {
        
        return MovingViewPositionTop;
    }
    
    return [postionNumber integerValue];
}

- (CGFloat)hk_extraDistance {
    
    NSNumber *extraDistanceNumber = objc_getAssociatedObject(self, @selector(hk_extraDistance));
    
    if (!extraDistanceNumber) {
        
        return 0;
    }
    
    return [extraDistanceNumber floatValue];
}

@end
