//
//  AppPageTools.h
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "YLT_BaseModel+AppPage.h"
#import "AppModel+Extension.h"

@interface AppPageTools : NSObject

/// 判断当前pageData的有效性,当 cellIdentify 为空或者 cellIdentify 数据异常的时候 返回空的size，即不显示
/// @param data 当前pageData
+ (BOOL)isValidPageData:(AppSectionModel *)data;

/// 路由事件
/// @param data 数据
+ (void)routerForData:(YLT_BaseModel *)data;

/// 单元格的size 默认屏幕宽度，宽高比为16：9
/// @param style 单元格样式
+ (CGSize)rowSizeFromStyle:(YLT_BaseModel *)style totalWidth:(CGFloat)totalWidth headerSource:(NSDictionary *)headerSource;

/// 计算间隔
/// @param style 单元格样式
+ (CGFloat)spacingFromStyle:(YLT_BaseModel *)style headerSource:(NSDictionary *)headerSource;

/// 计算内边距
/// @param style 单元格样式
+ (UIEdgeInsets)edgeInsetsFromStyle:(YLT_BaseModel *)style headerSource:(NSDictionary *)headerSource;

/// 给CollectionView注册Cell
/// @param collectionView collectionView
+ (void)registerCellToCollectionView:(UICollectionView *)collectionView;

@end
