//
//  AppPageView.m
//  App
//
//  Created by 項普華 on 2019/11/1.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "AppPageView.h"

@implementation AppPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView = UIView.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }).ylt_backgroundColor(UIColor.whiteColor);
    }
    return self;
}

- (RACSignal *)prepareForReuseSignal {
    if (!_prepareForReuseSignal) {
        _prepareForReuseSignal = self.rac_willDeallocSignal;
    }
    return _prepareForReuseSignal;
}

@end
