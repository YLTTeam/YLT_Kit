//
//  YLT_BaseModel+AppPage.m
//  App
//
//  Created by 項普華 on 2019/11/1.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_BaseModel+AppPage.h"

@implementation YLT_BaseModel (AppPage)

- (void)setClickAction:(NSString *)clickAction {
    objc_setAssociatedObject(self, @selector(clickAction), clickAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)clickAction {
    return objc_getAssociatedObject(self, @selector(clickAction));
}

- (NSString *)cellIdentify {
    return @"AppPageCell";
}

- (NSString *)headerIdentify {
    return @"AppPageReusableView";
}

- (NSString *)footerIdentify {
    return @"AppPageReusableView";
}

/// 路由事件
- (NSString *)routerAction {
    return @"";
}

#pragma mark - layout

/// 每个 section 包含的 rowCount
- (NSInteger)sectionRowCount {
    return 0;
}

/// 固定宽高      优先级 1
- (CGSize)rowSize {
    return CGSizeZero;
}

/// 行高，联合列一起计算size  优先级 2
- (CGFloat)rowHeight {
    return 0;
}

/// 宽高比，联合列一起计算size 默认16:9  优先级 3
- (CGFloat)ratio {
    return 1.;
}

/// 每行多少列，默认1
- (NSInteger)columnCount {
    return 1;
}

/// 内边距
- (UIEdgeInsets)sectionInsets {
    return UIEdgeInsetsZero;
}

/// 间隔，默认 8
- (CGFloat)spacing {
    return 8;
}

@end
