//
//  UILabel+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UILabel+YLT_Create.h"
#import "UIView+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UILabel (YLT_Create)

/**
 文字
 */
- (UILabel *(^)(NSString *text))YLT_Text {
    @weakify(self);
    return ^id(NSString *text) {
        @strongify(self);
        self.text = text;
        return self;
    };
}
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))YLT_TextColor {
    @weakify(self);
    return ^id(UIColor *textColor) {
        @strongify(self);
        self.textColor = textColor;
        return self;
    };
}
/**
 字体
 */
- (UILabel *(^)(UIFont *font))YLT_Font {
    @weakify(self);
    return ^id(UIFont *font) {
        @strongify(self);
        self.font = font;
        return self;
    };
}
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))YLT_FontSize {
    @weakify(self);
    return ^id(CGFloat fontSize) {
        @strongify(self);
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))YLT_TextAlignment {
    @weakify(self);
    return ^id(NSTextAlignment alignment) {
        @strongify(self);
        self.textAlignment = alignment;
        return self;
    };
}
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))YLT_LineNum {
    @weakify(self);
    return ^id(NSUInteger lineNum) {
        @strongify(self);
        self.numberOfLines = lineNum;
        return self;
    };
}


/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局
 @param text 文本
 @param textColor 颜色
 @param fontSize 字号
 @return 当前对象
 */
+ (UILabel *)YLT_CreateSuperView:(UIView *)superView
                         layout:(void(^)(MASConstraintMaker *make))layout
                           text:(NSString *)text
                          color:(UIColor *)textColor
                       fontSize:(CGFloat)fontSize {
    UILabel *result = UILabel
    .YLT_Layout(superView, layout)
    .YLT_ConvertToLabel()
    .YLT_TextColor(textColor)
    .YLT_FontSize(fontSize)
    .YLT_Text(text);
    return result;
}


@end
