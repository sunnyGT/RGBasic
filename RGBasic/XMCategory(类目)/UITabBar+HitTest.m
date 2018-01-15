//
//  UITabBar+HitTest.m
//  RGBasic
//
//  Created by robin on 2018/1/9.
//  Copyright © 2018年 robin. All rights reserved.
//

#import "UITabBar+HitTest.h"

@implementation UITabBar (HitTest)



- (BOOL)cusPointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    [self cusPointInside:point withEvent:event];
    
    CGRect frame =  [event.allTouches anyObject].view.frame;
    if (CGRectContainsPoint(frame, point)) {
        return YES;
    }
    return YES;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect frame =  [event.allTouches anyObject].view.frame;
    if (CGRectContainsPoint(frame, point)) {
        return YES;
    }
    return [super pointInside:point withEvent:event];
}

@end
