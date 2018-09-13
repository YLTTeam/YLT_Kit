//
//  YLT_RouterManager.m
//  FastCoding
//
//  Created by Sean on 2018/4/28.
//

#import "YLT_RouterManager.h"
#import "YLT_BaseMacro.h"
#import "NSString+YLT_Extension.h"

@interface YLT_RouterManager() {
}
@end

@implementation YLT_RouterManager

/**
 路由
 
 @param routerURL 路由的URL 参数带到URL后面
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToURL:(NSString *)routerURL arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    return [self ylt_routerToURL:routerURL isClassMethod:NO arg:arg completion:completion];
}

/**
 路由
 
 @param routerURL 路由的URL 参数带到URL后面  NSString *routerURL = @"ylt://classname/selectorname?username=alex&password=123456";
 @param isClassMethod 是否是类方法：默认NO
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToURL:(NSString *)routerURL isClassMethod:(BOOL)isClassMethod arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    if ([routerURL hasPrefix:YLT_ROUTER_PREFIX]) {
        NSDictionary *urlParams = [self analysisURL:routerURL];
        NSString *clsname = ([urlParams.allKeys containsObject:YLT_ROUTER_CLS_NAME])?urlParams[YLT_ROUTER_CLS_NAME]:@"";
        NSString *selname = ([urlParams.allKeys containsObject:YLT_ROUTER_SEL_NAME])?urlParams[YLT_ROUTER_SEL_NAME]:@"";
        NSDictionary *params = ([urlParams.allKeys containsObject:YLT_ROUTER_ARG_DATA])?urlParams[YLT_ROUTER_ARG_DATA]:nil;
        return [self ylt_routerToClassname:clsname selname:selname isClassMethod:isClassMethod param:params arg:arg completion:completion];
    } else if ([routerURL hasPrefix:@"http://"] || [routerURL hasPrefix:@"https://"]) {
        YLT_LogWarn(@"webview 待开发");
    } else {
        YLT_LogError(@"路由错误");
    }
    return nil;
}

/**
 路由
 
 @param clsname 路由到对应的classname
 @param selname 方法名对应的字串
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToClassname:(NSString *)clsname selname:(NSString *)selname arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    return [self ylt_routerToClassname:clsname selname:selname isClassMethod:NO arg:arg completion:completion];
}

/**
 路由
 
 @param clsname 路由到对应的classname
 @param selname 方法名对应的字串 后面可以带参数
 @param isClassMethod 是否是类方法：默认NO
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToClassname:(NSString *)clsname selname:(NSString *)selname isClassMethod:(BOOL)isClassMethod arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    NSString *sel = selname;
    NSDictionary *params = @{};
    if ([sel containsString:@"?"]) {
        sel = [[selname componentsSeparatedByString:@"?"] firstObject];
        NSString *paramString = [[selname componentsSeparatedByString:@"?"] lastObject];
        params = [self generateParamsString:paramString];
    }
    return [self ylt_routerToClassname:clsname selname:sel isClassMethod:isClassMethod param:params arg:arg completion:completion];
}

/**
 路由
 
 @param clsname 路由到对应的classname
 @param selname 方法名对应的字串
 @param isClassMethod 是否是类方法
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToClassname:(NSString *)clsname selname:(NSString *)selname isClassMethod:(BOOL)isClassMethod param:(NSDictionary *)param arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    //路由的对象类
    Class cls = NSClassFromString(clsname);
    NSAssert(cls!=NULL, @"路由的类异常");
    if (!clsname.ylt_isValid || (cls == NULL)) {
        YLT_LogError(@"路由的类异常");
        return nil;
    }
    selname = (selname.ylt_isValid?selname:@"ylt_router:");
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (param) {
        [params addEntriesFromDictionary:param];
    }
    if ([arg isKindOfClass:[NSDictionary class]]) {
        [params addEntriesFromDictionary:(NSDictionary *)arg];
    } else if (arg) {
        [params setObject:arg forKey:@"ylt_arg"];
    }
    if (completion) {
        [params setObject:completion forKey:YLT_ROUTER_COMPLETION];
    }
    
    id instance = nil;
    if (isClassMethod) {//类方法
        instance = cls;
    } else {
        instance = [[cls alloc] init];
    }
    NSArray *sels = [selname componentsSeparatedByString:@"."];
    for (NSInteger i = 0; i < sels.count-1; i++) {
        NSString *sel = sels[i];
        if (sel.ylt_isValid) {
            YLT_BeginIgnoreUndeclaredSelecror
            YLT_BeginIgnorePerformSelectorLeaksWarning
            NSAssert([instance respondsToSelector:NSSelectorFromString(sel)], @"路由的方法异常");
            instance = [instance performSelector:NSSelectorFromString(sel)];
            YLT_EndIgnoreUndeclaredSelecror
            YLT_EndIgnorePerformSelectorLeaksWarning
        }
    }
    selname = sels.lastObject;
    NSAssert([instance respondsToSelector:NSSelectorFromString(selname)], @"路由的方法异常");
    
    YLT_BeginIgnoreUndeclaredSelecror
    if ([instance respondsToSelector:@selector(setYlt_router_params:)]) {
        [instance performSelector:@selector(setYlt_router_params:) withObject:params];
    }
    if ([instance respondsToSelector:@selector(setYlt_params:)]) {
        [instance performSelector:@selector(setYlt_params:) withObject:params];
    }
    if (completion && [instance respondsToSelector:@selector(setYlt_completion:)]) {
        [instance performSelector:@selector(setYlt_completion:) withObject:completion];
    }
    return [self safePerformAction:NSSelectorFromString(selname) target:instance params:params];
    YLT_EndIgnoreUndeclaredSelecror
}


/**
 url runtime解析
 
 @param action 方法名
 @param target 类名
 @param params 参数
 @return 结果
 */
+ (id)safePerformAction:(SEL)action target:(id)target params:(NSDictionary *)params {
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];
    NSUInteger count =  [methodSig numberOfArguments];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    if (count >= 3) {
        [invocation setArgument:&params atIndex:2];
    } else {
//        YLT_LogInfo(@"Action：%@ 没有参数:%@",NSStringFromSelector(action),params);
    }
    [invocation setSelector:action];
    [invocation setTarget:target];
    if (strcmp(retType, @encode(void)) == 0) {
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    return nil;
}

#pragma mark - Tool

+ (NSDictionary *)analysisURL:(NSString *)routerURL {
    NSMutableDictionary *result = [NSMutableDictionary new];
    NSString *regex = @"([a-zA-Z0-9_]{1,})[/]{0,1}([a-zA-Z0-9_.:]{0,})[?]{0,1}([a-zA-Z0-9_=&]{0,})";
    NSError *error;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [expression matchesInString:routerURL options:NSMatchingReportProgress range:NSMakeRange(0, routerURL.length)];
    for (NSTextCheckingResult *match in matches) {
        NSInteger numbers = [match numberOfRanges];
        for (NSInteger i = 0; i < numbers; i ++) {
            NSString *tmpName = [routerURL substringWithRange:[match rangeAtIndex:i]];
            switch (i) {
                case 1: {
                    [result setObject:tmpName forKey:YLT_ROUTER_CLS_NAME];
                }
                    break;
                case 2: {
                    [result setObject:tmpName forKey:YLT_ROUTER_SEL_NAME];
                }
                    break;
                case 3: {
                    [result setObject:[self generateParamsString:tmpName] forKey:YLT_ROUTER_ARG_DATA];
                }
                    break;
            }
        }
    }
    
    return result;
}

+ (NSDictionary *)generateParamsString:(NSString *)paramString {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *components = [paramString componentsSeparatedByString:@"&"];
    for (NSString *tmpStr in components) {
        if (!tmpStr.ylt_isValid) {
            continue;
        }
        NSArray *tmpArray = [tmpStr componentsSeparatedByString:@"="];
        if (tmpArray.count == 2) {
            [params setObject:tmpArray[1] forKey:tmpArray[0]];
        }else {
            YLT_LogError(@"参数不合法 : %@",tmpStr);
        }
    }
    return params;
}

@end
