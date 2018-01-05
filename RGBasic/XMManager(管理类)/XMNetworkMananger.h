//
//  XMNetworkMananger.h
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class XMNetworkMananger;


typedef NS_ENUM(NSUInteger, SessionConfigurationType) {
    DefaultsConfiguration,
};

@protocol XMNetworkManangerDelegate <NSObject>



@optional

- (NSURLSessionConfiguration *)configuration:(SessionConfigurationType)type;//未完待续
- (NSURLSessionConfiguration *)defaultConfiguration;
- (AFHTTPSessionManager *)defaultSessionManager;
- (NSDictionary *)handleParameters:(NSDictionary *)parameters error:(NSError **)error;
- (NSDictionary *)handleSuccessResponse:(id)response error:(NSError **)error;
- (void)handleRequestFailure:(NSError *)error;
@end

@interface XMNetworkMananger : NSObject<XMNetworkManangerDelegate>

+ (instancetype)manager;

- (NSURLSessionDataTask *)XM_Get:(NSDictionary *)paramDic
                             URL:(NSString *)URL
                         success:(void (^)(id responseObject, NSURLSessionDataTask * task)) success
                         failure:(void (^)(NSError * error,NSURLSessionDataTask * task)) failure;


- (NSURLSessionDataTask *)XM_Post:(NSDictionary *)paramDic
                              URL:(NSString *)URL
                          success:(void (^)(id responseObject, NSURLSessionDataTask * task)) success
                          failure:(void (^)(NSError * error,NSURLSessionDataTask * task)) failure;


- (NSURLSessionDataTask *)XM_Upload:(NSDictionary *)paramDic
                                URL:(NSString *)URL
                         uploadData:(NSData *)uploadData
                           progress:(void (^)(NSProgress *progress))progress
                            success:(void (^)(id responseObject, NSURLSessionDataTask *task))success
                            failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure;


- (NSURLSessionDownloadTask *)XM_Download:(NSDictionary *)paramDic
                                 filePath:(NSString *)filePath
                                      URL:(NSString *)URL
                                 progress:(void (^)(NSProgress *progress))progress
                                  success:(void (^)(NSURL *filePath, NSURLSessionDownloadTask *task))success
                                  failure:(void (^)(NSError *error, NSURLSessionDownloadTask *task))failure;

@end
