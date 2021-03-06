//
//  XMNetworkMananger.h
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMNetworkConfigure.h"
#import "XMNetworkContext.h"
@class XMNetworkMananger;
@class AFHTTPSessionManager;


typedef NS_ENUM(NSUInteger, SessionConfigurationType) {
    
    DefaultsConfiguration,
};

@protocol XMNetworkManangerDelegate <NSObject>

@optional

- (NSURLSessionConfiguration *)configuration:(SessionConfigurationType)type;//未完待续

/**
 可自定义相关配置
 */
- (NSURLSessionConfiguration *)defaultConfiguration;
- (AFHTTPSessionManager *)defaultSessionManager;

- (NSDictionary *)handleParameters:(NSDictionary *)parameters error:(NSError **)error;
- (XMNetworkContext *)handleSuccessResponse:(id)response error:(NSError **)error;

/**
 自定义处理错误信息 在错误回调返回之前执行
 @param error 错误
 */
- (void)handleRequestFailure:(NSError *)error;
@end



@interface XMNetworkMananger : NSObject<XMNetworkManangerDelegate>

+ (instancetype)manager;

- (NSURLSessionDataTask *)XM_Get:(NSDictionary *)paramDic
                             URL:(NSString *)URL
                         success:(void (^)(XMNetworkContext *context, NSURLSessionDataTask * task)) success
                         failure:(void (^)(NSError * error,NSURLSessionDataTask * task)) failure;


- (NSURLSessionDataTask *)XM_Post:(NSDictionary *)paramDic
                              URL:(NSString *)URL
                          success:(void (^)(XMNetworkContext *context, NSURLSessionDataTask * task)) success
                          failure:(void (^)(NSError * error,NSURLSessionDataTask * task)) failure;


- (NSURLSessionDataTask *)XM_Upload:(NSDictionary *)paramDic
                                URL:(NSString *)URL
                         uploadData:(NSData *)uploadData
                           progress:(void (^)(NSProgress *progress))progress
                            success:(void (^)(XMNetworkContext *context, NSURLSessionDataTask *task))success
                            failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure;


- (NSURLSessionDownloadTask *)XM_Download:(NSDictionary *)paramDic
                                 filePath:(NSString *)filePath
                                      URL:(NSString *)URL
                                 progress:(void (^)(NSProgress *progress))progress
                                  success:(void (^)(NSURL *filePath, NSURLSessionDownloadTask *task))success
                                  failure:(void (^)(NSError *error, NSURLSessionDownloadTask *task))failure;

@end
