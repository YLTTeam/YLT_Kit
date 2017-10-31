//
//  UITableView+YLT_Create.h
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import "YLT_TableRowModel.h"
#import "YLT_TableSectionModel.h"
#import <Masonry/Masonry.h>

@interface UITableView (YLT_Create)

+ (UITableView *(^)(void))YLT_Create;
/**
 列表类别
 */
+ (UITableView *(^)(UIView *superView, void(^layout)(MASConstraintMaker *make), UITableViewStyle style))YLT_Layout;
/**
 视图的创建frame
 */
+ (UITableView *(^)(UIView *superView, CGRect frame, UITableViewStyle style))YLT_Frame;
/**
 header高度
 */
- (UITableView *(^)(UIView *headerView))YLT_TableHeader;
/**
 footer高度
 */
- (UITableView *(^)(UIView *footerView))YLT_TableFooter;
/**
 列表数据
 */
- (UITableView *(^)(NSArray<YLT_TableSectionModel *> *list))YLT_TableData;
/**
 cell配置
 */
- (UITableView *(^)(CGFloat rowHeight, Class cellClass))YLT_Cell;
/**
 单击Cell回调
 */
- (UITableView *(^)(void(^)(UITableViewCell *cell, NSIndexPath *indexPath, id response)))YLT_CellClick;
/**
 刷新列表
 */
- (UITableView *(^)(void))YLT_ReloadData;




/**
 header高度
 */
- (UITableView *(^)(CGFloat headerHeight, UIView *headerView))YLT_SectionHeader;
/**
 footer高度
 */
- (UITableView *(^)(CGFloat footerHeight, UIView *footerView))YLT_SectionFooter;

@end
