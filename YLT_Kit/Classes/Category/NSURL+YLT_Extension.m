//
//  NSURL+YLT_Extension.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/3/14.
//

#import "NSURL+YLT_Extension.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation NSURL (YLT_Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ylt_swizzleClassMethod:@selector(URLWithString:) withMethod:@selector(ylt_URLWithString:)];
    });
}

+ (nullable instancetype)ylt_URLWithString:(NSString *)URLString {
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self ylt_URLWithString:URLString];
}

@end
