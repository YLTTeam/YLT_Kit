//
// AppModel.h 
//
// Created By 项普华 Version: 2.0
// Copyright (C) 2020/03/11  By AlexXiang  All rights reserved.
// email:// xiangpuhua@126.com  tel:// +86 13316987488 
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BaseCollection.h"


@class AppHeaderModel;
@class AppFooterModel;
@class AppSectionModel;
@class AppPageModel;


@interface AppHeaderModel : YLT_BaseModel {
}
/** 高度 */
@property (readwrite, nonatomic, assign) CGFloat height;
/** 类名 */
@property (readwrite, nonatomic, copy) NSString *classname;
/** cellIdentify */
@property (readwrite, nonatomic, copy) NSString *cellIdentify;
/** 标题 */
@property (readwrite, nonatomic, copy) NSString *title;
/** 右侧标题 */
@property (readwrite, nonatomic, copy) NSString *rightTitle;
/** 事件 */
@property (readwrite, nonatomic, copy) NSString *clickAction;
/** 顶部间距 */
@property (readwrite, nonatomic, assign) CGFloat top;
/** 底部间距 */
@property (readwrite, nonatomic, assign) CGFloat bottom;
/** 左侧间距 */
@property (readwrite, nonatomic, assign) CGFloat left;
/** 右侧间距 */
@property (readwrite, nonatomic, assign) CGFloat right;
/** 数据 */
@property (readwrite, nonatomic, strong) YLT_BaseModel *data;

@end


@interface AppFooterModel : AppHeaderModel {
}

@end


@interface AppSectionModel : YLT_BaseModel {
}
/** 头部 */
@property (readwrite, nonatomic, strong) AppHeaderModel *headerModel;
/** 尾部 */
@property (readwrite, nonatomic, strong) AppFooterModel *footerModel;
/** 类名 */
@property (readwrite, nonatomic, copy) NSString *classname;
/** 数据索引 */
@property (readwrite, nonatomic, copy) NSString *dataTag;
/** 数据源 */
@property (readwrite, nonatomic, strong) NSMutableArray<YLT_BaseModel *> *list;
/** 每块返回的sections，如果为0则返回list的count */
@property (readwrite, nonatomic, assign) NSInteger sectionRows;
/** 背景色 */
@property (readwrite, nonatomic, copy) NSString *background;
/** cellIdentify */
@property (readwrite, nonatomic, copy) NSString *cellIdentify;
/** 路由事件 */
@property (readwrite, nonatomic, copy) NSString *clickAction;
/** 顶部间距 */
@property (readwrite, nonatomic, assign) CGFloat top;
/** 底部间距 */
@property (readwrite, nonatomic, assign) CGFloat bottom;
/** 左侧间距 */
@property (readwrite, nonatomic, assign) CGFloat left;
/** 右侧间距 */
@property (readwrite, nonatomic, assign) CGFloat right;
/** 单元格宽度 */
@property (readwrite, nonatomic, assign) CGFloat width;
/** 单元格高度 */
@property (readwrite, nonatomic, assign) CGFloat height;
/** 宽高比 宽度默认 screenWidth */
@property (readwrite, nonatomic, assign) CGFloat ratio;
/** 每行多少列，默认1列 */
@property (readwrite, nonatomic, assign) NSInteger columCount;
/** 单元格间距 */
@property (readwrite, nonatomic, assign) CGFloat spacing;
/** 自定义Type类型 */
@property (readwrite, nonatomic, assign) NSInteger customType;
/** 扩展数据 */
@property (readwrite, nonatomic, strong) NSMutableDictionary *extraData;

@end


@interface AppPageModel : YLT_BaseModel {
}
/**  */
@property (readwrite, nonatomic, strong) NSMutableArray<AppSectionModel *> *page;
/**  */
@property (readwrite, nonatomic, copy) NSString *title;
/** 本地数据 */
@property (readwrite, nonatomic, strong) NSMutableDictionary *localData;

@end
