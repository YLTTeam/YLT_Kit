//
//  YLT_PageBaseView.m
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_PageBaseView.h"
#import "YLT_PageBaseView+DataSource.h"
#import <MJRefresh/MJRefresh.h>
#import <JJCollectionViewRoundFlowLayout/JJCollectionViewRoundFlowLayout.h>

@interface YLT_PageBaseView () {
}
@end

@implementation YLT_PageBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        JJCollectionViewRoundFlowLayout *flowLayout = [[JJCollectionViewRoundFlowLayout alloc] init];
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        self.mainCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.mainCollection.backgroundColor = UIColor.clearColor;
        [self addSubview:self.mainCollection];
        [self.mainCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self registerMainCollection:self.mainCollection];
    }
    return self;
}

- (void)stopLoading {
    [self.mainCollection.mj_header endRefreshing];
    [self.mainCollection.mj_footer endRefreshing];
}

- (void)setPullHeader:(void (^)(void))pullHeader {
    _pullHeader = pullHeader;
    if (pullHeader) {
        self.mainCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:pullHeader];
    } else {
        self.mainCollection.mj_header = nil;
    }
}

- (void)setPullFooter:(void (^)(void))pullFooter {
    _pullFooter = pullFooter;
    if (pullFooter) {
        self.mainCollection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:pullFooter];
    } else {
        self.mainCollection.mj_footer = nil;
    }
}

- (void)setPageModel:(YLT_PageModel *)pageModel {
    _pageModel = pageModel;
    [self.mainCollection reloadData];
}

@end
