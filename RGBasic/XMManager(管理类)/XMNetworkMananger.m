//
//  XMNetworkMananger.m
//  XMBasicProject
//
//  Created by robin on 2017/4/15.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMNetworkMananger.h"
#import "NSString+XMStringTool.h"

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

- (AFHTTPSessionManager *)defaultSessionManager{
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:XM_BASIC_URL] sessionConfiguration:self.sessionConfiguration];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    return sessionManager;
}


- (NSURLSessionDataTask *)XM_Get:(NSDictionary *)paramDic
                             URL:(NSString *)URL
                         success:(void (^)(id, NSURLSessionDataTask *))success
                         failure:(void (^)(NSError *, NSURLSessionDataTask *))failure{
    
    [self configureManager];
    NSDictionary *headledParam = paramDic;
    if ([self respondsToSelector:@selector(handleParameters: error:)]) {
        NSError *error = nil;
        headledParam = [self handleParameters:paramDic error:&error];
        if (error) {
            failure(error,nil);
            NSAssert(error, @"参数处理出错%@",URL);
        }
    }

    NSURLSessionDataTask *task =[self.HTTPSessionManager GET:URL
                                  parameters:headledParam
                                    progress:NULL
                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                         //返回数据处理
                                         id handelDic = responseObject;
                                         if ([self respondsToSelector:@selector(handleSuccessResponse: error:)]) {
                                             NSError *error = nil;
                                             handelDic = [self handleSuccessResponse:responseObject error:&error];
                                             if (error) {
#ifdef DEBUG
                                                 NSLog(@"+++URL:%@ \n ++Param:%@ \n +response:%@",URL,handelDic,responseObject);
#endif
                                                 failure(error,task);
                                                 return;
                                             }
                                         }
                                         success(handelDic,task);
                                         
                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                         
                                         failure(error,task);
                                     }];
    [task resume];
    return task;
    
}


- (NSURLSessionDataTask *)XM_Post:(NSDictionary *)paramDic
                              URL:(NSString *)URL
                          success:(void (^)(id, NSURLSessionDataTask *))success
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
                                          id handelDic = responseObject;
                                          if ([self respondsToSelector:@selector(handleSuccessResponse: error:)]) {
                                              NSError *error = nil;
                                              handelDic = [self handleSuccessResponse:responseObject error:&error];
                                              if (error) {
#ifdef DEBUG
                                                  NSLog(@"+++URL:%@ \n ++Param:%@ \n +response:%@",URL,headledParam,responseObject);
#endif
                                                  failure(error,task);
                                                  return;
                                              }
                                          }
                                          if (success) success(handelDic,task);
                                      }
                                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          
                                          failure(error,task);
                                      }];
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)XM_Upload:(NSDictionary *)paramDic
                                URL:(NSString *)URL
                         uploadData:(NSData *)uploadData
                           progress:(void (^)(NSProgress *progress))progress
                            success:(void (^)(id responseObject, NSURLSessionDataTask *task))success
                            failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure{
    [self configureManager];
    NSDictionary *headledParam = paramDic;
    if ([self respondsToSelector:@selector(handleParameters: error:)]) {
        NSError *error = nil;
        headledParam = [self handleParameters:paramDic error:&error];
        if (error) {
            failure(error,nil);
            
#ifdef DEBUG
            NSAssert(error, @"参数处理出错%@",URL);
#endif
            return nil;
        }
    }

    NSURLSessionDataTask *uploadTask = [_HTTPSessionManager POST:URL parameters:headledParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:uploadData name:@"uploadFile" fileName:[NSString stringWithFormat:@"XM_%lf.png",[NSDate date].timeIntervalSince1970] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress){
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(uploadProgress);
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回数据处理
        id handelDic = responseObject;
        if ([self respondsToSelector:@selector(handleSuccessResponse: error:)]) {
            NSError *error = nil;
            handelDic = [self handleSuccessResponse:responseObject error:&error];
            if (error) {
#ifdef DEBUG
                NSLog(@"+++URL:%@ \n ++Param:%@ \n +response:%@",URL,handelDic,responseObject);
#endif
                failure(error,task);
                return;
            }
        }
        success(handelDic,task);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

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
        
        
        return filePath?[NSURL fileURLWithPath:filePath] : [NSURL fileURLWithPath:[NSString XM_CreatePathWith:NSDocumentDirectory fileName:@"XM_DownLoad" name:response.suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //对response操作
        if (error) {
#ifdef DEBUG
            NSLog(@"+++URL:%@ \n ++Param:%@ \n +response:%@",URL,paramDic,response);
#endif
            failure(error,downloadTask);
        }else{
            success(filePath,downloadTask);
        }
    }];
    
    [downloadTask resume];
    return downloadTask;
}


@end
