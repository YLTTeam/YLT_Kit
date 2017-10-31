//
//  UITextField+YLT_Create.h
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, YLT_StringFilterType) {
    YLT_STRING_FILTER_TYPE_NUMBER = 100,//纯数字
    YLT_STRING_FILTER_TYPE_LETTER,//纯字母
    YLT_STRING_FILTER_TYPE_HANZI,//汉字
    YLT_STRING_FILTER_TYPE_EMOJI,//emoji
    YLT_STRING_FILTER_TYPE_SYMBOL,//符号
    YLT_STRING_FILTER_TYPE_NONE,//没有限制
};

@interface UITextField (YLT_Create)

/**
 文本框的类型
 */
- (UITextField *(^)(UITextBorderStyle style))YLT_TextBorderStyle;
/**
 文本框的占位文字
 */
- (UITextField *(^)(NSString *placeholder))YLT_Placeholder;
/**
 是否密文显示
 */
- (UITextField *(^)(BOOL secure))YLT_Secure;
/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))YLT_TextColor;
/**
 文本框字体颜色
 */
- (UITextField *(^)(UIFont *font))YLT_Font;
/**
 左边视图
 */
- (UITextField *(^)(UIView *leftView))YLT_LeftView;
/**
 键盘类型
 */
- (UITextField *(^)(UIKeyboardType keyboardType))YLT_KeyboardType;

/**
 return type
 */
- (UITextField *(^)(UIReturnKeyType returnKeyType))YLT_ReturnKeyType;

/**
 文本框内容发生改变时的调用
 */
- (UITextField *(^)(void(^textDidChange)(NSString *value)))YLT_TextDidChange;
/**
 过滤类型
 */
- (UITextField *(^)(YLT_StringFilterType filterType))YLT_FilterType;
/**
 限制长度
 */
- (UITextField *(^)(NSUInteger limitLength))YLT_LimitLength;

@end
