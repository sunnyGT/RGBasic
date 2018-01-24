//
//  XMViewController+Extend.m
//  RGBasic
//
//  Created by robin on 2018/1/15.
//  Copyright © 2018年 robin. All rights reserved.
//

#import "UIViewController+Extend.h"
#import <Objc/runtime.h>
#import "UIImage+XMUIImage.h"
#import "XMMacro.h"
@implementation UIViewController (Extend)
@dynamic alertView;
@dynamic netWorkErrorView;

XM_DYNAMIC_PROPERTY_OBJECT(netWorkErrorView, setNetWorkErrorView, RETAIN, UIView *);

XM_DYNAMIC_PROPERTY_OBJECT(alertView, setAlertView, RETAIN, UIView *)

- (void)showAlertViewWithContent:(NSString *)alertContent type:(AlertType)type animation:(BOOL)animation{
    if (self.alertView.superview) {
        [self hideAlertViewWithAniamtion:animation];
    }
    self.alertView = [self setupAlertViewWithContent:alertContent type:type];
    [self.view addSubview:self.alertView];
    [self.view bringSubviewToFront:self.alertView];

    if (animation) {

        self.alertView.layer.affineTransform = CGAffineTransformMakeTranslation(0, -45.f);
        [UIView animateWithDuration:0.25 animations:^{
        self.alertView.layer.affineTransform = CGAffineTransformIdentity;
        }];
        
    }else{
        [self.view addSubview:self.alertView];
        [self.view bringSubviewToFront:self.alertView];
    }
}

- (void)hideAlertViewWithAniamtion:(BOOL)animation{
    if (animation) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.alertView.layer.affineTransform = CGAffineTransformMakeTranslation(0, -150.f);
        [CATransaction commit];
    }
    [self.alertView removeFromSuperview];
    self.alertView = nil;
}

//中途断网提示alertViewn
- (UIView *)setupAlertViewWithContent:(NSString *)content type:(AlertType)type{
    
    UIView *contenView = [[UIView alloc] init];
    contenView.frame = CGRectMake(0, NavigationBarBottomY, Screen_Width, 45.f);
    contenView.userInteractionEnabled = NO;
    contenView.backgroundColor = type == AlertForError?[UIColor redColor]:[UIColor yellowColor];
    contenView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UILabel  *alertLabel = [[UILabel alloc] init];
    alertLabel.frame = CGRectMake(20, 0, CGRectGetWidth(contenView.frame) - 40, 45.f);
    alertLabel.font = [UIFont systemFontOfSize:15.f];
    alertLabel.text = content;
    alertLabel.textColor = type == AlertForError?[UIColor whiteColor]:[UIColor blackColor];
    [contenView addSubview:alertLabel];
    return contenView;
}

- (void)showNetworkErrorView{
    if (self.netWorkErrorView) return;
    
    UIView *contenView = [[UIView alloc] init];
    contenView.frame = self.view.frame;
    contenView.backgroundColor = self.view.backgroundColor;
    contenView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RGBasicSDK" ofType:@"bundle"];
    NSString *imgpath = [[NSBundle bundleWithPath:path] pathForResource:@"netWorkError" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgpath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = contenView.center;
    [contenView addSubview:imageView];
    
    self.netWorkErrorView = contenView;
    [self.view addSubview:contenView];
}

- (void)hideNetworkErrorView{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.netWorkErrorView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [self.netWorkErrorView removeFromSuperview];
        self.netWorkErrorView = nil;
    }];
}


@end
