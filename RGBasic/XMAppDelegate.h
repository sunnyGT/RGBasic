//
//  AppDelegate.h
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMProjectManager.h"
#import "XMTabBarController.h"

extern XMProjectManager *M;

@interface XMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XMTabBarController *rootViewController;

- (XMTabBarController *)setupRootViewController;

@end

