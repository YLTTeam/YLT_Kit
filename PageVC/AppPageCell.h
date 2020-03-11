//
//  AppPageCell.h
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppPageView.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

static NSString *RemoveItemNotification = @"RemoveItemNotification";



@interface AppPageCell : UICollectionViewCell

@property (nonatomic, strong) AppPageView *mainView;

@property (nonatomic, strong) YLT_BaseModel *data;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (Class)mainViewClass;

- (BOOL)selectedIndexPath:(NSIndexPath *)indexPath sourceList:(NSMutableArray<AppSectionModel *> *)sourceList;

/// 左滑配置
/// @param swipeButtons 左滑按钮
/// @param clickBlock 回调
- (void)swipeButtons:(NSArray<UIButton *> *)swipeButtons clickBlock:(void(^)(UIButton *sender, AppPageCell *cell))clickBlock;

@end


