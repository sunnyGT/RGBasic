//
//  XMProjectManager.h
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XMAppDelegate;
@interface XMProjectManager : NSObject

@property (nonatomic ,weak)XMAppDelegate* appDelegate;

+ (XMProjectManager *)manager;

+ (void)setupReachability;
/**
 
 @return 当前显示的视图
 */
- (UIViewController *)topViewController;

@end
