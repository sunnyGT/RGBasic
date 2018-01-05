//
//  XMTabBarController.h
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMTabBarControllerDelegate <NSObject>

- (BOOL)customTabBarController:(UITabBarController *)tabbarController shouldSelectViewController:(UIViewController *)viewController;

@end

@interface XMTabBarController : UITabBarController

@property (nonatomic ,copy)NSArray *customIdxes;
@property (nonatomic ,weak)id<XMTabBarControllerDelegate>XM_delegate;

/**
 主视图控制器
 
 @param viewControllers 子控制器数组 (存在自定义的TabbarItem时;传入一个空的VC占位)
 @param titles TabbarItems标题 (存在自定义的TabbarItem时;传入一个空的字符串占位)
 @param images TabbarItems 未选中时图标
 @param selectImages TabbarItems 选中时图标图标
 @return XMTabBarController
 */
+ (XMTabBarController *)XMTabBarController:(NSArray<UIViewController *>*)viewControllers
                                   titiles:(NSArray <NSString *>*)titles
                                itemImages:(NSArray <NSString *>*)images
                            selectedImages:(NSArray <NSString *>*)selectImages;


/**
 主视图控制器附带自定义控制器

 @param viewControllers 子控制器数组 (存在自定义的TabbarItem时;传入一个空的VC占位)
 @param titles TabbarItems标题 (存在自定义的TabbarItem时;传入一个空的字符串占位)
 @param images TabbarItems 未选中时图标
 @param selectImages TabbarItems 选中时图标图标
 @param indexes 自定义控制器数组
 @return XMTabBarController
 */
+ (XMTabBarController *)XMTabBarController:(NSArray<UIViewController *>*)viewControllers
                                   titiles:(NSArray <NSString *>*)titles
                                itemImages:(NSArray <NSString *>*)images
                            selectedImages:(NSArray <NSString *>*)selectImages customViewControllerIndexes:(NSArray<NSNumber *>*)indexes;

@end
