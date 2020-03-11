//
//  AppPageView.h
//  App
//
//  Created by 項普華 on 2019/11/1.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <YLT_Kit/YLT_Kit.h>
#import "YLT_BaseModel+AppPage.h"
#import "ShareData.h"

@interface AppPageView : YLT_BaseView

@property (nonatomic, strong) YLT_BaseModel *data;

/// 主要视图
@property (nonatomic, strong) UIView *contentView;

/** 复用信号 */
@property (nonatomic, strong) RACSignal *prepareForReuseSignal;

@end


