//
//  UIViewController+YLT_BaseVC.m
//  Test
//
//  Created by 项普华 on 2018/4/3.
//  Copyright © 2018年 项普华. All rights reserved.
//

#import "UIViewController+YLT_BaseVC.h"
#import <objc/message.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIViewController (YLT_BaseVC)

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
        if ([self respondsToSelector:@selector(ylt_setup)]) {
            [self performSelector:@selector(ylt_setup)];
        }
        if ([self respondsToSelector:@selector(ylt_addSubViews)]) {
            [self performSelector:@selector(ylt_addSubViews)];
        }
        if ([self respondsToSelector:@selector(ylt_request)]) {
            [self performSelector:@selector(ylt_request)];
        }
    }];
    
    [[[self rac_signalForSelector:@selector(viewWillAppear:)] take:1] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if ([self respondsToSelector:@selector(ylt_bindData)]) {
            [self performSelector:@selector(ylt_bindData)];
        }
    }];
    
    [[self rac_signalForSelector:@selector(viewWillLayoutSubviews)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if ([self respondsToSelector:@selector(ylt_layout)]) {
            [self performSelector:@selector(ylt_layout)];
        }
    }];
    
    [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        if (self.navigationController && self.navigationController.viewControllers.count != 1 && [self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
            if ([self respondsToSelector:@selector(ylt_dismiss)]) {
                [self performSelector:@selector(ylt_dismiss)];
            }
            if ([self respondsToSelector:@selector(ylt_back)]) {
                [self performSelector:@selector(ylt_back)];
            }
        } else if (self.presentedViewController == nil) {
            if ([self respondsToSelector:@selector(ylt_dismiss)]) {
                [self performSelector:@selector(ylt_dismiss)];
            }
            if ([self respondsToSelector:@selector(ylt_back)]) {
                [self performSelector:@selector(ylt_back)];
            }
        }
    }];
    
    [[self rac_signalForSelector:@selector(prepareForSegue:sender:)] subscribeNext:^(RACTuple * _Nullable x) {
        UIStoryboardSegue *segue = x.first;
        id sender = x.last;
        if (segue && [segue respondsToSelector:@selector(destinationViewController)] && [segue.destinationViewController respondsToSelector:@selector(setylt_params:)]) {
            [segue.destinationViewController performSelector:@selector(setylt_params:) withObject:sender];
        }
    }];
}


#pragma mark - Public Method

/**
 创建控制器
 
 @return 控制器
 */
+ (UIViewController *)ylt_createVC {
    UIViewController *vc = [[self alloc] init];
    return vc;
}

/**
 快速创建控制器并传入参数
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_createVCWithParam:(id)ylt_param {
    UIViewController *vc = [self ylt_createVC];
    if ([vc respondsToSelector:@selector(setylt_params:)]) {
        [vc performSelector:@selector(setylt_params:) withObject:ylt_param];
    }
    return vc;
}

/**
 快速创建控制器并传入参数
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_createVCWithParam:(id)ylt_param
                                   callback:(void (^)(id))callback {
    UIViewController *vc = [self ylt_createVCWithParam:ylt_param];
    if ([vc respondsToSelector:@selector(setYlt_callback:)]) {
        [vc performSelector:@selector(setYlt_callback:) withObject:callback];
    }
    return vc;
}

/**
 创建视图并PUSH到对应的视图
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_pushVCWithParam:(id)ylt_param
                                 callback:(void (^)(id))callback {
    UIViewController *vc = [self ylt_createVCWithParam:ylt_param callback:callback];
    if (self.ylt_currentVC.navigationController == nil) {
        UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.ylt_currentVC presentViewController:rootNavi animated:YES completion:nil];
        return vc;
    }
    [self.ylt_currentVC.navigationController pushViewController:vc animated:YES];
    return vc;
}

/**
 创建控制器并Modal到对应的视图
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_modalVCWithParam:(id)ylt_param
                                  callback:(void (^)(id))callback {
    UIViewController *vc = [self ylt_createVCWithParam:ylt_param callback:callback];
    [self.ylt_currentVC presentViewController:vc animated:YES completion:nil];
    return vc;
}

#pragma clang diagnostic pop
@end
