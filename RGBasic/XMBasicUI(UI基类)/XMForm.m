//
//  XMForm.m
//  RGBasic
//
//  Created by robin on 2017/11/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMForm.h"

@implementation XMFormAppearence

@end

@implementation XMForm

+ (instancetype)formWithTitle:(NSString *)title content:(NSString *)content placeHolder:(NSString *)placeHolder formType:(FormType)type isMustFill:(BOOL)needFill{
    
    XMForm *form = [[self class] new];
    form.title = title;
    form.content = content;
    form.placeHolder = placeHolder;
    form.formType = type;
    form.isMustFill = needFill;
    return form;
}
@end


@implementation XMTextFiledForm
@synthesize keyboardType;
@end
