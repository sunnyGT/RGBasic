//
//  XMProjectManager.m
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMProjectManager.h"

@implementation XMProjectManager

+ (XMProjectManager *)manager{
    
    static XMProjectManager *M = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        M = [[XMProjectManager alloc] init];
    });
    return M;
}

- (UIViewController *)topViewController{
    
    UIViewController * selectVC = ((XMTabBarController *)M.appDelegate.window.rootViewController).selectedViewController;
    if ([selectVC isKindOfClass:[UINavigationController class]]) {
        return ((XMNavigationController *)selectVC).topViewController;
    }
    return selectVC;
}

@end
