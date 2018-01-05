//
//  XMViewController.m
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMViewController.h"
#import "UIImage+AHUIImage.h"

@interface XMViewController ()

@end

@implementation XMViewController

- (BOOL)shouldAutorotate{

    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationFade;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customSetup];
    if (self.navigationController.viewControllers.count > 1) {
        if ([self respondsToSelector:@selector(defaultNavigationBarLeftItem)]) {
            [self defaultNavigationBarLeftItem];
        }
    }
}

#pragma mark - CustomConfigure
- (void)customSetup{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIBarButtonItem *)defaultNavigationBarLeftItem{
    
    UIBarButtonItem *leftItem = [self setNavigationBarLeftItemWithImage:[UIImage imageNamed:@"Nav_Back"]];
    [leftItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeColor} forState:UIControlStateNormal];
    return leftItem;    
}

#pragma mark - NavigationBarItem

#pragma mark leftItem

- (UIBarButtonItem *)setNavigationBarLeftItemWithImage:(UIImage *)image{

    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(customLeftNavItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftItem;
}

- (UIBarButtonItem *)setNavigationBarLeftItemWithTitle:(NSString *)title{
    
    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(customLeftNavItemAction:)];
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:XMFontOfSize(16.f)} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftItem;
}

- (UIBarButtonItem *)setNavigationBarLeftItemWithCustomView:(UIView *)customView{
    
    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc] initWithCustomView:customView];
    [leftItem setTarget:self];
    [leftItem setAction:@selector(customLeftNavItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftItem;
}

#pragma mark rightItem
- (UIBarButtonItem *)setNavigationBarRightItemWithImage:(UIImage *)image{
    
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(customRightNavItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightItem;
}

- (UIBarButtonItem *)setNavigationBarRightItemWithTitle:(NSString *)title{
    
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(customRightNavItemAction:)];
    [rightItem setTitleTextAttributes:@{NSFontAttributeName:XMFontOfSize(16.f)} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightItem;
}

- (UIBarButtonItem *)setNavigationBarRightItemWithCustomView:(UIView *)customView{
    
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithCustomView:customView];
    [rightItem setTarget:self];
    [rightItem setAction:@selector(customRightNavItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightItem;
}

- (void)customLeftNavItemAction:(UIBarButtonItem *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customRightNavItemAction:(UIBarButtonItem *)sender{
    
    NSLog(@"Attention!!!! Just fix warning please override the PUSH method in subclass");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
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
