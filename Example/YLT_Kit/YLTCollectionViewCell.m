//
//  YLTCollectionViewCell.m
//  YLT_Kit_Example
//
//  Created by 項普華 on 2019/5/24.
//  Copyright © 2019 xphaijj0305@126.com. All rights reserved.
//

#import "YLTCollectionViewCell.h"
#import <YLT_Kit/YLT_Kit.h>

@interface YLTCollectionViewCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation YLTCollectionViewCell

- (void)ylt_configUI {
    self.backgroundColor = UIColor.blueColor;
    self.label = [[UILabel alloc] init];
    self.label.textColor = UIColor.whiteColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)ylt_indexPath:(NSIndexPath *)indexPath bindData:(id)data {
    NSLog(@"data %@", data);
    self.label.text = data;
}

@end
