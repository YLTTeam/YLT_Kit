//
//  UIView+GESAdditions.m
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIView+GESAdditions.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIView (GESAdditions)

- (id(^)(id,SEL))ges_add:(Class)cls {
    @weakify(self);
    return ^(id target,SEL action) {
        @strongify(self);
        id gesture = [[cls alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        self.userInteractionEnabled = YES;
        return gesture;
    };
}

- (void (^)(id))ges_remove {
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

- (void (^)(void))ges_removeAll {
    @weakify(self);
    return ^() {
        @strongify(self);
        for (UIGestureRecognizer *ges in self.gestureRecognizers) {
            [self removeGestureRecognizer:ges];
        }
    };
}

- (UITapGestureRecognizer *(^)(id, SEL))ges_tap {
    return [self ges_add:[UITapGestureRecognizer class]];
}

- (UIPinchGestureRecognizer *(^)(id, SEL))ges_pinch {
    return [self ges_add:[UIPinchGestureRecognizer class]];
}

- (UIPanGestureRecognizer *(^)(id, SEL))ges_pan {
    return [self ges_add:[UIPanGestureRecognizer class]];
}

- (UISwipeGestureRecognizer *(^)(id, SEL))ges_swipe {
    return [self ges_add:[UISwipeGestureRecognizer class]];
}

- (UIRotationGestureRecognizer *(^)(id, SEL))ges_rotation {
    return [self ges_add:[UIRotationGestureRecognizer class]];
}

- (UILongPressGestureRecognizer *(^)(id, SEL))ges_longPress {
    return [self ges_add:[UILongPressGestureRecognizer class]];
}

@end
