//
//  UIView+YLT_GesExtension.m
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIView+YLT_GesExtension.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIView (YLT_GesExtension)

- (id(^)(id,SEL))ylt_add:(Class)cls {
    @weakify(self);
    return ^(id target,SEL action) {
        @strongify(self);
        id gesture = [[cls alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        self.userInteractionEnabled = YES;
        return gesture;
    };
}

- (void (^)(id))ylt_remove {
    @weakify(self);
    return ^(id obj) {
        @strongify(self);
        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
            //通过实例移除手势
            [self removeGestureRecognizer:obj];
        }else {
            //通过Class类型移除手势
            for (id ges in self.gestureRecognizers) {
                if ([ges isKindOfClass:obj]) {
                    [self removeGestureRecognizer:ges];
                }
            }
        }
    };
}

- (void (^)(void))ylt_removeAll {
    @weakify(self);
    return ^() {
        @strongify(self);
        for (UIGestureRecognizer *ges in self.gestureRecognizers) {
            [self removeGestureRecognizer:ges];
        }
    };
}

- (UITapGestureRecognizer *(^)(id, SEL))ylt_tap {
    return [self ylt_add:[UITapGestureRecognizer class]];
}

- (UIPinchGestureRecognizer *(^)(id, SEL))ylt_pinch {
    return [self ylt_add:[UIPinchGestureRecognizer class]];
}

- (UIPanGestureRecognizer *(^)(id, SEL))ylt_pan {
    return [self ylt_add:[UIPanGestureRecognizer class]];
}

- (UISwipeGestureRecognizer *(^)(id, SEL))ylt_swipe {
    return [self ylt_add:[UISwipeGestureRecognizer class]];
}

- (UIRotationGestureRecognizer *(^)(id, SEL))ylt_rotation {
    return [self ylt_add:[UIRotationGestureRecognizer class]];
}

- (UILongPressGestureRecognizer *(^)(id, SEL))ylt_longPress {
    return [self ylt_add:[UILongPressGestureRecognizer class]];
}

@end
