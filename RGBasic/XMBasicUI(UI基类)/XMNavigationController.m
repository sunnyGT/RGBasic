//
//  XMNavigationController.m
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMNavigationController.h"
#import "XMViewController.h"
#import "XMNavigationBar.h"
@interface XMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XMNavigationController

- (BOOL)shouldAutorotate{
    
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    [self.interactivePopGestureRecognizer addTarget:self action:@selector(popGesture:)];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count == 1) {
        
       viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];

}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [self initWithNavigationBarClass:[XMNavigationBar class] toolbarClass:nil];
    [self pushViewController:rootViewController animated:NO];
    return self;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}


- (void)popGesture:(UIScreenEdgePanGestureRecognizer *)sender{
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
        case UIGestureRecognizerStatePossible:
            
            break;
        case UIGestureRecognizerStateFailed:
            
            break;
            
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        
        return self.viewControllers.count > 1;
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
