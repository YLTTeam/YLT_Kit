//
//  UIColor+YLT_Color.m
//  AFNetworking
//
//  Created by YLT_Alex on 2018/2/12.
//

#import "UIColor+YLT_Color.h"
#import <objc/message.h>

@implementation UIColor (YLT_Color)

@dynamic rr;
@dynamic gg;
@dynamic bb;

- (BOOL)convert {
    if (![objc_getAssociatedObject(self, @selector(convert)) boolValue]) {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        objc_setAssociatedObject(self, @selector(convert), @(YES), OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, @selector(rr), @(components[0]), OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, @selector(gg), @(components[1]), OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, @selector(bb), @(components[2]), OBJC_ASSOCIATION_ASSIGN);
    }
    return YES;
}

- (CGFloat)rr {
    if ([self convert]) {
        return [objc_getAssociatedObject(self, @selector(rr)) floatValue];
    }
    return 0.0;
}

- (CGFloat)gg {
    if ([self convert]) {
        return [objc_getAssociatedObject(self, @selector(gg)) floatValue];
    }
    return 0.0;
}

- (CGFloat)bb {
    if ([self convert]) {
        return [objc_getAssociatedObject(self, @selector(bb)) floatValue];
    }
    return 0.0;
}

@end
