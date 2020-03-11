//
//  YLT_PageTools.m
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_PageTools.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <YLT_Kit/YLT_Kit.h>
#import "YLT_BaseModel+AppPage.h"

@implementation YLT_PageTools

/// 判断当前pageData的有效性
/// @param data 当前pageData
+ (BOOL)isValidPageData:(YLT_SectionModel *)data {
    return (
            ([data isKindOfClass:YLT_SectionModel.class] &&
             data.cellIdentify.ylt_isValid) &&
            (NSClassFromString(data.cellIdentify) != NULL)
            );
}

/// 单元格的size 默认屏幕宽度，宽高比为16：9
/// @param style 单元格样式
+ (CGSize)rowSizeFromStyle:(YLT_BaseModel *)style totalWidth:(CGFloat)totalWidth headerSource:(NSDictionary *)headerSource {
    if ([headerSource.allKeys containsObject:@"size"]) {
        return [headerSource[@"size"] CGSizeValue];
    }
    CGFloat height = ([headerSource.allKeys containsObject:@"height"])?[headerSource[@"height"] floatValue]:CGFLOAT_MIN;
    NSInteger column = ([headerSource.allKeys containsObject:@"column"])?[headerSource[@"column"] integerValue]:1;
    CGFloat ratio = ([headerSource.allKeys containsObject:@"ratio"])?[headerSource[@"ratio"] floatValue]:CGFLOAT_MIN;
    if (height > 0.01 || ratio > 0.01) {
        CGFloat spacing = [self spacingFromStyle:style headerSource:headerSource];
        UIEdgeInsets insets = [self edgeInsetsFromStyle:style headerSource:headerSource];
        CGFloat width = (YLT_SCREEN_WIDTH-insets.left-insets.right-((CGFloat) (column-1))*spacing)/column;
        if (height > 0.01) {
            return CGSizeMake(width, YLT_Scale_Width(height));
        }
        if (ratio > 0.01) {
            return CGSizeMake(width, width/ratio);
        }
    }

    if (![style isKindOfClass:[YLT_BaseModel class]]) {
        return CGSizeZero;
    }
    if (style) {
        if (!CGSizeEqualToSize(CGSizeZero, style.rowSize)) {
            return style.rowSize;
        }
        UIEdgeInsets insets = [self edgeInsetsFromStyle:style headerSource:headerSource];
        NSInteger column = (style.columnCount == 0) ? 1 : style.columnCount;
        CGFloat spacing = [self spacingFromStyle:style headerSource:headerSource];
        CGFloat width = (totalWidth-insets.left-insets.right-((CGFloat) (column-1))*spacing)/column;
        if (style.rowHeight != 0) {
            return CGSizeMake(width, YLT_Scale_Width(style.rowHeight));
        }
        CGFloat ratio = (style.ratio == 0) ? 16.0/9.0 : style.ratio;
        return CGSizeMake(width, width/ratio);
    }
    return CGSizeMake(YLT_SCREEN_WIDTH, YLT_SCREEN_WIDTH*9./16.);
}

/// 计算间隔
/// @param style 单元格样式
+ (CGFloat)spacingFromStyle:(YLT_BaseModel *)style headerSource:(NSDictionary *)headerSource {
    if ([headerSource isKindOfClass:[NSDictionary class]] && [headerSource.allKeys containsObject:@"spacing"]) {
        return [headerSource[@"spacing"] floatValue];
    }
    if (![style isKindOfClass:[YLT_BaseModel class]]) {
        return CGFLOAT_MIN;
    }
    return (style.spacing == 0) ? 8.0 : style.spacing;
}

/// 计算内边距
/// @param style 单元格样式
+ (UIEdgeInsets)edgeInsetsFromStyle:(YLT_BaseModel *)style headerSource:(NSDictionary *)headerSource {
    if ([headerSource isKindOfClass:NSDictionary.class] && ([headerSource.allKeys containsObject:@"top"] || [headerSource.allKeys containsObject:@"left"] || [headerSource.allKeys containsObject:@"bottom"] || [headerSource.allKeys containsObject:@"right"] )) {
        CGFloat top = ([headerSource.allKeys containsObject:@"top"])?[headerSource[@"top"] floatValue]:0;
        CGFloat left = ([headerSource.allKeys containsObject:@"left"])?[headerSource[@"left"] floatValue]:0;
        CGFloat bottom = ([headerSource.allKeys containsObject:@"bottom"])?[headerSource[@"bottom"] floatValue]:0;
        CGFloat right = ([headerSource.allKeys containsObject:@"right"])?[headerSource[@"right"] floatValue]:0;
        return UIEdgeInsetsMake(top, left, bottom, right);
    }
    
    if (![style isKindOfClass:[YLT_BaseModel class]]) {
        return UIEdgeInsetsZero;
    }
    return style.sectionInsets;
}


/// 路由事件
/// @param data 数据
+ (void)routerForData:(YLT_BaseModel *)data {
    YLT_BeginIgnorePerformSelectorLeaksWarning
    if ([data respondsToSelector:NSSelectorFromString(@"linkUrl")]) {
        YLT_RouterQuick([data performSelector:NSSelectorFromString(@"linkUrl")], nil);
    } else if (data.clickAction.ylt_isValid) {
        YLT_RouterQuick(data.clickAction, data);
    } else if (data.routerAction.ylt_isValid) {
        YLT_RouterQuick(data.routerAction, data);
    }
    YLT_EndIgnorePerformSelectorLeaksWarning
}

/// 给CollectionView注册Cell
/// @param collectionView collectionView
+ (void)registerCellToCollectionView:(UICollectionView *)collectionView {
    [collectionView registerCell:@[@"YLT_PageCell", @"AppBannerCell", @"AppMenuCell", @"AppCourseCell", @"CourseProductCell", @"InputDataCell", @"AddressInputCell", @"AddressListCell", @"MineSingleCell", @"HomeCourseCell", @"MusicTypeCell", @"MusicBannerCell", @"BCEduBoxCell", @"GoodsItemCell", @"ProductRecommendCell", @"CartCell", @"OrderProductCell", @"AddressTipCell", @"GroupUpPhotoCell", @"HomeBrandCell", @"HomeTeacherCell"]];
    
    NSArray<NSString *> *reusableList = @[@"AppNormalReusableView", @"CourseHeaderReusableView", @"CourseWeekHeaderReusableView", @"TotalPriceReusableView", @"MineHeaderReusableView", @"YLT_PageReusableView", @"MallGoodsTypeReusableView", @"CartHeaderReusableView"];
    [collectionView registerHeader:reusableList];
    [collectionView registerFooter:reusableList];
}

@end
