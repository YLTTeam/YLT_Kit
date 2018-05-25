//
//  YLT_BaseWebVC.m
//  YLT_Kit
//
//  Created by 项普华 on 2018/5/22.
//

#import "YLT_BaseWebVC.h"

@interface YLT_BaseWebView ()

/**
 加载路径
 */
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, copy) void(^callback)(WKScriptMessage *message);

@end

@implementation YLT_BaseWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:self.configuration];
        [self addSubview:self.webView];
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

/**
 JS给OC发送数据 （JS调用OC的方法）
 
 @param names 方法名
 @param callback 监听到js调用的回调
 */
- (void)addObserverNames:(NSArray<NSString *> *)names callback:(void(^)(WKScriptMessage *message))callback {
    for (NSString *name in names) {
        if (name.ylt_isValid) {
            [self.configuration.userContentController removeScriptMessageHandlerForName:name];
            [self.configuration.userContentController addScriptMessageHandler:self name:name];
        }
    }
    self.callback = callback;
}

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param string 数据
 @param jsMedhodName 方法名
 */
- (void)sendString:(NSString *)string toMethodName:(NSString *)jsMedhodName {
    NSString *sender = [NSString stringWithFormat:@"%@('%@')", jsMedhodName, string];
    [self.webView evaluateJavaScript:sender completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error) {
            YLT_LogError(@"%@", error);
        } else {
            YLT_Log(@"%@", result);
        }
    }];
}

/**
 根据地址生成网页视图
 
 @param frame frame
 @param urlString 网页地址
 @return 网页视图
 */
+ (YLT_BaseWebView *)webViewFrame:(CGRect)frame URLString:(NSString *)urlString {
    YLT_BaseWebView *webView = [[[self class] alloc] initWithFrame:frame];
    webView.url = [NSURL URLWithString:urlString];
    
    return webView;
}

/**
 根据地址生成网页视图
 
 @param frame frame
 @param filePath 本地路径
 @return 网页视图
 */
+ (YLT_BaseWebView *)webViewFrame:(CGRect)frame filePath:(NSString *)filePath {
    YLT_BaseWebView *webView = [[[self class] alloc] initWithFrame:frame];
    webView.url = [NSURL fileURLWithPath:filePath];
    return webView;
}


#pragma mark - WKScriptMessageHandler
/**
 收到 JavaScript 方法调用
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.callback) {
        self.callback(message);
    }
}

#pragma mark - WKNavigationDelegate
// 请求开始前，会先调用此代理方法
// 类型，在请求先判断能不能跳转（请求）
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && ![hostname containsString:@".baidu.com"]) {
//        // 对于跨域，需要手动跳转
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        // 不允许web内跳转
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    decisionHandler(WKNavigationActionPolicyAllow);
    YLT_LogInfo(@"%@", hostname);
}

// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSString *hostname = navigationResponse.response.URL.host.lowercaseString;
    decisionHandler(WKNavigationResponsePolicyAllow);
    YLT_LogInfo(@"%@", hostname);
}

// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
}

// 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    YLT_LogInfo(@"%@", webView);
}

// 页面内容到达main frame时回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
}

// 导航完成时，会回调（也就是页面载入完成了）
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    YLT_LogInfo(@"%@", webView);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if ([result isKindOfClass:[NSString class]] && ((NSString *) result).ylt_isValid && self.ylt_currentVC) {
            self.ylt_currentVC.title = result;
        }
    }];
    YLT_LogInfo(@"%@", webView);
}

// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    YLT_LogInfo(@"%@", webView);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

// 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    YLT_LogInfo(@"%@", webView);
}

#pragma mark - WKUIDelegate


#pragma mark - getter

- (void)setUrl:(NSURL *)url {
    _url = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (WKWebViewConfiguration *)configuration {
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        _configuration.userContentController = [[WKUserContentController alloc] init];
        WKPreferences *preferences = [WKPreferences new];
        //在iOS上默认为NO，表示不能自动通过窗口打开
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 10.0;
        preferences.javaScriptEnabled = YES;
        _configuration.preferences = preferences;
        // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
        _configuration.processPool = [[WKProcessPool alloc] init];
    }
    return _configuration;
}

@end


@interface YLT_BaseWebVC ()

/**
 url
 */
@property (nonatomic, strong) NSURL *url;

@end

@implementation YLT_BaseWebVC

- (instancetype)init {
    self = [super init];
    if (self) {
        _webView = [[YLT_BaseWebView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 根据地址生成网页视图
 
 @param urlString 路径
 @return 控制器
 */
+ (YLT_BaseWebVC *)webVCFromURLString:(NSString *)urlString {
    YLT_BaseWebVC *vc = [[[self class] alloc] init];
    vc.url = [NSURL URLWithString:urlString];
    return vc;
}

/**
 根据地址生成网页视图
 
 @param filePath 路径
 @return 控制器
 */
+ (YLT_BaseWebVC *)webVCFromFilePath:(NSString *)filePath {
    YLT_BaseWebVC *vc = [[[self class] alloc] init];
    vc.url = [NSURL fileURLWithPath:filePath];
    return vc;
}

/**
 JS给OC发送数据 （JS调用OC的方法）
 
 @param names 方法名
 @param callback 监听到js调用的回调
 */
- (void)addObserverNames:(NSArray<NSString *> *)names callback:(void(^)(WKScriptMessage *message))callback {
    [self.webView addObserverNames:names callback:callback];
}

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param string 数据
 @param jsMedhodName 方法名
 */
- (void)sendString:(NSString *)string toMethodName:(NSString *)jsMedhodName {
    [self.webView sendString:string toMethodName:jsMedhodName];
}

- (void)dealloc {
    [self.webView.configuration.userContentController removeAllUserScripts];
}

#pragma mark - getter

- (void)setUrl:(NSURL *)url {
    _url = url;
    self.webView.url = url;
}

@end
