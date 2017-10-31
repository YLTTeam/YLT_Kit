//
//  UITextField+YLT_Create.m
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UITextField+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjc.h>

@implementation UITextField (YLT_Create)

/**
 文本框的类型
 */
- (UITextField *(^)(UITextBorderStyle style))YLT_TextBorderStyle {
    return ^id(UITextBorderStyle style) {
        self.borderStyle = style;
        return self;
    };
}
/**
 文本框的占位文字
 */
- (UITextField *(^)(NSString *placeholder))YLT_Placeholder {
    return ^id(NSString *placeholder) {
        self.placeholder = placeholder;
        return self;
    };
}
/**
 是否密文显示
 */
- (UITextField *(^)(BOOL secure))YLT_Secure {
    return ^id(BOOL secure) {
        self.secureTextEntry = secure;
        return self;
    };
}
/**
 左边视图
 */
- (UITextField *(^)(UIView *leftView))YLT_LeftView {
    return ^id(UIView *leftView) {
        if (CGRectEqualToRect(leftView.frame, CGRectZero)) {
            leftView.frame = CGRectMake(0, 0, 44, 44);
        }
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        return self;
    };
}
/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))YLT_TextColor {
    return ^id(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}

/**
 文本框字体颜色
 */
- (UITextField *(^)(UIFont *font))YLT_Font {
    return  ^id(UIFont *font) {
        self.font = font;
        return self;
    };
}
/**
 键盘类型
 */
- (UITextField *(^)(UIKeyboardType keyboardType))YLT_KeyboardType {
    return ^id (UIKeyboardType keyboardType) {
        self.keyboardType = keyboardType;
        return self;
    };
}

/**
 return type
 */
- (UITextField *(^)(UIReturnKeyType returnKeyType))YLT_ReturnKeyType {
    return ^id(UIReturnKeyType returnKeyType) {
        self.returnKeyType = returnKeyType;
        return self;
    };
}

/**
 文本框内容发生改变时的调用
 */
- (UITextField *(^)(void(^textDidChange)(NSString *value)))YLT_TextDidChange {
    return ^id(void(^textDidChange)(NSString *value)) {
        [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            if (textDidChange) {
                textDidChange(x);
            }
        }];
        return self;
    };
}

/**
 过滤类型
 */
- (UITextField *(^)(YLT_StringFilterType filterType))YLT_FilterType {
    return ^id(YLT_StringFilterType filterType) {
        return self;
    };
}

/**
 限制长度
 */
- (UITextField *(^)(NSUInteger limitLength))YLT_LimitLength {
    return ^id(NSUInteger limitLength) {
        [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            
        }];
        return self;
    };
}

@end
