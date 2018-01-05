//
//  NSUserDefaults+XMSaveTool.h
//  XMBasicProject
//
//  Created by robin on 2017/4/14.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (XMSaveTool)

//储存类型 包括NSData NSString NSNumber NSDate NSArray NSDictionary


//归结档 存储除上述以外的数据类型

+ (id)xm_arcObjectForKey:(NSString *)defaultName;

+ (void)xm_setArcObject:(id)value forKey:(NSString *)defaultName;
@end
