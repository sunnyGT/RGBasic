//
//  NSString+XMStringTool.h
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Facilitator_DX,
    Facilitator_LT,
    Facilitator_YD,
} FacilitatorType;


@interface NSString (XMStringTool)

- (BOOL) isPhoneNumber;
- (BOOL) isFloatNumber;
- (BOOL) isSingleNumber;
- (BOOL) isNumber;
- (BOOL) isCardNumber;
- (BOOL) validateEmail;
- (FacilitatorType)getPhoneFacilitator;
/*
 @param:fileName 文件夹名称
 
 @param:name 文件名称
 */
+ (NSString *)XM_CreatePathWith:(NSSearchPathDirectory)directory fileName:(NSString *)fileName name:(NSString *)name;

//判空
- (BOOL)isEmpty;

//加密相关
- (NSString *)MD5;
- (NSString *)RSA_Encode;
- (NSString *)RSA_Decode;

- (NSString *)AES_Encode;
- (NSString *)AES_Decode;

- (UIColor *)hexColor;

// 二维码解析
+ (NSString *)decodeQRCIImage:(CIImage *)image;
+ (NSString *)decodeQRImage:(UIImage *)image;
+ (NSString *)decodeQRImagefileURL:(NSURL *)fileURL;
@end
