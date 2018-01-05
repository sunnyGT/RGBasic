//
//  UIView+XMViewRect.m
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "UIView+XMViewRect.h"

@implementation UIView (XMViewRect)


@dynamic midY,midX,maxY,maxX;

- (CGFloat)x{
    return CGRectGetMinX(self.frame);
}
- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y{
    return CGRectGetMinY(self.frame);
}
- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)midX{
    return CGRectGetMidX(self.frame);
}

- (void)setMidX:(CGFloat)midX{
    
    CGPoint center = self.center;
    center.x = midX;
    self.center = center;
}

- (CGFloat)midY{
    
    return CGRectGetMidY(self.frame);
}

- (void)setMidY:(CGFloat)midY{
    
    CGPoint center = self.center;
    center.y = midY;
    self.center = center;
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX{
    
    self.frame = CGRectMake(self.x, self.y, maxX - self.x, self.height);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY{
    self.frame = CGRectMake(self.x, self.y, self.width, maxY - self.y);
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGSize)size{
    return CGSizeMake(self.width, self.height);
}
- (void)setSize:(CGSize)size{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

- (void)setOrigin:(CGPoint)origin{
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}


@end
