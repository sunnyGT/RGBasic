//
//  XMTabBarController.m
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMTabBarController.h"
#import "XMNavigationController.h"
#import "XMNavigationBar.h"
#import "XMViewController.h"
#import "XMMacro.h"

@interface XMTabBarController ()<UITabBarControllerDelegate>

@end

#define isContain(object) ([_customIdxes containsObject:object])
@implementation XMTabBarController


- (BOOL)shouldAutorotate{
    
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

+ (XMTabBarController *)XMTabBarController:(NSArray<UIViewController *> *)viewControllers
                                   titiles:(NSArray<NSString *> *)titles
                                itemImages:(NSArray<NSString *> *)images
                            selectedImages:(NSArray<NSString *> *)selectImages{
    
    XMTabBarController *tabBarController = [XMTabBarController new];
    tabBarController.delegate = tabBarController;
    tabBarController.tabBar.translucent = NO;
    [tabBarController setupViewControllers:viewControllers];
    [tabBarController setupTabbar:titles images:images selectedImages:selectImages];
    
    return tabBarController;
}

+ (XMTabBarController *)XMTabBarController:(NSArray<UIViewController *> *)viewControllers
                                    titiles:(NSArray<NSString *> *)titles
                                 itemImages:(NSArray<NSString *> *)images
                             selectedImages:(NSArray<NSString *> *)selectImages customViewControllerIndexes:(NSArray<NSNumber *> *)indexes{
    
    XMTabBarController *tabBarController = [XMTabBarController new];
    tabBarController.delegate = tabBarController;
    tabBarController.tabBar.translucent = NO;
    tabBarController.customIdxes = indexes;
    [tabBarController setupViewControllers:viewControllers];
    [tabBarController setupTabbar:titles images:images selectedImages:selectImages];
    return tabBarController;
}

- (UITabBarController *)setupViewControllers:(NSArray<UIViewController *> *)viewControllers{
    __block NSMutableArray *tempViewControlls = [NSMutableArray array];
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([_customIdxes containsObject:@(idx)]) {
            
            [tempViewControlls addObject:obj];
        }else {
            XMNavigationController *nav = [[XMNavigationController alloc]initWithNavigationBarClass:[XMNavigationBar class] toolbarClass:nil];
            [nav pushViewController:obj animated:NO];
            [tempViewControlls addObject:nav];
        }
        
    }];
    self.viewControllers = [tempViewControlls mutableCopy];
    return self;
}

- (UITabBarController *)setupTabbar:(NSArray<NSString *> *)titles images:(NSArray <NSString *>*)images selectedImages:(NSArray<NSString *> *)selectImages {
    
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UINavigationController *nav = (UINavigationController *)obj;
        
        UIImage *originalImage = [[UIImage imageNamed:images[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectImage = [[UIImage imageNamed:selectImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[idx] image:originalImage selectedImage:selectImage];
        //nav.tabBarItem.badgeValue = @"99";
    }];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabbarAppearence];
    // Do any additional setup after loading the view.
}

#pragma mark - 自定义Tabber样式
- (void)configureTabbarAppearence{
    
    self.tabBar.tintColor = ThemeTintColor;
}

#pragma mark - 自定义事件
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    if ([self.XM_delegate respondsToSelector:@selector(customTabBarController:shouldSelectViewController:)]) {
        return [self.XM_delegate customTabBarController:tabBarController shouldSelectViewController:viewController];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
