//
//  XMViewController.h
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UINavigationBar+XMNavigationTool.h"


@protocol XMViewControllerDelegate <NSObject>

@optional

- (UIBarButtonItem *)defaultNavigationBarLeftItem;


- (UIBarButtonItem *)setNavigationBarLeftItemWithImage:(UIImage *)image;
- (UIBarButtonItem *)setNavigationBarLeftItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)setNavigationBarLeftItemWithCustomView:(UIView *)customView;

- (UIBarButtonItem *)setNavigationBarRightItemWithImage:(UIImage *)image;
- (UIBarButtonItem *)setNavigationBarRightItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)setNavigationBarRightItemWithCustomView:(UIView *)customView;

- (void)customLeftNavItemAction:(UIBarButtonItem *)sender;
- (void)customRightNavItemAction:(UIBarButtonItem *)sender;

@end


@interface XMViewController : UIViewController <XMViewControllerDelegate>

@property (nonatomic , copy)NSDictionary *params;

@end
