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
    NSString *clsReason = [NSString stringWithFormat:@"路由的类异常 %@", clsname];
    NSAssert(cls!=NULL, clsReason);
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
            NSString *reason = [NSString stringWithFormat:@"路由的方法异常 %@ %@", clsname, sel];
            NSAssert([instance respondsToSelector:NSSelectorFromString(sel)], reason);
            instance = [instance performSelector:NSSelectorFromString(sel)];
            YLT_EndIgnoreUndeclaredSelecror
            YLT_EndIgnorePerformSelectorLeaksWarning
        }
    }
    selname = sels.lastObject;
    NSString *reason = [NSString stringWithFormat:@"路由的方法异常 %@ %@", clsname, selname];
    if (!isClassMethod && ![instance respondsToSelector:NSSelectorFromString(selname)] && [cls respondsToSelector:NSSelectorFromString(selname)]) {
        /* 当用户传的是实例方法的时候，发现实例不响应的时候，去检查一下类是否响应此方法 */
        YLT_LogWarn(@"当前调用的是实例方法，但是实例方法不响应，类方法响应 直接改为类方法调用 %@ %@", clsname, selname);
        instance = cls;
    }
    NSAssert([instance respondsToSelector:NSSelectorFromString(selname)], reason);
    
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

/**
 解析URL
 
 @param routerURL ylt://class[/sel][/...多余的被忽略...][?参数]
 */
+ (NSDictionary *)analysisURL:(NSString *)routerURL {
    //显示错误
    void(^showError)(void) = ^{
        YLT_LogError(@"URL不合法 : %@", routerURL);
    };
    
    //验证字符串
    BOOL(^validateString)(NSString *) = ^(NSString *string) {
        if (![string ylt_isValid]) {
            showError();
            return NO;
        }
        return YES;
    };
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  YLT_ROUTER_CLS_NAME:@"",
                                                                                  YLT_ROUTER_SEL_NAME:@"",
                                                                                  YLT_ROUTER_ARG_DATA:@{}
                                                                                  }];
    
    //不以“ylt://”未前缀，或者字符串就是“ylt://”，则不合法
    if (![routerURL ylt_isValid] || ![routerURL hasPrefix:YLT_ROUTER_PREFIX] || [routerURL isEqualToString:YLT_ROUTER_PREFIX]) {
        showError();
        return result;
    }
    
    NSString *tempString = nil;
    NSScanner *scanner = [NSScanner scannerWithString:routerURL];
    [scanner setScanLocation:YLT_ROUTER_PREFIX.length]; //设置从ylt://后面开始扫描
    //解析路径部分
    {
        //扫描出path部分(ylt://.....?)
        [scanner scanUpToString:@"?" intoString:&tempString];
        NSArray *comps = [tempString componentsSeparatedByString:@"/"];
        
        //YLT_ROUTER_CLS_NAME
        if (comps.count > 0) {
            NSString *cls = comps[0];
            if (!validateString(cls)) {//验证cls是否合法
                return result;
            }
            [result setObject:cls forKey:YLT_ROUTER_CLS_NAME];
        }
        
        //YLT_ROUTER_SEL_NAME
        if (comps.count > 1) {
            NSString *sel = comps[1];
            if (!validateString(sel)) {
                return result;
            } //验证sel是否合法
            [result setObject:sel forKey:YLT_ROUTER_SEL_NAME];
        }
    }
    
    //解析参数部分
    {
        //扫描出参数部分(这里填'??',因为参数部分不可能有‘??’,所以会将剩余部分全部放入tempString)
        //这里就是两个问号，不是手误
        tempString = nil;
        [scanner scanUpToString:@"??" intoString:&tempString];
        if ([tempString ylt_isValid]) {
            //如果开头是？，则删除?
            if ([tempString hasPrefix:@"?"]) {
                tempString = [tempString substringFromIndex:1];
            }
            [result setObject:[self generateParamsString:tempString] forKey:YLT_ROUTER_ARG_DATA];
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
