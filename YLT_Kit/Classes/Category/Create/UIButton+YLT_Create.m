//
//  UIButton+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIButton+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIView+YLT_Create.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <AFNetworking/UIButton+AFNetworking.h>
#import "UIImage+YLT_Extension.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation UIButton (YLT_Create)
/**
 普通image
 */
- (UIButton *(^)(id img))ylt_normarlImage {
    @weakify(self);
    return ^id(id image) {
        @strongify(self);
        return self.ylt_stateImage(image, UIControlStateNormal);
    };
}
/**
 普通title
 */
- (UIButton *(^)(NSString *title))ylt_normalTitle {
    @weakify(self);
    return ^id(NSString *title) {
        @strongify(self);
        return self.ylt_stateTitle(title, UIControlStateNormal);
    };
}
/**
 普通Color
 */
- (UIButton *(^)(UIColor *color))ylt_normalColor {
    @weakify(self);
    return ^id(UIColor *color) {
        @strongify(self);
        return self.ylt_stateColor(color, UIControlStateNormal);
    };
}
/**
 普通字号
 */
- (UIButton *(^)(CGFloat fontSize))ylt_fontSize {
    @weakify(self);
    return ^id(CGFloat fontSize) {
        @strongify(self);
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
/**
 普通字体
 */
- (UIButton *(^)(UIFont *font))ylt_font {
    @weakify(self);
    return ^id(UIFont *font) {
        @strongify(self);
        self.titleLabel.font = font;
        return self;
    };
}
/**
 选中image
 */
- (UIButton *(^)(id img))ylt_selectedImage {
    @weakify(self);
    return ^id(id img) {
        @strongify(self);
        return self.ylt_stateImage(img, UIControlStateSelected);
    };
}
/**
 选中title
 */
- (UIButton *(^)(NSString *title))ylt_selectedTitle {
    @weakify(self);
    return ^id(NSString *title) {
        @strongify(self);
        return self.ylt_stateTitle(title, UIControlStateSelected);
    };
}
/**
 选中Color
 */
- (UIButton *(^)(UIColor *color))ylt_selectedColor {
    @weakify(self);
    return ^id(UIColor *color) {
        @strongify(self);
        return self.ylt_stateColor(color, UIControlStateSelected);
    };
}
/**
 高亮image
 */
- (UIButton *(^)(id img, UIControlState state))ylt_stateImage {
    @weakify(self);
    return ^id(id img, UIControlState state) {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            if ([img isKindOfClass:[UIImage class]]) {
                [self setImage:img forState:state];
            }
            else if ([img isKindOfClass:[NSURL class]]) {
                [self setImageForState:state withURL:img];
            }
            else if ([img isKindOfClass:[NSString class]]) {
                if ([((NSString *)(img)) ylt_isURL]) {
                    [self setImageForState:state withURL:[NSURL URLWithString:img]];
                }
                else {
                    [self setImage:[UIImage ylt_imageNamed:img] forState:state];
                }
            }
            [self setContentMode:UIViewContentModeScaleAspectFit];
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        return self;
    };
}
/**
 高亮title
 */
- (UIButton *(^)(NSString *title, UIControlState state))ylt_stateTitle {
    @weakify(self);
    return ^id(NSString *title, UIControlState state) {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitle:title forState:state];
        }
        return self;
    };
}
/**
 高亮Color
 */
- (UIButton *(^)(UIColor *color, UIControlState state))ylt_stateColor {
    @weakify(self);
    return ^id(UIColor *color, UIControlState state) {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitleColor:color forState:state];
        }
        return self;
    };
}

/**
 设置按钮的状态
 */
- (UIButton *(^)(UIControlState state))ylt_state {
    @weakify(self);
    return ^id(UIControlState state) {
        @strongify(self);
        switch (state) {
            case UIControlStateHighlighted: self.highlighted = YES; break;
            case UIControlStateDisabled: self.enabled = YES; break;
            case UIControlStateSelected: self.selected = YES; break;
            default:
                break;
        }
        return self;
    };
}

/**
 布局
 */
- (UIButton *(^)(YLT_ButtonLayout layout))ylt_layout {
    @weakify(self);
    return ^id(YLT_ButtonLayout layout) {
        @strongify(self);
        [self layoutIfNeeded];
        switch (layout) {
            case YLT_ButtonLayoutImageAtLeft: {
                self.titleEdgeInsets = UIEdgeInsetsZero;
                self.imageEdgeInsets = UIEdgeInsetsZero;
            }
                break;
            case YLT_ButtonLayoutImageAtRight: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width-self.frame.size.width + self.titleLabel.intrinsicContentSize.width, 0.0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0, -self.titleLabel.frame.size.width-self.frame.size.width+self.imageView.frame.size.width);
            }
                break;
            case YLT_ButtonLayoutImageAtTop: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, -self.imageView.frame.size.height-20, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, 0.0, 0.0, -self.titleLabel.intrinsicContentSize.width);
            }
                break;
            case YLT_ButtonLayoutImageAtBottom: {
                self.titleEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, -self.imageView.frame.size.width, 0.0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -self.imageView.frame.size.height-20, -self.titleLabel.intrinsicContentSize.width);
            }
                break;
        }
        return self;
    };
}


/**
 点击按钮的事件
 */
- (UIButton *(^)(void(^)(UIButton *response)))ylt_buttonClickBlock {
    @weakify(self);
    return ^id(void(^clickBlock)(UIButton *response)) {
        @strongify(self);
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (clickBlock) {
                clickBlock(x);
            }
        }];
        return self;
    };
}

/**
 信号量
 */
- (UIView *(^)(RACSignal *signal))ylt_signal {
    @weakify(self);
    return ^id(RACSignal *signal) {
        [signal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            YLT_Log(@"%@", x);
        }];
        return self;
    };
}

#pragma mark - 快速创建对象
/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局约束
 @param image 图片
 @param clickBlock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            image:(id)image
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .ylt_createLayout(superView, layout)
    .ylt_convertToButton()
    .ylt_normarlImage(image)
    .ylt_clickBlock(clickBlock);
    return result;
}

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param title 标题
 @param clickBLock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            title:(NSString *)title
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .ylt_createLayout(superView, layout)
    .ylt_convertToButton()
    .ylt_normalTitle(title)
    .ylt_normalColor([@"0x515151" ylt_colorFromHexString])
    .ylt_clickBlock(clickBlock);

    return result;
}

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param image 图像
 @param title 标题
 @param buttonLayout button上图像与标题的布局
 @param clickBlock 点击事件的回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            image:(id)image
                            title:(NSString *)title
                     buttonLayout:(YLT_ButtonLayout)buttonLayout
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .ylt_createLayout(superView, layout)
    .ylt_convertToButton()
    .ylt_normalTitle(title)
    .ylt_normarlImage(image)
    .ylt_normalColor([@"0x515151" ylt_colorFromHexString])
    .ylt_layout(buttonLayout)
    .ylt_clickBlock(clickBlock);
    
    return result;
}


@end
#pragma clang diagnostic pop
