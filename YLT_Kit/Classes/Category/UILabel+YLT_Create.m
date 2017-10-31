//
//  UILabel+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UILabel+YLT_Create.h"
#import "UIView+YLT_Create.h"

@implementation UILabel (YLT_Create)

/**
 文字
 */
- (UILabel *(^)(NSString *text))YLT_Text {
    return ^id(NSString *text) {
        self.text = text;
        return self;
    };
}
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))YLT_TextColor {
    return ^id(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}
/**
 字体
 */
- (UILabel *(^)(UIFont *font))YLT_Font {
    return ^id(UIFont *font) {
        self.font = font;
        return self;
    };
}
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))YLT_FontSize {
    return ^id(CGFloat fontSize) {
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))YLT_TextAlignment {
    return ^id(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))YLT_LineNum {
    return ^id(NSUInteger lineNum) {
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
