//
//  XMNetworkMananger.m
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMNetworkMananger.h"
#import<CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"
#import "XMNetworkContext.h"
@interface XMNetworkMananger ()

@property (nonatomic ,strong)NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic ,strong)AFHTTPSessionManager *HTTPSessionManager;
@end

@implementation XMNetworkMananger

+ (instancetype)manager{
    
    return  [[[self class] alloc] init];
}

- (instancetype)init{
    
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithConfigure:(nonnull NSURLSessionConfiguration *)configuration{
    
    self = [super init];
    if (self) {
        
        _sessionConfiguration = configuration;
    }
    return self;
    
}

- (instancetype)initWithHttpManager:(AFHTTPSessionManager *)sessionManager{
    
    self = [super init];
    if (self) {
        
        _HTTPSessionManager = sessionManager;
    }
    return self;
    
}

- (void)configureManager{
    
    _sessionConfiguration = [self defaultConfiguration];
    _HTTPSessionManager = [self defaultSessionManager];
}

- (NSURLSessionConfiguration *)defaultConfiguration{
    
    return [NSURLSessionConfiguration defaultSessionConfiguration];
}

- (NSString *)basicURLString{
    
    return @"";
}

- (AFHTTPSessionManager *)defaultSessionManager{
    
    NSString *baseURL = [XMNetworkConfigure networkConfigure].baseURL;
    NSAssert(!([baseURL isEqualToString:@""] || baseURL == (id)kCFNull || !baseURL ), @"请在didFinishLaunchingWithOptions中发生网络请求之前完成 XMNetworkConfigure 初始化并完成网络相关配置");
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL] sessionConfiguration:self.sessionConfiguration];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    return sessionManager;
}


- (NSURLSessionDataTask *)XM_Get:(NSDictionary *)paramDic
                             URL:(NSString *)URL
                         success:(void (^)(XMNetworkContext *, NSURLSessionDataTask *))success
                         failure:(void (^)(NSError *, NSURLSessionDataTask *))failure{
    
    [self configureManager];
    NSDictionary *headledParam = paramDic;
    if ([self respondsToSelector:@selector(handleParameters: error:)]) {
        NSError *error = nil;
        headledParam = [self handleParameters:paramDic error:&error];
        if (error) {
            if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                [self handleRequestFailure:error];
            }
#ifdef DEBUG
            NSAssert(error, @"参数处理出错%@",URL);
#endif
            failure(error,nil);
        }
    }

    NSURLSessionDataTask *task =[self.HTTPSessionManager GET:URL
                                  parameters:headledParam
                                    progress:NULL
                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                         //返回数据处理
                                         XMNetworkContext *context = nil;
                                         if ([self respondsToSelector:@selector(handleSuccessResponse: error:)]) {
                                             NSError *error = nil;
                                             context = [self handleSuccessResponse:responseObject error:&error];
#ifdef DEBUG
                                             NSLog(@"-----\n URL:%@ \n Param:%@ \n response:%@ \n  error:%@",URL,headledParam,responseObject,error.description);
#endif
                                             if (error) {
                                                 if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                                                     [self handleRequestFailure:error];
                                                 }
                                                 failure(error,task);
                                                 return;
                                             }
                                         }
                                         if (success) success(context,task);
                                         
                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                         if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                                             [self handleRequestFailure:error];
                                         }
                                         failure(error,task);
                                     }];
    [task resume];
    return task;
    
}


- (NSURLSessionDataTask *)XM_Post:(NSDictionary *)paramDic
                              URL:(NSString *)URL
                          success:(void (^)(XMNetworkContext *, NSURLSessionDataTask *))success
                          failure:(void (^)(NSError *, NSURLSessionDataTask *))failure{
    
     [self configureManager];
    //参数处理
    //加密处理
    //请求处理
    NSDictionary *headledParam = paramDic;
    if ([self respondsToSelector:@selector(handleParameters: error:)]) {
        NSError *error = nil;
        headledParam = [self handleParameters:paramDic error:&error];
        if (error) {
            if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                [self handleRequestFailure:error];
            }
            failure(error,nil);
            
#ifdef DEBUG
            NSAssert(error, @"参数处理出错%@",URL);
#endif
            return nil;
        }
    }


    NSURLSessionDataTask *task =[self.HTTPSessionManager POST:URL
                                   parameters:headledParam
                                     progress:NULL
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          //返回数据处理
                                          XMNetworkContext *context = nil;
                                          if ([self respondsToSelector:@selector(handleSuccessResponse: error:)]) {
                                              NSError *error = nil;
                                              context = [self handleSuccessResponse:responseObject error:&error];
                                              
#ifdef DEBUG
                                              NSLog(@"-----\n URL:%@ \n Param:%@ \n response:%@ \n  error:%@",URL,headledParam,responseObject,error.description);
#endif
                                              if (error) {
                                                  if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                                                      [self handleRequestFailure:error];
                                                  }
                                                  failure(error,task);
                                                  return;
                                              }
                                          }
                                          if (success) success(context,task);
                                      }
                                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                                              [self handleRequestFailure:error];
                                          }
                                          failure(error,task);
                                      }];
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)XM_Upload:(NSDictionary *)paramDic
                                URL:(NSString *)URL
                         uploadData:(NSData *)uploadData
                           progress:(void (^)(NSProgress *))progress
                            success:(void (^)(XMNetworkContext *, NSURLSessionDataTask *))success
                            failure:(void (^)(NSError *, NSURLSessionDataTask *))failure{
    
    [self configureManager];
    NSDictionary *headledParam = paramDic;
    if ([self respondsToSelector:@selector(handleParameters: error:)]) {
        NSError *error = nil;
        headledParam = [self handleParameters:paramDic error:&error];
        if (error) {
            
            if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                [self handleRequestFailure:error];
            }
            failure(error,nil);
            
#ifdef DEBUG
            NSAssert(error, @"参数处理出错%@",URL);
#endif
            return nil;
        }
    }

    NSURLSessionDataTask *uploadTask = [_HTTPSessionManager POST:URL parameters:headledParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:uploadData name:headledParam[@"fileName"] fileName:[NSString stringWithFormat:@"XM_%lf.png",[NSDate date].timeIntervalSince1970] mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress){
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(uploadProgress);
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回数据处理
        XMNetworkContext *context = nil;
        if ([self respondsToSelector:@selector(handleSuccessResponse: error:)]) {
            NSError *error = nil;
            
            context = [self handleSuccessResponse:responseObject error:&error];
#ifdef DEBUG
            NSLog(@"-----\n URL:%@ \n Param:%@ \n response:%@ \n  error:%@",URL,headledParam,responseObject,error.description);
#endif
            if (error) {
                if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                    [self handleRequestFailure:error];
                }
                failure(error,task);
                return;
            }
        }
        if (success) success(context,task);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
            [self handleRequestFailure:error];
        }
        failure(error,task);
    }];
    
    return uploadTask;
}

// downLoad File
- (NSURLSessionDownloadTask *)XM_Download:(NSDictionary *)paramDic
                                 filePath:(NSString *)filePath
                                      URL:(NSString *)URL
                                 progress:(void (^)(NSProgress *progress))progress
                                  success:(void (^)(NSURL *filePath, NSURLSessionDownloadTask *task))success
                                  failure:(void (^)(NSError *error, NSURLSessionDownloadTask *task))failure{
    [self configureManager];
    NSDictionary *headledParam = paramDic;
    if ([self respondsToSelector:@selector(handleParameters: error:)]) {
        NSError *error = nil;
        headledParam = [self handleParameters:paramDic error:&error];
        if (error) {
            if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                [self handleRequestFailure:error];
            }
            failure(error,nil);
            
#ifdef DEBUG
            NSAssert(error, @"参数处理出错%@",URL);
#endif
            return nil;
        }
    }
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    
    __block NSURLSessionDownloadTask *downloadTask = [_HTTPSessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *XMPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XM"];
        NSString *customPath = [XMPath stringByAppendingPathComponent:@"XM_DownLoad"];
        NSFileManager *tempManager = [NSFileManager defaultManager];
        if (![tempManager fileExistsAtPath:customPath]) {
            [tempManager createDirectoryAtPath:customPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *downLoadPath = [customPath stringByAppendingPathComponent:response.suggestedFilename];
        return filePath?[NSURL fileURLWithPath:filePath] : [NSURL fileURLWithPath:downLoadPath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
#ifdef DEBUG
        NSLog(@"-----\n URL:%@ \n Param:%@ \n response:%@ \n  error:%@",URL,headledParam,response,error.description);
#endif
        //对response操作
        if (error) {
            if ([self respondsToSelector:@selector(handleRequestFailure:)]) {
                [self handleRequestFailure:error];
            }
            failure(error,downloadTask);
        }else{
            
            success(filePath,downloadTask);
        }
    }];
    
    [downloadTask resume];
    return downloadTask;
}

- (NSDictionary *)handleParameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error{
    
    if (!parameters) parameters = @{};
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSDate *date = [NSDate date];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", [date timeIntervalSince1970]];// 转为字符型
    [params setObject:timeString forKey:@"time"];
    [params setObject:@"2" forKey:@"terminal"];
    [params setObject:[XMNetworkConfigure networkConfigure].apiid forKey:@"apiId"];
    NSString *hash = [self createHashWithParamKeys:params.allKeys];
    [params setObject:hash forKey:@"hash"];
    
// hash apiId terminal time
    return params;
}

- (NSString *)createHashWithParamKeys:(NSArray *)keys{

    NSArray *sortArr = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *tempHash = [sortArr componentsJoinedByString:@""];
    NSString *hash = [self MD5:[tempHash stringByAppendingString:[XMNetworkConfigure networkConfigure].apiKey]];
    return hash;
}

- (XMNetworkContext *)handleSuccessResponse:(id)response error:(NSError *__autoreleasing *)error{
    
    XMNetworkContext *context = nil;
    context = [XMNetworkContext contenxtWithDic:response error:error];
    if (error) {
        *error  = [NSError errorWithDomain:@"返回数据格式错误" code:1050000 userInfo:@{@"response":response}];
        return context;
    }
    if ([context.Code isEqualToString:@"000000"]) {
        
        return context;
        
    }else{
        
        *error = [NSError errorWithDomain:context.Msg code:[context.Code integerValue] userInfo:response];
    }
    return context;
}

- (NSString *)MD5:(NSString *)str{
    //32位
    const char *charStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(charStr, (CC_LONG)strlen(charStr), result);
    NSMutableString *MD5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (NSUInteger idx = 0 ; idx < CC_MD5_DIGEST_LENGTH; idx ++) {
        [MD5Str appendFormat:@"%02x",result[idx]];
    }
    return MD5Str;
}

@end
