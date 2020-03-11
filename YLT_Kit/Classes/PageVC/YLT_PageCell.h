//
//  YLT_PageCell.h
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLT_PageView.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

static NSString *RemoveItemNotification = @"RemoveItemNotification";



@interface YLT_PageCell : UICollectionViewCell

@property (nonatomic, strong) YLT_PageView *mainView;

@property (nonatomic, strong) YLT_BaseModel *data;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (Class)mainViewClass;

- (BOOL)selectedIndexPath:(NSIndexPath *)indexPath sourceList:(NSMutableArray<YLT_SectionModel *> *)sourceList;

/// 左滑配置
/// @param swipeButtons 左滑按钮
/// @param clickBlock 回调
- (void)swipeButtons:(NSArray<UIButton *> *)swipeButtons clickBlock:(void(^)(UIButton *sender, YLT_PageCell *cell))clickBlock;

@end


