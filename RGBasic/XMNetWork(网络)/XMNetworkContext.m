//
//  XMNetworkContext.m
//  RGBasic
//
//  Created by robin on 2018/1/11.
//  Copyright © 2018年 robin. All rights reserved.
//

#import "XMNetworkContext.h"
#import <objc/runtime.h>

@implementation XMNetworkContext

+ (XMNetworkContext *)contenxtWithDic:(NSDictionary *)dic error:(NSError *__autoreleasing *)error{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        *error = [NSError errorWithDomain:@"数据格式错误" code:1050001 userInfo:@{@"response":dic}];
        return nil;
    }
    XMNetworkContext *context = [XMNetworkContext new];
    unsigned count = 0;
    objc_property_t *propertyList = class_copyPropertyList(self, &count);
    for (unsigned idx = 0; idx < count; idx ++ ) {
        
        objc_property_t property = propertyList[idx];
        NSString *key = @(property_getName(property));
        id value = [dic objectForKey:key];
        if (value == nil || value == (id)kCFNull) {
            *error = [NSError errorWithDomain:@"返回基础参数不完整" code:1050001 userInfo:@{@"key":key ,@"response":dic}];
            break;
        }else{
            [context setValue:value forKey:key];
        }
    }
    return context;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"Undefined key: %@",key);
}
@end
