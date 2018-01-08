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

@protocol XMAppDelegateDelegate<NSObject>
@optional
- (void)configureProjectBeforeWindownVisible;
@end

@interface XMAppDelegate : UIResponder <UIApplicationDelegate,XMAppDelegateDelegate>

@property (strong, nonatomic) UIWindow *window;

- (XMTabBarController *)setupRootViewController;

@end

