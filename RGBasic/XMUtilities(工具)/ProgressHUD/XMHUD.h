//
//  AHHUD.h
//  AH
//
//  Created by Robin on 16/9/26.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;
@interface XMHUD : NSObject

+ (void)showHUDToView:(UIView *)view;
+ (void)showCustomHUDToView:(UIView *)view;
+ (void)showHUDToView:(UIView *)view text:(NSString *)text;

+ (void)showHUDToView:(UIView *)view delay:(NSTimeInterval)dalay;
+ (void)showHUDToView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)dalay;

+ (void)showHUDToView:(UIView *)view customView:(UIView *)customView;

//offsetY 相对于屏幕中心的偏移量
+ (void)showHUDToView:(UIView *)view onlyText:(NSString *)onlyText OffsetY:(CGFloat)OffsetY;
+ (void)showHUDToViewBottom:(UIView *)view onlyText:(NSString *)onlyText;
+ (void)showHUDToViewTop:(UIView *)view onlyText:(NSString *)onlyText;
+ (void)showHUDToView:(UIView *)view onlyText:(NSString *)onlyText;

+ (MBProgressHUD *)showHUDToView:(UIView *)view progress:(NSProgress *)progress complete:(BOOL)complete;
+ (void)popToView:(UIView *)view customView:(UIView *)cutomView;
+ (void)hideHUDForView:(UIView *)view;


@end
