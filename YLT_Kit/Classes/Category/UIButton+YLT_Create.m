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
#import "UIImage+YLT_Utils.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation UIButton (YLT_Create)
/**
 普通image
 */
- (UIButton *(^)(id img))YLT_NormarlImage {
    return ^id(id image) {
        return self.YLT_StateImage(image, UIControlStateNormal);
    };
}
/**
 普通title
 */
- (UIButton *(^)(NSString *title))YLT_NormalTitle {
    return ^id(NSString *title) {
        return self.YLT_StateTitle(title, UIControlStateNormal);
    };
}
/**
 普通Color
 */
- (UIButton *(^)(UIColor *color))YLT_NormalColor {
    return ^id(UIColor *color) {
        return self.YLT_StateColor(color, UIControlStateNormal);
    };
}
/**
 普通字号
 */
- (UIButton *(^)(CGFloat fontSize))YLT_FontSize {
    return ^id(CGFloat fontSize) {
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
/**
 选中image
 */
- (UIButton *(^)(id img))YLT_SelectedImage {
    return ^id(id img) {
        return self.YLT_StateImage(img, UIControlStateSelected);
    };
}
/**
 选中title
 */
- (UIButton *(^)(NSString *title))YLT_SelectedTitle {
    return ^id(NSString *title) {
        return self.YLT_StateTitle(title, UIControlStateSelected);
    };
}
/**
 选中Color
 */
- (UIButton *(^)(UIColor *color))YLT_SelectedColor {
    return ^id(UIColor *color) {
        return self.YLT_StateColor(color, UIControlStateSelected);
    };
}
/**
 高亮image
 */
- (UIButton *(^)(id img, UIControlState state))YLT_StateImage {
    return ^id(id img, UIControlState state) {
        if ([self isKindOfClass:[UIButton class]]) {
            if ([img isKindOfClass:[UIImage class]]) {
                [self setImage:img forState:state];
            }
            else if ([img isKindOfClass:[NSURL class]]) {
                [self setImageForState:state withURL:img];
            }
            else if ([img isKindOfClass:[NSString class]]) {
                if ([((NSString *)(img)) YLT_CheckString]) {
                    [self setImageForState:state withURL:[NSURL URLWithString:img]];
                }
                else {
                    [self setImage:[UIImage YLT_ImageNamed:img] forState:state];
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
- (UIButton *(^)(NSString *title, UIControlState state))YLT_StateTitle {
    return ^id(NSString *title, UIControlState state) {
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitle:title forState:state];
        }
        return self;
    };
}
/**
 高亮Color
 */
- (UIButton *(^)(UIColor *color, UIControlState state))YLT_StateColor {
    return ^id(UIColor *color, UIControlState state) {
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitleColor:color forState:state];
        }
        return self;
    };
}

/**
 设置按钮的状态
 */
- (UIButton *(^)(UIControlState state))YLT_State {
    return ^id(UIControlState state) {
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
- (UIButton *(^)(YLT_ButtonLayout layout))YLT_Layout {
    return ^id(YLT_ButtonLayout layout) {
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
- (UIButton *(^)(void(^)(UIButton *response)))YLT_ButtonClickBlock {
    return ^id(void(^clickBlock)(UIButton *response)) {
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (clickBlock) {
                clickBlock(x);
            }
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
+ (UIButton *)YLT_CreateSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            image:(id)image
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .YLT_Layout(superView, layout)
    .YLT_ConvertToButton()
    .YLT_NormarlImage(image)
    .YLT_ClickBlock(clickBlock);
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
+ (UIButton *)YLT_CreateSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            title:(NSString *)title
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .YLT_Layout(superView, layout)
    .YLT_ConvertToButton()
    .YLT_NormalTitle(title)
    .YLT_NormalColor([@"0x515151" YLT_ColorFromHexString])
    .YLT_ClickBlock(clickBlock);

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
+ (UIButton *)YLT_CreateSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            image:(id)image
                            title:(NSString *)title
                     buttonLayout:(YLT_ButtonLayout)buttonLayout
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .YLT_Layout(superView, layout)
    .YLT_ConvertToButton()
    .YLT_NormalTitle(title)
    .YLT_NormarlImage(image)
    .YLT_NormalColor([@"0x515151" YLT_ColorFromHexString])
    .YLT_Layout(buttonLayout)
    .YLT_ClickBlock(clickBlock);
    
    return result;
}


@end
#pragma clang diagnostic pop
