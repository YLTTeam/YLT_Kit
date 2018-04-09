//
//  YLTTableViewCell.m
//  YLT_Kit_Example
//
//  Created by 项普华 on 2018/4/4.
//  Copyright © 2018年 xphaijj0305@126.com. All rights reserved.
//

#import "YLTTableViewCell.h"
#import <YLT_Kit/YLT_Kit.h>

@implementation YLTTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)ylt_indexPath:(NSIndexPath *)indexPath bindData:(id)data {
    self.label.text = data;
}

- (UILabel *)label {
    if (!_label) {
        _label = UILabel.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self).inset(20);
        })
        .ylt_convertToLabel()
        .ylt_font([UIFont systemFontOfSize:20])
        .ylt_textColor([UIColor greenColor]).ylt_lineNum(0);
    }
    return _label;
}

@end
