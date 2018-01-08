//
//  XMNetworkConfigure.m
//  RGBasic
//
//  Created by robin on 2018/1/8.
//  Copyright © 2018年 robin. All rights reserved.
//

#import "XMNetworkConfigure.h"

@implementation XMNetworkConfigure

+ (instancetype)networkConfigure{
    static XMNetworkConfigure *configure = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configure = [[[self class] alloc] init];
    });
    return configure;
}

- (void)configureNetworkConnectionWithApiid:(NSString *)apiid apiKey:(NSString *)apiKey baseURL:(NSString *)baseURL{
    
    self.apiid = apiid;
    self.apiKey = apiKey;
    self -> _baseURL = baseURL;
}
@end
