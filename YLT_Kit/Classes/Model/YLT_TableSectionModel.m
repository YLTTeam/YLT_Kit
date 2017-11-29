//
//  PHTableViewCellModel.m
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import "YLT_TableSectionModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation YLT_TableSectionModel

/**
 创建SectionData
 */
+ (YLT_TableSectionModel *(^)(NSArray *list))ph_sectionData {
    @weakify(self);
    return ^id(NSArray *list) {
        @strongify(self);
        YLT_TableSectionModel *result = [[YLT_TableSectionModel alloc] init];
        result.sectionData = list;
        return result;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat headerHeight, UIView *header))ph_sectionHeaderView {
    @weakify(self);
    return ^id(CGFloat headerHeight, UIView *header) {
        @strongify(self);
        self.sectionHeaderHeight = headerHeight;
        self.sectionHeaderView = header;
        self.sectionHeaderTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat headerHeight, NSString *headerTitle))ph_sectionHeaderTitle {
    @weakify(self);
    return ^id(CGFloat headerHeight, NSString *headerTitle) {
        @strongify(self);
        self.sectionHeaderHeight = headerHeight;
        self.sectionHeaderTitle = headerTitle;
        self.sectionHeaderView = nil;
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat footerHeight, UIView *footer))ph_sectionFooterView {
    @weakify(self);
    return ^id(CGFloat footerHeight, UIView *footer) {
        @strongify(self);
        self.sectionFooterHeight = footerHeight;
        self.sectionFooterView = footer;
        self.sectionFooterTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat footerHeight, NSString *footerTitle))ph_sectionFooterTitle {
    @weakify(self);
    return ^id(CGFloat footerHeight, NSString *footerTitle) {
        @strongify(self);
        self.sectionFooterHeight = footerHeight;
        self.sectionFooterTitle = footerTitle;
        self.sectionFooterView = nil;
        return self;
    };
}

/**
 cell配置
 */
- (YLT_TableSectionModel *(^)(CGFloat rowHeight, Class cellClass))ph_cell {
    @weakify(self);
    return ^id(CGFloat rowHeight, Class cellClass) {
        @strongify(self);
        self.rowHeight = rowHeight;
        self.cellClass = cellClass;
        return self;
    };
}

#pragma mark - 快速创建对象
/**
 快速创建表头
 
 @param list 数组
 @param headerHeight 高度
 @param headerView view
 @param footerHeight footerHeight
 @param footerView footerView
 @return 当前对象
 */
+ (YLT_TableSectionModel *)ph_sectionData:(NSArray *)list
                           headerHeight:(CGFloat)headerHeight
                             headerView:(UIView *)headerView
                           footerHeight:(CGFloat)footerHeight
                             footerView:(UIView *)footerView {
    YLT_TableSectionModel *result = YLT_TableSectionModel
                                    .ph_sectionData(list)
                                    .ph_sectionHeaderView(headerHeight, headerView)
                                    .ph_sectionFooterView(footerHeight, footerView);
    
    return result;
}

/**
 快速创建对象
 
 @param list 数组
 @param headerString 表头标题
 @param footerString 表尾标题
 @return 当前对象
 */
+ (YLT_TableSectionModel *)ph_sectionData:(NSArray *)list
                           headerString:(NSString *)headerString
                           footerString:(NSString *)footerString {
    YLT_TableSectionModel *result = YLT_TableSectionModel
                                    .ph_sectionData(list)
                                    .ph_sectionHeaderTitle(36., headerString)
                                    .ph_sectionFooterTitle(36., footerString);
    return result;
}


@end
