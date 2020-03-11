//
//  AppPageVC.h
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <YLT_Kit/YLT_Kit.h>
#import "AppView.h"
#import "ShareData.h"
#import "AppMacro.h"
#import "AppPageCell.h"
#import "AppPageReusableView.h"
#import "UIView+Appearance.h"
#import <JJCollectionViewRoundFlowLayout/JJCollectionViewRoundFlowLayout.h>
#import "AppModel.h"

@interface AppPageVC : YLT_BaseVC

@property (nonatomic, strong) AppView *mainView;
/** 页面数据 */
@property (nonatomic, strong) AppPageModel *pageModel;

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

- (AppPageReusableView *)resetReusable:(AppPageReusableView *)reusable indexPath:(NSIndexPath *)indexPath;

- (AppPageCell *)resetCell:(AppPageCell *)cell indexPath:(NSIndexPath *)indexPath;

- (BOOL)selectedCell:(AppPageCell *)cell indexPath:(NSIndexPath *)indexPath;

/// 对组装好的数据做修改，慎用
/// @param list 数据
- (NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *)resetList:(NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *)list;

- (void)reloadData;

@end


