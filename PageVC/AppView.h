//
//  AppView.h
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <YLT_Kit/YLT_Kit.h>
#import "YLT_BaseModel+AppPage.h"
#import "NSArray+AppPage.h"
#import <MJRefresh/MJRefresh.h>
#import "AppModel+Extension.h"

@interface AppView : YLT_BaseView

@property (nonatomic, strong) UICollectionView *mainCollection;

@property (nonatomic, strong) AppPageModel *pageModel;

/// 下拉刷新
@property (nonatomic, copy) void(^pullHeader)(void);

/// 上拉加载更多
@property (nonatomic, copy) void(^pullFooter)(void);

/// 停止加载
- (void)stopLoading;

@end
