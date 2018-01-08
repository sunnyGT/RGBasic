//
//  XMForm.h
//  RGBasic
//
//  Created by robin on 2017/11/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    Form_TextField,
    Form_Accessory,
    Form_Vertica,
} FormType;

@protocol XMFormDelegate <NSObject>

@property (nonatomic ,assign)UIKeyboardType keyboardType;
@end


@interface XMFormAppearence:NSObject

@property (nonatomic ,strong)UIColor *titleColor;
@property (nonatomic ,strong)UIColor *contentColor;
@property (nonatomic ,strong)UIFont *titleFont;
@property (nonatomic ,strong)UIFont *contentFont;
@property (nonatomic ,assign)UIKeyboardType keyBoardType;
@property (nonatomic ,assign)NSTextAlignment textAlignment;
@property (nonatomic ,assign)BOOL isSecure;
@property (nonatomic ,assign)NSInteger maxLength;
@property (nonatomic ,assign)NSInteger minLength;
@end

@interface XMForm : NSObject

@property (nonatomic ,assign)FormType formType;
@property (nonatomic ,copy)  NSString *content;
@property (nonatomic ,assign)BOOL isMustFill;
@property (nonatomic ,copy)  NSString *title;
@property (nonatomic ,copy)  NSString *placeHolder;
@property (nonatomic ,strong)XMFormAppearence *appearence;

+ (instancetype)formWithTitle:(NSString *)title content:(NSString *)content placeHolder:(NSString *)placeHolder formType:(FormType)type isMustFill:(BOOL)needFill;

@end

@interface XMTextFiledForm : XMForm<XMFormDelegate>

@end

