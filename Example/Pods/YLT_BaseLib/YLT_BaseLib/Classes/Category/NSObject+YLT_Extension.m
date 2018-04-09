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

@implementation NSObject (YLT_Extension)



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
    if ([controller isKindOfClass:[UITabBarController class]]) {
        controller = ((UITabBarController *) controller).selectedViewController;
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller = [((UINavigationController *) controller).viewControllers lastObject];
    }
    return controller;
}

/**
 方法交换
 
 @param theClass 方法交换的类
 @param originalSel 原始方法
 @param replaceSel 替换的方法
 */
- (void)ylt_swizzleSelectorInClass:(Class)theClass originalSel:(SEL)originalSel replaceSel:(SEL)replaceSel {
    Method originalMethod = class_getInstanceMethod(theClass, originalSel);
    Method swizzledMethod = class_getInstanceMethod(theClass, replaceSel);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
