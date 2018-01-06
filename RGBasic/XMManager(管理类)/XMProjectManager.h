//
//  XMProjectManager.h
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMAppDelegate;
@interface XMProjectManager : NSObject

@property (nonatomic ,weak)XMAppDelegate* appDelegate;

@property (nonatomic ,copy)NSString *apiid;
@property (nonatomic ,copy)NSString *apiKey;
@property (nonatomic ,copy ,readonly)NSString *baseURL;

+ (XMProjectManager *)manager;

/**
  项目的网络相关配置

 @param apiid 各个项目的apiid
 @param apiKey 各个项目的apiKey
 @param baseURL 各个项目的基础地址
 */
- (void)configureNetworkConnectionWithApiid:(NSString *)apiid apiKey:(NSString *)apiKey baseURL:(NSString *)baseURL;


/**
 
 @return 当前显示的视图
 */
- (UIViewController *)topViewController;



@end
