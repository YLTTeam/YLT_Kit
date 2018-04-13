//
//  UINavigationController+YLT_Extension.m
//  BlackCard
//
//  Created by youye on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "UINavigationController+YLT_Extension.h"

@implementation UINavigationController (YLT_Extension)

/**
 寻找Navigation中的某个viewControler对象
 
 @param className viewControler名称
 @return viewControler对象
 */
- (id)ylt_findViewController:(NSString *)className {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}

/**
 判断是否只有一个RootViewController
 
 @return 是否只有一个RootViewController
 */
- (BOOL)ylt_isOnlyContainRootViewController {
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

/**
 viewControllers.firstObject
 
 @return RootViewController
 */
- (UIViewController *)ylt_rootViewController {
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

/**
 返回指定的viewControler
 
 @param className 指定viewControler类名
 @param animated 是否动画
 @return pop之后的viewControlers
 */
- (NSArray *)ylt_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    return [self popToViewController:[self ylt_findViewController:className] animated:YES];
}

/**
 返回指定的viewControler n层
 
 @param level n层
 @param animated 是否动画
 @return pop之后的viewControlers
 */
- (NSArray *)ylt_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated {
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

@end
