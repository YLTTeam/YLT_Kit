//
//  YLT_PageBaseView+DataSource.m
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_PageBaseView+DataSource.h"
#import "YLT_PageCell.h"
#import "YLT_PageTools.h"
#import "YLT_PageReusableView.h"
#import "NSArray+AppPage.h"
#import "YLT_PageVC.h"

@implementation YLT_PageBaseView (DataSource)

- (void)registerMainCollection:(UICollectionView *)mainCollection {
    [YLT_PageTools registerCellToCollectionView:mainCollection];
    mainCollection.delegate = self;
    mainCollection.dataSource = self;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    UIEdgeInsets result = sectionModel.appInsets;
    if (self.currentVC) {
        result = [self.currentVC resetInsets:result section:section];
    }
    return result;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    CGFloat result = sectionModel.appSpacing;
    if (self.currentVC) {
        result = [self.currentVC resetMinimumLineSpacing:result section:section];
    }
    return (result<0.01)?CGFLOAT_MIN:result;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    CGFloat result = sectionModel.appSpacing;
    if (self.currentVC) {
        result = [self.currentVC resetMinimumInteritemSpacing:result section:section];
    }
    return (result<0.01)?CGFLOAT_MIN:result;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    if ([sectionModel.headerModel isKindOfClass:YLT_HeaderModel.class]) {
        CGSize result = sectionModel.headerSize;
        if (self.currentVC) {
            result = [self.currentVC resetHeaderSize:result section:section];
        }
        return result;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    if ([sectionModel.footerModel isKindOfClass:YLT_FooterModel.class]) {
        CGSize result = sectionModel.footerSize;
        if (self.currentVC) {
            result = [self.currentVC resetFooterSize:result section:section];
        }
        return result;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize result = CGSizeZero;
    YLT_SectionModel *sectionModel = self.pageModel.page[indexPath.section];
    if (sectionModel.list.count > indexPath.row) {
        YLT_BaseModel *sectionData = sectionModel.list[indexPath.row];
        if ([YLT_PageTools isValidPageData:sectionModel]) {
            //计算当前 cell 的 size 大小
            result = sectionModel.rowSize;
            if (self.currentVC) {
                result = [self.currentVC resetCellSize:result indexPath:indexPath];
            }
            return result;
        }
    }
    //当 cellIdentify 为空或者 cellIdentify 数据异常的时候 返回空的size，即不显示
    return CGSizeZero;
}

- (JJCollectionViewRoundConfigModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    JJCollectionViewRoundConfigModel *model = [[JJCollectionViewRoundConfigModel alloc]init];
    model.backgroundColor = sectionModel.background.ylt_colorFromHexString;
    if (self.currentVC) {
        model = [self.currentVC resetRoundConfigModel:model configModelForSectionAtIndex:section];
    }
    
    return model;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YLT_SectionModel *sectionModel = self.pageModel.page[indexPath.section];
    BOOL isHeader = ([kind isEqualToString:UICollectionElementKindSectionHeader]);
    if ((isHeader && [sectionModel.headerModel isKindOfClass:YLT_HeaderModel.class]) ||
        (!isHeader && [sectionModel.footerModel isKindOfClass:YLT_FooterModel.class])) {
        NSString *reusableIdentify = @"YLT_PageReusableView";
        if (isHeader) {
            reusableIdentify = sectionModel.headerModel.cellIdentify;
        } else {
            reusableIdentify = sectionModel.footerModel.cellIdentify;
        }
        reusableIdentify = reusableIdentify.ylt_isValid?reusableIdentify:@"YLT_PageReusableView";
        YLT_PageReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableIdentify forIndexPath:indexPath];
        reusableView.data = isHeader ? sectionModel.headerModel : sectionModel.footerModel;
        if (self.currentVC) {
            [self.currentVC resetReusable:reusableView indexPath:indexPath];
        }
        return reusableView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger result = self.pageModel.page.count;
    if (self.currentVC) {
        result = [self.currentVC resetSectionCount:result];
    }
    return result;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    YLT_SectionModel *sectionModel = self.pageModel.page[section];
    NSInteger result = 0;
    if (sectionModel.sectionRows != 0) {
        result = sectionModel.sectionRows;
        if (self.currentVC) {
            result = [self.currentVC resetRowCount:result section:section];
        }
        return result;
    }
    if ([sectionModel isKindOfClass:YLT_SectionModel.class]) {
        result = sectionModel.list.count;
        if (self.currentVC) {
            result = [self.currentVC resetRowCount:result section:section];
        }
        return result;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLT_SectionModel *sectionModel = self.pageModel.page[indexPath.section];
    if (sectionModel.list.count > indexPath.row) {
        YLT_BaseModel *rowData = sectionModel.list[indexPath.row];
        if ([YLT_PageTools isValidPageData:sectionModel]) {
            YLT_PageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sectionModel.cellIdentify forIndexPath:indexPath];
            id data = (sectionModel.sectionRows==0)?rowData:self.pageModel.page[indexPath.section];
            cell.data = data;
            cell.indexPath = indexPath;
            if (self.currentVC) {
                cell = [self.currentVC resetCell:cell indexPath:indexPath];
            }
            return cell;
        }
    }
    
    YLT_PageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLT_PageCell" forIndexPath:indexPath];
    cell.data = nil;
    cell.indexPath = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YLT_SectionModel *sectionModel = self.pageModel.page[indexPath.section];
    YLT_PageCell *cell = (YLT_PageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.currentVC || ![self.currentVC selectedCell:cell indexPath:indexPath]) {
        BOOL needUpdate = [cell selectedIndexPath:indexPath sourceList:self.pageModel.page];
        if (needUpdate) {
            [collectionView performBatchUpdates:^{
                [collectionView reloadData];
            } completion:^(BOOL finished) {
            }];
        }
        YLT_BaseModel *rowData = sectionModel.list[indexPath.row];
        [YLT_PageTools routerForData:rowData];
    }
}


- (YLT_PageVC *)currentVC {
    if ([self.ylt_currentVC isKindOfClass:YLT_PageVC.class]) {
        return (YLT_PageVC *)self.ylt_currentVC;
    }
    return nil;
}

@end
