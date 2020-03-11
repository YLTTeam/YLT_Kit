//
//  YLT_PageVC.h
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <YLT_Kit/YLT_Kit.h>
#import "YLT_PageBaseView.h"
#import "ShareData.h"
#import "AppMacro.h"
#import "YLT_PageCell.h"
#import "YLT_PageReusableView.h"
#import "UIView+Appearance.h"
#import <JJCollectionViewRoundFlowLayout/JJCollectionViewRoundFlowLayout.h>
#import "YLT_PageModel.h"

@interface YLT_PageVC : YLT_BaseVC

@property (nonatomic, strong) YLT_PageBaseView *mainView;
/** 页面数据 */
@property (nonatomic, strong) YLT_PageModel *pageModel;

/** 页面数据 */
@property (nonatomic, strong) NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *pageList;
/** 页面配置 */
@property (nonatomic, strong) NSDictionary *pageObject;

- (UIEdgeInsets)resetInsets:(UIEdgeInsets)edgeInsets section:(NSInteger)section;

- (CGFloat)resetMinimumLineSpacing:(CGFloat)spacing section:(NSInteger)section;

- (CGFloat)resetMinimumInteritemSpacing:(CGFloat)spacing section:(NSInteger)section;

- (CGSize)resetHeaderSize:(CGSize)headerSize section:(NSInteger)section;

- (CGSize)resetFooterSize:(CGSize)footerSize section:(NSInteger)section;

- (CGSize)resetCellSize:(CGSize)cellSize indexPath:(NSIndexPath *)indexPath;

- (NSInteger)resetSectionCount:(NSInteger)sectionCount;
- (NSInteger)resetRowCount:(NSInteger)rowCount section:(NSInteger)section;

- (JJCollectionViewRoundConfigModel *)resetRoundConfigModel:(JJCollectionViewRoundConfigModel *)model configModelForSectionAtIndex:(NSInteger)section;

- (YLT_PageReusableView *)resetReusable:(YLT_PageReusableView *)reusable indexPath:(NSIndexPath *)indexPath;

- (YLT_PageCell *)resetCell:(YLT_PageCell *)cell indexPath:(NSIndexPath *)indexPath;

- (BOOL)selectedCell:(YLT_PageCell *)cell indexPath:(NSIndexPath *)indexPath;

/// 对组装好的数据做修改，慎用
/// @param list 数据
- (NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *)resetList:(NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *)list;

- (void)reloadData;

@end


