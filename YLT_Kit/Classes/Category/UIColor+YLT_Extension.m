//
//  UIColor+YLT_Extension.m
//  AFNetworking
//
//  Created by YLT_Alex on 2018/2/12.
//

#import "UIColor+YLT_Extension.h"
#import <objc/message.h>

@implementation UIColor (YLT_Extension)

@dynamic ylt_r;
@dynamic ylt_g;
@dynamic ylt_b;

- (BOOL)convert {
    if (![objc_getAssociatedObject(self, @selector(convert)) boolValue]) {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        objc_setAssociatedObject(self, @selector(convert), @(YES), OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, @selector(ylt_r), @(components[0]), OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, @selector(ylt_g), @(components[1]), OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, @selector(ylt_b), @(components[2]), OBJC_ASSOCIATION_ASSIGN);
    }
    return YES;
}

- (CGFloat)ylt_r {
    if ([self convert]) {
        return [objc_getAssociatedObject(self, @selector(ylt_r)) floatValue];
    }
    return 0.0;
}

- (CGFloat)ylt_g {
    if ([self convert]) {
        return [objc_getAssociatedObject(self, @selector(ylt_g)) floatValue];
    }
    return 0.0;
}

- (CGFloat)ylt_b {
    if ([self convert]) {
        return [objc_getAssociatedObject(self, @selector(ylt_b)) floatValue];
    }
    return 0.0;
}

@end
