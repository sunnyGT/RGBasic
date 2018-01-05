//
//  UITextField+WordLimit.m
//  AoChuangEconomics
//
//  Created by robin on 2017/4/12.
//  Copyright © 2017年 KuBaoInternet. All rights reserved.
//

#import "UITextField+WordLimit.h"
#import <objc/runtime.h>


@implementation UITextField (WordLimit)

@dynamic maxLength;
@dynamic minLength;

- (void)setMaxLength:(NSInteger)maxLength{

    [self willChangeValueForKey:@"maxLength"];
    NSValue *value = [NSValue value:&maxLength withObjCType:@encode(NSInteger)];
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"maxLength"];
}

- (NSInteger)maxLength{
    
    NSInteger max = 0;
    NSValue* value = objc_getAssociatedObject(self, @selector(setMaxLength:));
    [value getValue:&max];
    return max;
}

- (void)setMinLength:(NSInteger)minLength{
    
    [self willChangeValueForKey:@"minLength"];
    NSValue *value = [NSValue value:&minLength withObjCType:@encode(NSInteger)];
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"minLength"];
    
}

- (NSInteger)minLength{
    
    NSInteger min = 0;
    NSValue *value = objc_getAssociatedObject(self, @selector(setMinLength:));
    [value getValue:&min];
    return min;
}

- (void)configureMaxLength:(NSInteger)maxLength minLength:(NSInteger)minLength{
    
    self.minLength = minLength;
    self.maxLength = maxLength;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:@"UITextFieldTextDidChangeNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEndEdit:) name:@"UITextFieldTextDidEndEditingNotification" object:nil];
}

- (void)textFieldEditChanged:(NSNotification *)sender{
    
    UITextField *tempTextField = sender.object;
    if (![tempTextField isEqual:self]) {
        return;
    }
    [self validationText:tempTextField];
    
}

- (void)textFieldEndEdit:(NSNotification *)sender{
    UITextField *tempTextField = sender.object;
    if (![tempTextField isEqual:self] || !self.minLength) {
        
        return;
    }
    
    if (tempTextField.text.length < self.minLength) {
        
        [XMHUD showHUDToViewTop:[UIApplication sharedApplication].keyWindow onlyText:@"输入位数不足!"];
    }

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSString *)validationText:(UITextField *)textField{
    
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    
    //判断输入法
    if ([lang isEqualToString:@"zh-Hans"]) {
        //中文
        UITextRange *selectedRange = [textField markedTextRange];
        
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        if (!position) {
            if (toBeString.length >= self.maxLength) {
                NSString *strNew = [NSString stringWithString:toBeString];
                [textField setText:[strNew substringToIndex:self.maxLength]];
            }else{
                
                [textField setText:toBeString];
            }
        }
        else{
            
        }
    }else{
        
        //非中文
        if (toBeString.length > self.maxLength) {
            textField.text = [toBeString substringToIndex:self.maxLength];
        }else{
            
            textField.text = toBeString;
        }
    }
    
    return textField.text;
    
}





@end
