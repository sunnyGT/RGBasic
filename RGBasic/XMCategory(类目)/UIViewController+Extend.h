//
//  XMViewController+Extend.h
//  RGBasic
//
//  Created by robin on 2018/1/15.
//  Copyright © 2018年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerEmptyDataSettingDelegate

@optional
- (NSString *)alertContent;
- (UIColor *)alertViewColor;
- (UIImage *)netErrorView;

- (void)refreshView;

@end

typedef NS_ENUM(NSUInteger, AlertType) {
    AlertForWarning,
    AlertForError
};

@interface UIViewController (Extend)

@property (nonatomic ,strong)UIView *alertView;
@property (nonatomic ,strong)UIView *netWorkErrorView;

- (void)showAlertViewWithContent:(NSString *)alertContent type:(AlertType)type animation:(BOOL)animation;

- (void)hideAlertViewWithAniamtion:(BOOL)animation;

- (void)showNetworkErrorView;
- (void)hideNetworkErrorView;
@end
