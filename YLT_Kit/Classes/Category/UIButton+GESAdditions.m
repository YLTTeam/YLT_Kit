//
//  UIButton+GESAdditions.m
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIButton+GESAdditions.h"

@implementation UIButton (GESAdditions)

- (void (^)(id, SEL, UIControlEvents))ges_addAction {
    return ^(id target,SEL action,UIControlEvents controlEvents) {
        [self addTarget:target action:action forControlEvents:controlEvents];
    };
}

@end
