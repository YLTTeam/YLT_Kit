//
//  NSArray+AppPage.m
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "NSArray+AppPage.h"
#import "AppPageTools.h"

@interface NSArray (Header)
@property (nonatomic, strong, readonly) NSDictionary *header;
@property (nonatomic, strong, readonly) NSDictionary *footer;
@end

@implementation NSArray (AppPage)

- (void)setHeaderSource:(NSDictionary *)headerSource {
    objc_setAssociatedObject(self, @selector(headerSource), headerSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)headerSource {
    NSDictionary *result = objc_getAssociatedObject(self, @selector(headerSource));
    return result?:@{};
}

- (NSDictionary *)header {
    if ([self.headerSource.allKeys containsObject:@"header"]) {
        return self.headerSource[@"header"];
    }
    return @{};
}
- (NSDictionary *)footer {
    if ([self.headerSource.allKeys containsObject:@"footer"]) {
        return self.headerSource[@"footer"];
    }
    return @{};
}

- (void)setSectionHeaderHeight:(CGFloat)sectionHeaderHeight {
    objc_setAssociatedObject(self, @selector(sectionHeaderHeight), @(sectionHeaderHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 头部 size
- (CGFloat)sectionHeaderHeight {
    CGFloat result = [objc_getAssociatedObject(self, @selector(sectionHeaderHeight)) floatValue];
    if (result == 0 && [self.header.allKeys containsObject:@"height"]) {
        result = [self.header[@"height"] floatValue];
    }
    return (result == 0) ? CGFLOAT_MIN : result;
}

- (void)setSectionFooterHeight:(CGFloat)sectionFooterHeight {
    objc_setAssociatedObject(self, @selector(sectionFooterHeight), @(sectionFooterHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 尾部 size
- (CGFloat)sectionFooterHeight {
    CGFloat result = [objc_getAssociatedObject(self, @selector(sectionFooterHeight)) floatValue];
    if (result == 0 && [self.footer.allKeys containsObject:@"height"]) {
        result = [self.footer[@"height"] floatValue];
    }
    return (result == 0) ? CGFLOAT_MIN : result;
}

- (void)setSectionHeaderData:(YLT_BaseModel *)sectionHeaderData {
    objc_setAssociatedObject(self, @selector(sectionHeaderData), sectionHeaderData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 头部的数据
- (YLT_BaseModel *)sectionHeaderData {
    if ([self.header.allKeys containsObject:@"data"]) {
        NSString *dataTag = [self.header objectForKey:@"data"];
        if ([dataTag hasPrefix:@"&"]) {
            //取的数据是本地的变量
            id obj = YLT_RouterQuick([dataTag substringFromIndex:1], nil);
            return obj;
        }
    }
    YLT_BaseModel *result = objc_getAssociatedObject(self, @selector(sectionHeaderData));
    if (result == nil && self.header && [self.header.allKeys containsObject:@"class"]) {
        Class cls = NSClassFromString(self.header[@"class"]);
        result = [cls mj_objectWithKeyValues:self.header];
    }
    return result;
}

- (void)setSectionFooterData:(YLT_BaseModel *)sectionFooterData {
    objc_setAssociatedObject(self, @selector(sectionFooterData), sectionFooterData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 尾部的数据
- (YLT_BaseModel *)sectionFooterData {
    if ([self.footer.allKeys containsObject:@"data"]) {
        NSString *dataTag = [self.footer objectForKey:@"data"];
        if ([dataTag hasPrefix:@"&"]) {
            //取的数据是本地的变量
            id obj = YLT_RouterQuick([dataTag substringFromIndex:1], nil);
            return obj;
        }
    }
    YLT_BaseModel *result = objc_getAssociatedObject(self, @selector(sectionFooterData));
    if (result == nil && self.footer && [self.footer.allKeys containsObject:@"class"]) {
        Class cls = NSClassFromString(self.footer[@"class"]);
        result = [cls mj_objectWithKeyValues:self.footer];
    }
    return result;
}

- (UIColor *)sectionBackgroundColor {
    if ([self.headerSource.allKeys containsObject:@"background"]) {
        return ((NSString *) self.headerSource[@"background"]).ylt_colorFromHexString;
    }
    return UIColor.clearColor;
}

- (void)setSectionRows:(NSInteger)sectionRows {
    objc_setAssociatedObject(self, @selector(sectionRows), @(sectionRows), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)sectionRows {
    return [objc_getAssociatedObject(self, @selector(sectionRows)) integerValue];
}

@end
