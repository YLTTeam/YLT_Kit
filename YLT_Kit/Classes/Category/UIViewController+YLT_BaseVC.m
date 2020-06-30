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
#import <Aspects/Aspects.h>

@implementation UIViewController (YLT_BaseVC)

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewDidLoad) withMethod:@selector(ylt_viewDidLoad)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewWillAppear:) withMethod:@selector(ylt_viewWillAppear:)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewDidAppear:) withMethod:@selector(ylt_viewDidAppear:)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewWillLayoutSubviews) withMethod:@selector(ylt_viewWillLayoutSubviews)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(viewWillDisappear:) withMethod:@selector(ylt_viewWillDisappear:)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(prepareForSegue:sender:) withMethod:@selector(ylt_prepareForSegue:sender:)];
        [UIViewController ylt_swizzleInstanceMethod:@selector(didMoveToParentViewController:) withMethod:@selector(ylt_didMoveToParentViewController:)];
    });
}

#pragma mark - hook
- (void)ylt_viewDidLoad {
    [self ylt_viewDidLoad];
}

- (void)ylt_request {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(ylt_request)]) {
            [obj performSelector:@selector(ylt_request)];
        }
    }];
}

- (void)ylt_viewWillAppear:(BOOL)animated {
    [self ylt_viewWillAppear:animated];
    if (self.ylt_queue.isSuspended) {
        //队列处于暂停状态 页面显示 开启队列
        [self.ylt_queue setSuspended:NO];
    }
}

- (void)ylt_viewDidAppear:(BOOL)animated {
    [self ylt_viewDidAppear:animated];
    if (self.ylt_needRefreshRequest) {
        [self ylt_request];
    }
    self.ylt_needRefreshRequest = NO;
}

- (void)ylt_viewWillLayoutSubviews {
    [self ylt_viewWillLayoutSubviews];
    if ([self respondsToSelector:@selector(ylt_layout)]) {
        [self performSelector:@selector(ylt_layout)];
    }
}

- (void)ylt_didMoveToParentViewController:(UIViewController *)parent {
    [self ylt_didMoveToParentViewController:parent];
    if (parent == nil) {
        if ([self respondsToSelector:@selector(ylt_back)]) {
            [self performSelector:@selector(ylt_back)];
        }
    }
}

- (void)ylt_viewWillDisappear:(BOOL)animated {
    [self ylt_viewWillDisappear:animated];
    if (self.navigationController && self.navigationController.viewControllers.count != 1 && [self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        if ([self respondsToSelector:@selector(ylt_dismiss)]) {
            [self performSelector:@selector(ylt_dismiss)];
        }
    } else if (self.presentedViewController == nil) {
        if ([self respondsToSelector:@selector(ylt_dismiss)]) {
            [self performSelector:@selector(ylt_dismiss)];
        }
    }
    if (!self.ylt_queue.isSuspended && self.ylt_queue.operationCount > 0) {
        //队列处于非暂停状态 暂停队列
        [self.ylt_queue setSuspended:YES];
    }
}

- (void)ylt_dealloc {
    if ([self isKindOfClass:UIViewController.class]) {
        YLT_LogWarn(@"%@ dealloc is safe", NSStringFromClass(self.class));
        //队列处于非暂停状态 暂停队列
        [self.ylt_queue cancelAllOperations];
        YLT_RemoveNotificationObserver();
    }
    [self ylt_dealloc];
}

- (void)ylt_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self ylt_prepareForSegue:segue sender:sender];
    if (segue && [segue respondsToSelector:@selector(destinationViewController)] && [segue.destinationViewController respondsToSelector:@selector(setYlt_params:)]) {
        [segue.destinationViewController performSelector:@selector(setYlt_params:) withObject:sender];
    }
}

#pragma mark - Public Method

/**
 push进页面
 
 @param vc 目标页面
 @param callback 回调
 */
- (void)ylt_pushToVC:(UIViewController *)vc callback:(void(^)(id response))callback {
    if (vc == nil) {
        return;
    }
    vc.hidesBottomBarWhenPushed = YES;
    if (callback) {
        vc.ylt_callback = callback;
    }
    if (self.navigationController) {
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UINavigationController *navigationController = navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

/**
 push进页面
 
 @param vc 目标页面
 @param callback 回调
 */
- (void)ylt_presentToVC:(UIViewController *)vc callback:(void(^)(id response))callback {
    if (vc == nil) {
        return;
    }
    if (callback) {
        vc.ylt_callback = callback;
    }
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 创建控制器
 
 @return 控制器
 */
+ (UIViewController *)ylt_create {
    return [self ylt_createVC];
}

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
    if ([vc respondsToSelector:@selector(setYlt_params:)]) {
        [vc performSelector:@selector(setYlt_params:) withObject:ylt_param];
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
 创建视图并PUSH到对应的视图
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_pushVCWithParam:(id)ylt_param {
    return [self ylt_pushVCWithParam:ylt_param callback:nil];
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

/**
 创建控制器并Modal到对应的视图
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_modalVCWithParam:(id)ylt_param {
    return [self ylt_modalVCWithParam:ylt_param callback:nil];
}

#pragma mark - getter

- (void)setYlt_params:(id)ylt_params {
    objc_setAssociatedObject(self, @selector(ylt_params), ylt_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ylt_params {
    return objc_getAssociatedObject(self, @selector(ylt_params));
}

- (void)setYlt_needRefreshRequest:(BOOL)ylt_needRefreshRequest {
    objc_setAssociatedObject(self, @selector(ylt_needRefreshRequest), @(ylt_needRefreshRequest), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)ylt_needRefreshRequest {
    return [objc_getAssociatedObject(self, @selector(ylt_needRefreshRequest)) boolValue];
}

- (NSOperationQueue *)ylt_queue {
    NSOperationQueue *result = objc_getAssociatedObject(self, @selector(ylt_queue));
    if (result == nil) {
        result = [[NSOperationQueue alloc] init];
        result.maxConcurrentOperationCount = 5;
        objc_setAssociatedObject(self, @selector(ylt_queue), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

- (void)setYlt_callback:(void (^)(id))ylt_callback {
    objc_setAssociatedObject(self, @selector(ylt_callback), ylt_callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(id))ylt_callback {
    void (^callback)(id) = objc_getAssociatedObject(self, @selector(ylt_callback));
    return callback;
}

- (void)setYlt_completion:(void (^)(NSError *, id))ylt_completion {
    objc_setAssociatedObject(self, @selector(ylt_completion), ylt_completion, OBJC_ASSOCIATION_COPY);
}

- (void(^)(NSError *, id))ylt_completion {
    void(^completion)(NSError *, id) = objc_getAssociatedObject(self, @selector(ylt_completion));
    if (!completion && self.ylt_params && self.ylt_params[YLT_ROUTER_COMPLETION]) {
        completion = self.ylt_params[YLT_ROUTER_COMPLETION];
    }
    return completion;
}

/**  在主线程执行操作*/
- (void)ylt_performSelectorOnMainThread:(void(^)(void))block{
    if ([[NSThread currentThread] isMainThread]) {
        block();
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

/**  退出 presentViewController  count：次数*/
- (void)ylt_dismissViewControllerWithCount:(NSInteger)count animated:(BOOL)animated{

    count--;
    // 不是自己，并且自己弹出过VC， 递归交给自己弹出的VC处理
    if (count>0 && self.presentingViewController) {
        [self.presentingViewController ylt_dismissViewControllerWithCount:count animated:animated];
    }
    else{
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}



/**  退出 presentViewController 到指定的控制器*/
- (void)ylt_dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated{

    // 不是自己，并且自己弹出过VC， 递归交给自己弹出的VC处理
    if (![self.class isKindOfClass:NSClassFromString(className)] && self.presentingViewController) {
        [self.presentingViewController ylt_dismissToViewControllerWithClassName:className animated:animated];
    }else{
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

#pragma clang diagnostic pop
@end
