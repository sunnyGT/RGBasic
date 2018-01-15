//
//  NSString+XMStringTool.m
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "NSString+XMStringTool.h"
#import<CommonCrypto/CommonDigest.h>
#import "RSAEncryptor.h"
#import "Encryption.h"
#import "MF_Base64Additions.h"
@implementation NSString (XMStringTool)


+ (NSString *)XM_CreatePathWith:(NSSearchPathDirectory)directory fileName:(NSString *)fileName name:(NSString *)name{
    
    NSString *XMPath = [[NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XM"];
    NSString *customPath = [XMPath stringByAppendingPathComponent:fileName];
    NSFileManager *tempManager = [NSFileManager defaultManager];
    if (![tempManager fileExistsAtPath:customPath]) {
        [tempManager createDirectoryAtPath:customPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [customPath stringByAppendingPathComponent:name];
}

- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (BOOL) isCardNumber{
    NSString *regex = @"^[1-9]{1}[0-9]{13,19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

- (BOOL) isNumber{
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

- (BOOL) isSingleNumber{
    NSString *regex = @"^[0-9]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL) isFloatNumber{
    NSString *regex = @"^([1-9]\\d*\\.\\d*|0\\.\\d+|[1-9]\\d*|0)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL) isPhoneNumber {
    NSString *regex = @"^[1-9]{1}[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (FacilitatorType)getPhoneFacilitator{
    NSDictionary *regexDic = @{
                               @(Facilitator_DX):@"^18[09]\\d{8}$",
                               @(Facilitator_YD):@"^1(3[4-9]|5[012789]|8[78])\\d{8}$",
                               @(Facilitator_LT):@"^1(3[0-2]|5[56]|8[56])\\d{8}$"
                               };
    __block FacilitatorType type;
    [regexDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *regex = obj;
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:self];
        if (isMatch) {
            type = [key integerValue];
            *stop = YES;
        }
    }];
    return type;
}

- (BOOL)isEmpty{
    return [self isEqualToString:@""];
}

- (UIColor *)hexColor{
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1];
}

- (NSString *)MD5_16bit{
    //16位
    const char *charStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(charStr, (CC_LONG)strlen(charStr), result);
    NSMutableString *MD5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSUInteger idx = 0 ; idx < CC_MD5_DIGEST_LENGTH; idx ++) {
        [MD5Str appendFormat:@"%X",result[idx]];
    }
    return MD5Str;
}

- (NSString *)MD5_32bit{
    //32位
    const char *charStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(charStr, (CC_LONG)strlen(charStr), result);
    NSMutableString *MD5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (NSUInteger idx = 0 ; idx < CC_MD5_DIGEST_LENGTH; idx ++) {
        [MD5Str appendFormat:@"%02X",result[idx]];
    }
    return MD5Str;
}

- (NSString *)RSA_Decode:(NSString *)privateKey{
    
    NSData *tempPrivateKey = [MF_Base64Codec dataFromBase64String:privateKey];
    [[RSAEncryptor sharedInstance] loadPublicKeyFromData:tempPrivateKey];
    return [[RSAEncryptor sharedInstance] rsaDecryptString:self];
}

- (NSString *)RSA_Encode:(NSString *)publicKey{
    
    NSData *tempPublicKey = [MF_Base64Codec dataFromBase64String:publicKey];
    [[RSAEncryptor sharedInstance] loadPublicKeyFromData:tempPublicKey];
    return [[RSAEncryptor sharedInstance] rsaEncryptString:self];
}

- (NSString *)AES_Decode:key{
    
    return [Encryption AES128Decrypt:self key:key];
}
- (NSString *)AES_Encode:(NSString *)key{
    
    return [Encryption AES128Encrypt:self key:key];
}

+ (NSString *)decodeQRCIImage:(CIImage *)image{
    if (!image) {
        return nil;
    }
    CIDetector *detetor = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                             context:[CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}]
                                             options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    NSArray<CIFeature *> *features = [detetor featuresInImage:image];
    
    if (features.count == 0 || !features) {
        return nil;
    }
    for (CIFeature *feature in features) {
        if (![feature isKindOfClass:[CIQRCodeFeature class]]){
            continue;
        }
        return ((CIQRCodeFeature *)feature).messageString;
    }
    return nil;
}


+ (NSString *)decodeQRImage:(UIImage *)image{
    if (!image) {
        return nil;
    }
    if (image.CIImage) {
        return [[self class] decodeQRCIImage:image.CIImage];
    }
    return [[self class] decodeQRCIImage:[CIImage imageWithCGImage:image.CGImage]];
    
}

+ (NSString *)decodeQRImagefileURL:(NSURL *)fileURL{
    
    if (!fileURL) {
        return nil;
    }
    CIImage *image = [CIImage imageWithContentsOfURL:fileURL];
    return [[self class] decodeQRCIImage:image];
}
@end
