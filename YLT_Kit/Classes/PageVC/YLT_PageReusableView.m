//
//  YLT_PageReusableView.m
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_PageReusableView.h"

@implementation YLT_PageReusableView

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
    return YLT_PageView.class;
}

@end
