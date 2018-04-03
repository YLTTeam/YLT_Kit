//
//  UIViewController+BMBaseVC.m
//  Test
//
//  Created by 项普华 on 2018/4/3.
//  Copyright © 2018年 项普华. All rights reserved.
//

#import "UIViewController+YLT_BaseVC.h"
#import <objc/message.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIViewController (BMBaseVC)

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oriMethod = class_getInstanceMethod(self, @selector(loadView));
        Method method = class_getInstanceMethod(self, @selector(hookLoadView));
        //自身已经有了就添加不成功，直接交换即可
        if(class_addMethod(self, @selector(loadView), method_getImplementation(method), method_getTypeEncoding(method))){
            class_replaceMethod(self, @selector(hookLoadView), method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else{
            method_exchangeImplementations(oriMethod, method);
        }
    });
}
#pragma mark - hook
- (void)hookLoadView {
    [self hookLoadView];
    @weakify(self);
    [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if ([self respondsToSelector:@selector(bmSetup)]) {
            [self performSelector:@selector(bmSetup)];
        }
        if ([self respondsToSelector:@selector(bmAddSubViews)]) {
            [self performSelector:@selector(bmAddSubViews)];
        }
        if ([self respondsToSelector:@selector(bmRequest)]) {
            [self performSelector:@selector(bmRequest)];
        }
    }];
    
    [[[self rac_signalForSelector:@selector(viewWillAppear:)] take:1] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if ([self respondsToSelector:@selector(bmBindData)]) {
            [self performSelector:@selector(bmBindData)];
        }
    }];
    
    [[self rac_signalForSelector:@selector(viewWillLayoutSubviews)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if ([self respondsToSelector:@selector(bmLayout)]) {
            [self performSelector:@selector(bmLayout)];
        }
    }];
    
    [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if ([self respondsToSelector:@selector(bmDismiss)]) {
            [self performSelector:@selector(bmDismiss)];
        }
    }];
    
    [[self rac_signalForSelector:@selector(prepareForSegue:sender:)] subscribeNext:^(RACTuple * _Nullable x) {
        UIStoryboardSegue *segue = x.first;
        id sender = x.last;
        if (segue && [segue respondsToSelector:@selector(destinationViewController)] && [segue.destinationViewController respondsToSelector:@selector(setBmParam:)]) {
            [segue.destinationViewController performSelector:@selector(setBmParam:) withObject:sender];
        }
    }];
}


#pragma mark - Public Method

/**
 创建控制器
 
 @return 控制器
 */
+ (UIViewController *)bmCreateVC {
    UIViewController *vc = [[self alloc] init];
    return vc;
}

/**
 快速创建控制器并传入参数
 
 @param bmParam 参数
 @return 控制器
 */
+ (UIViewController *)bmCreateVCWithParam:(id)bmParam {
    UIViewController *vc = [self bmCreateVC];
    if ([vc respondsToSelector:@selector(setBmParam:)]) {
        [vc performSelector:@selector(setBmParam:) withObject:bmParam];
    }
    return vc;
}

/**
 快速创建控制器并传入参数
 
 @param bmParam 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)bmCreateVCWithParam:(id)bmParam
                                 callback:(void(^)(id response))callback {
    UIViewController *vc = [self bmCreateVCWithParam:bmParam];
    if ([vc respondsToSelector:@selector(setBmCallback:)]) {
        [vc performSelector:@selector(setBmCallback:) withObject:callback];
    }
    return vc;
}

/**
 创建视图并PUSH到对应的视图
 
 @param bmParam 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)bmPushVCWithParam:(id)bmParam
                               callback:(void(^)(id response))callback {
    UIViewController *vc = [self bmCreateVCWithParam:bmParam callback:callback];
    if (self.YLT_CurrentVC.navigationController == nil) {
        UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.YLT_CurrentVC presentViewController:rootNavi animated:YES completion:nil];
        return vc;
    }
    [self.YLT_CurrentVC.navigationController pushViewController:vc animated:YES];
    return vc;
}

/**
 创建控制器并Modal到对应的视图
 
 @param bmParam 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)bmModalVCWithParam:(id)bmParam
                                callback:(void(^)(id response))callback {
    UIViewController *vc = [self bmCreateVCWithParam:bmParam callback:callback];
    [self.YLT_CurrentVC presentViewController:vc animated:YES completion:nil];
    return vc;
}

#pragma clang diagnostic pop
@end
