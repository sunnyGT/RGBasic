//
//  XMProjectManager.m
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMProjectManager.h"
#import "XMNavigationController.h"
#import "XMTabBarController.h"
#import "XMAppDelegate.h"

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
    
    UIViewController * selectVC = ((XMTabBarController *)self.appDelegate.window.rootViewController).selectedViewController;
    if ([selectVC isKindOfClass:[UINavigationController class]]) {
        return ((XMNavigationController *)selectVC).topViewController;
    }
    return selectVC;
}

@end
