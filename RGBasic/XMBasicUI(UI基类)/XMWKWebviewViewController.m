//
//  XMWKWebviewViewController.m
//  RGBasic
//
//  Created by robin on 2017/6/3.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMWKWebviewViewController.h"
#import "Masonry.h"
#import "XMMacro.h"
@interface XMWKWebviewViewController ()

@end

@implementation XMWKWebviewViewController


- (void)loadView{
    [super loadView];
    [self.view addSubview:self.XMWebView];
    [self.view addSubview:self.progressView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.XMWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.progressView.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(0);
        
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(NavigationBarBottomY+(kDevice_Is_iPhoneX?24:0));
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(self.progressHeight);
    }];
}

- (UIView *)navCustomBackView{
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    back.titleLabel.font = XMFontOfSize(16.f);
    [back setImage:[UIImage imageNamed:@"Nav_Back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(customLeftNavItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [back sizeToFit];
    return back;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBack = [self setNavigationBarLeftItemWithCustomView:[self navCustomBackView]];
    UIBarButtonItem *leftClose = [self setNavigationBarLeftItemWithTitle:@"关闭"];
    leftClose.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItems = @[leftBack,leftClose];
    self.progressHeight = self.progressHeight? :2.f;
    [self.XMWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    WKWebView *webView = (WKWebView *)object;
    [self.progressView setProgress:webView.estimatedProgress animated:YES];
    if (webView.estimatedProgress == 1) {
        [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

- (void)dealloc{
    
    [self.XMWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)customLeftNavItemAction:(UIBarButtonItem *)sender{
    if ([sender.title isEqualToString:@"返回"]) {
        if (_XMWebView.canGoBack) {
            [_XMWebView goBack];
        }else {
            
            [super customLeftNavItemAction:sender];
        }
    }else{
        
        [super customLeftNavItemAction:sender];
    }
}

#pragma mark lazyLoad

- (WKWebView *)XMWebView{
    if (!_XMWebView) {
        _XMWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _XMWebView.backgroundColor = [UIColor whiteColor];
        _XMWebView.scrollView.showsVerticalScrollIndicator = NO;
        _XMWebView.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _XMWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _progressView.progressTintColor = ThemeTintColor;
        _progressView.trackTintColor = ThemeColor;
        _progressView.progress = 0;
    }
    return _progressView;
}

- (void)setProgressHeight:(CGFloat)progressHeight{
    
    _progressHeight = progressHeight;
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
