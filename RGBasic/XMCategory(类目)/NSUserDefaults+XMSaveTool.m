//
//  NSUserDefaults+XMSaveTool.m
//  XMBasicProject
//
//  Created by robin on 2017/4/14.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "NSUserDefaults+XMSaveTool.h"

@implementation NSUserDefaults (XMSaveTool)


+ (id)xm_arcObjectForKey:(NSString *)defaultName{
    NSData *tempData = [[NSUserDefaults standardUserDefaults] dataForKey:defaultName];
    if (isNUllOrNil(tempData)) return nil;
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempData];
}

+ (void)xm_setArcObject:(id)value forKey:(NSString *)defaultName{

    return [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:defaultName];
}



@end
