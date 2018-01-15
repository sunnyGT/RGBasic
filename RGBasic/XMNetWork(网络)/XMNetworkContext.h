//
//  XMNetworkContext.h
//  RGBasic
//
//  Created by robin on 2018/1/11.
//  Copyright © 2018年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMNetworkContext : NSObject

@property (nonatomic ,copy)id Data;
@property (nonatomic ,copy)NSString *Code;
@property (nonatomic ,copy)NSString *Msg;
@property (nonatomic ,copy)NSString *Time;
@property (nonatomic ,copy)NSString *ApiUrl;

+ (XMNetworkContext *)contenxtWithDic:(NSDictionary *)dic error:(NSError  **)error;
@end
