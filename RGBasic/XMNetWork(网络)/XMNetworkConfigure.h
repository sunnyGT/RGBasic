//
//  XMNetworkConfigure.h
//  RGBasic
//
//  Created by robin on 2018/1/8.
//  Copyright © 2018年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMNetworkConfigure : NSObject

#pragma mark -
@property (nonatomic ,copy)NSString *apiid;
@property (nonatomic ,copy)NSString *apiKey;
@property (nonatomic ,copy ,readonly)NSString *baseURL;


+ (instancetype)networkConfigure;
/**
 项目的网络相关配置
 
 @param apiid 各个项目的apiid
 @param apiKey 各个项目的apiKey
 @param baseURL 各个项目的基础地址
 */
- (void)configureNetworkConnectionWithApiid:(NSString *)apiid apiKey:(NSString *)apiKey baseURL:(NSString *)baseURL;
@end
