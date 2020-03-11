//
//  AppPageReusableView.m
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "AppPageReusableView.h"

@implementation AppPageReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mainView = [[self.mainViewClass alloc] initWithFrame:frame];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setData:(YLT_BaseModel *)data {
    _data = data;
    self.mainView.data = data;
}

- (Class)mainViewClass {
    return AppPageView.class;
}

@end
