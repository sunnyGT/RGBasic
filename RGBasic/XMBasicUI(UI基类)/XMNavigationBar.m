//
//  XMNavigationBar.m
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMNavigationBar.h"

@implementation XMNavigationBar


- (instancetype)init{
    self = [super init];
    if (self) {
        [self defaultAttributes];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self defaultAttributes];
    }
    return self;
}


#pragma mark - configure custom titleTextAttributes
- (void)defaultAttributes{

    self.barTintColor = ThemeColor;
    self.translucent = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
