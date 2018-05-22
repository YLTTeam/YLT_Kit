//
//  YLT_BaseWebVC.h
//  YLT_Kit
//
//  Created by 项普华 on 2018/5/22.
//

#import <YLT_Kit/YLT_Kit.h>
#import <WebKit/WebKit.h>

@protocol YLT_WebProtocl

@optional
/**
 JS给OC发送数据 （JS调用OC的方法）
 
 @param names 方法名
 @param callback 监听到js调用的回调
 */
- (void)addObserverNames:(NSArray<NSString *> *)names callback:(void(^)(WKScriptMessage *message))callback;

/**
 OC给JS发送数据 （OC调用JS的方法）
 
 @param string 数据
 @param jsMedhodName 方法名
 */
- (void)sendString:(NSString *)string toMethodName:(NSString *)jsMedhodName;

@end


@interface YLT_BaseWebView : YLT_BaseView<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate, YLT_WebProtocl>

/**
 网页视图
 */
@property (nonatomic, strong, readonly) WKWebView *webView;

/**
 网络视图参数配置
 */
@property (nonatomic, strong) WKWebViewConfiguration *configuration;

/**
 根据地址生成网页视图
 
 @param frame frame
 @param urlString 网页地址
 @return 网页视图
 */
+ (YLT_BaseWebView *)webViewFrame:(CGRect)frame URLString:(NSString *)urlString;

/**
 根据地址生成网页视图
 
 @param frame frame
 @param filePath 本地路径
 @return 网页视图
 */
+ (YLT_BaseWebView *)webViewFrame:(CGRect)frame filePath:(NSString *)filePath;

@end

@interface YLT_BaseWebVC : YLT_BaseVC<YLT_WebProtocl>

/**
 网页视图
 */
@property (nonatomic, strong, readonly) YLT_BaseWebView *webView;

/**
 根据地址生成网页视图

 @param urlString 路径
 @return 控制器
 */
+ (YLT_BaseWebVC *)webVCFromURLString:(NSString *)urlString;

/**
 根据地址生成网页视图
 
 @param filePath 路径
 @return 控制器
 */
+ (YLT_BaseWebVC *)webVCFromFilePath:(NSString *)filePath;

@end
