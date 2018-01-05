//
//  UIButton+ImageAndTitleLayout.h
//  WYButtonDemoi
//
//  Created by 意一yiyi on 2017/5/26.
//  Copyright © 2017年 yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageAndTitleLayoutStyle) {
    
    ImageAndTitleLayoutStyleImageOnLabel,
    ImageAndTitleLayoutStyleImageLeftToLabel,
    ImageAndTitleLayoutStyleImageUnderLabel,
    ImageAndTitleLayoutStyleImageRightToLabel
};

@interface UIButton (ImageAndTitleLayout)

- (void)layoutWithImageAndTitleLayoutStyle:(ImageAndTitleLayoutStyle)style
                           imageTitleSpace:(CGFloat)space;

@end
