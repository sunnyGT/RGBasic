//
//  XMPopWindown.h
//  RGBasic
//
//  Created by robin on 2017/11/24.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMPopView;
@protocol XMPopViewDelegate<NSObject>

@optional
- (void)customAnimationForShow:(XMPopView *)popView;
- (void)customAnimationForHide:(XMPopView *)popView;
@end

@interface XMPopView : UIView
@property (nonatomic ,weak)id <XMPopViewDelegate> delegate;
@property (nonatomic ,strong)UIColor *backgroundViewColor;
@property (nonatomic ,strong)UIView *backgroundView;
@property (nonatomic ,strong)UIView *contentView;

- (instancetype)initWithView:(UIView *)view;

+ (XMPopView *)popToView:(UIView *)view contentView:(UIView *)contentView;
- (void)hideAnimated:(BOOL)animation;
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
- (void)show;
@end
