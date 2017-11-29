//
//  UIButton+GESAdditions.m
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIButton+GESAdditions.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIButton (GESAdditions)

- (void (^)(id, SEL, UIControlEvents))ges_addAction {
    @weakify(self);
    return ^(id target,SEL action,UIControlEvents controlEvents) {
        @strongify(self);
        [self addTarget:target action:action forControlEvents:controlEvents];
    };
}

@end
