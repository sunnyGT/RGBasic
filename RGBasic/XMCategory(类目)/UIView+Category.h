//
//  UIView+Category.h
//  意一Test
//
//  Created by 意一yiyi on 2017/5/25.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MovingViewPosition) {
    
    // NavBar
    MovingViewPositionTop,
    
    // TabBar
    MovingViewPositionBottom
};

@interface UIView (Category)

// NavBar or TabBar
@property (assign, nonatomic) MovingViewPosition hk_postion;
// 需要额外移动的距离
@property (assign, nonatomic) CGFloat hk_extraDistance;

- (CGFloat)hk_updateOffsetY:(CGFloat)deltaY;

- (CGFloat)hk_open;

- (CGFloat)hk_close;

- (BOOL)hk_shouldOpen;

@end
