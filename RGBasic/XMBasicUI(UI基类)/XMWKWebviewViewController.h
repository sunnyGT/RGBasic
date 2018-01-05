//
//  XMWKWebviewViewController.h
//  RGBasic
//
//  Created by robin on 2017/6/3.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMViewController.h"
#import <WebKit/WebKit.h>
@interface XMWKWebviewViewController : XMViewController

@property (nonatomic ,strong)WKWebView *XMWebView;
@property (nonatomic ,strong)UIProgressView *progressView;
@property (nonatomic ,assign)CGFloat progressHeight;

@end
