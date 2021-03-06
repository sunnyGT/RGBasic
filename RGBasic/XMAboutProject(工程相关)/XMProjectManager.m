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
#import "AFNetworkReachabilityManager.h"
#import "UIViewController+Extend.h"

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

+ (void)setupReachability{


    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //无网络
                [[M topViewController] hideNetworkErrorView];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                //无网络
                [[M topViewController] showNetworkErrorView];
                break;
            case AFNetworkReachabilityStatusUnknown:
                //网络地址出错
                break;
            default:
                break;
        }
    }];
    
}

- (void)dealloc{
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
