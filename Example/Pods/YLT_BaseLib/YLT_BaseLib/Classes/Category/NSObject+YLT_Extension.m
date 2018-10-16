//
//  NSObject+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import "NSObject+YLT_Extension.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import <objc/message.h>
#import "YLT_BaseMacro.h"
#import <MJExtension/MJExtension.h>
#import <FastCoding/FastCoder.h>

@implementation NSObject (YLT_Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIView ylt_swizzleInstanceMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(ylt_dealloc)];
        [UIViewController ylt_swizzleInstanceMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(ylt_dealloc)];
    });
}

- (void)ylt_dealloc {
    if ([self isKindOfClass:UIView.class] ||
        [self isKindOfClass:UIViewController.class]) {
        if ([self isKindOfClass:UIViewController.class]) {
            YLT_LogInfo(@"%@ dealloc is safe", NSStringFromClass(self.class));
        }
        YLT_RemoveNotificationObserver();
    }
    
    [self ylt_dealloc];
}

/**
 获取当前的控制器
 
 @return 当前控制器
 */
- (UIViewController *)ylt_currentVC {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    for (UIView *subView in [window subviews]) {
        UIResponder *responder = [subView nextResponder];
        if ([responder isEqual:window]) {
            if ([[subView subviews] count]) {
                UIView *subSubView = [subView subviews][0];
                responder = [subSubView nextResponder];
            }
        }
        if([responder isKindOfClass:[UIViewController class]]) {
            return [NSObject ylt_topViewController:((UIViewController *) responder)];
        }
    }
    
    return window.rootViewController;
}

- (UIViewController *)ylt_topViewController:(UIViewController *)controller {
    BOOL isPresenting = NO;
    do {
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
    } while (isPresenting);
    while ([controller isKindOfClass:[UITabBarController class]]) {
        controller = ((UITabBarController *) controller).selectedViewController;
        if ([controller isKindOfClass:[UINavigationController class]]) {
            controller = [((UINavigationController *) controller).viewControllers lastObject];
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller = [((UINavigationController *) controller).viewControllers lastObject];
    }
    return controller;
}

/**
 方法交换 类方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    Method originalMethod = class_getClassMethod(cls, origSelector);
    Method swizzledMethod = class_getClassMethod(cls, newSelector);
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/**
 方法交换 实例方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = self;
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

/**
 *  存储对象
 *
 *  @param key key
 */
- (void)ylt_storeValueWithKey:(NSString *)key {
    NSParameterAssert(self);
    NSParameterAssert(key);
    
    NSData *data = [FastCoder dataWithRootObject:self];
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 *  获取对象
 *
 *  @param key key
 *
 *  @return 对象
 */
+ (id)ylt_valueByKey:(NSString *)key {
    NSParameterAssert(key);
    if (![[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
        return nil;
    }
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return [FastCoder objectWithData:data];
}

/**
 *  移除对象
 *
 *  @param key key
 */
+ (void)ylt_removeValueForKey:(NSString *)key {
    NSParameterAssert(key);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    YLT_LogError(@"设置的值VALUE:%@ 没有对应的KEY:%@", value, key);
}

#pragma mark -

@end
