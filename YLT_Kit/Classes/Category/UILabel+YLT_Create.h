//
//  UILabel+YLT_Create.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UILabel (YLT_Create)

/**
 文字
 */
- (UILabel *(^)(NSString *text))YLT_Text;
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))YLT_TextColor;
/**
 字体
 */
- (UILabel *(^)(UIFont *font))YLT_Font;
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))YLT_FontSize;
/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))YLT_TextAlignment;
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))YLT_LineNum;


#pragma mark - 快速创建对象

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
                       fontSize:(CGFloat)fontSize;

@end
