//
//  AHHUD.m
//  AH
//
//  Created by Robin on 16/9/26.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "XMHUD.h"
#import "MBProgressHUD.h"
@implementation XMHUD

#define HUD_TOP_ORIGINY (115 * Screen_ScaleH - Screen_CenterY)
#define HUD_BOTTOM_ORIGINY (Screen_CenterY - 100 *Screen_ScaleH)

+ (void)showHUDToView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [view addSubview:hud];
    [hud showAnimated:YES];
}

+ (void)showCustomHUDToView:(UIView *)view{
    [self showHUDToView:view customView:nil];
}

+ (void)showHUDToView:(UIView *)view customView:(UIView *)customView{

    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = customView;
    [view addSubview:hud];
    [hud showAnimated:YES];
}
+  (void)popToView:(UIView *)view customView:(UIView *)customView{
    
    [MBProgressHUD hideHUDForView:view animated:YES];
    UIView * popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    popView.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.text = @"qeqweq";
    label.textColor = [UIColor whiteColor];
    //[popView addSubview:label];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = label;//[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.jpeg"]];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    [view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:5];
}

+ (void)showHUDToView:(UIView *)view delay:(NSTimeInterval)dalay{
    
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.mode = MBProgressHUDModeText;
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    hud.animationType = MBProgressHUDAnimationZoomOut;
    [hud hideAnimated:YES afterDelay:dalay];
}

+ (void)showHUDToView:(UIView *)view text:(NSString *)text{

    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [view addSubview:hud];
    [hud showAnimated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = text;
}

+ (void)showHUDToView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)dalay{
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = text;
    
    [hud hideAnimated:YES afterDelay:dalay];
    
}
+ (void)showHUDToViewTop:(UIView *)view onlyText:(NSString *)onlyText{
    
    [[self class] showHUDToView:view onlyText:onlyText OffsetY:HUD_TOP_ORIGINY];
}

+ (void)showHUDToViewBottom:(UIView *)view onlyText:(NSString *)onlyText{
    
    [[self class] showHUDToView:view onlyText:onlyText OffsetY:HUD_BOTTOM_ORIGINY];
}

+ (void)showHUDToView:(UIView *)view onlyText:(NSString *)onlyText{
    
    [[self class] showHUDToView:view onlyText:onlyText OffsetY:0];
}

+ (void)showHUDToView:(UIView *)view onlyText:(NSString *)onlyText OffsetY:(CGFloat)OffsetY{
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [view addSubview:hud];
    [hud showAnimated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = onlyText;
    hud.label.font = XMFontOfSize(14);
    hud.offset = CGPointMake(0, OffsetY);

    [hud hideAnimated:YES afterDelay:2.f];
}

+ (MBProgressHUD *)showHUDToView:(UIView *)view progress:(NSProgress *)progress complete:(BOOL)complete{
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.animationType = MBProgressHUDAnimationFade;
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.progressObject = progress;
    if (complete) {
        UIImage *image = [[UIImage imageNamed:@"Completed"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = @"完成";
    }
    return hud;

}


+ (void)hideHUDForView:(UIView *)view{
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}




@end
