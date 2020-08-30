//
//  YLT_ShowView.m
//  YLT_Kit
//
//  Created by 項普華 on 2020/8/30.
//

#import "YLT_ShowView.h"

@interface YLT_ShowView ()

/** 背景视图 */
@property (nonatomic, strong) UIImageView *bgImageView;
/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 回调 */
@property (nonatomic, copy) void(^callback)(id sender);

@end

@implementation YLT_ShowView

static BOOL _ylt_isShowing = NO;
+ (void)setYlt_isShowing:(BOOL)ylt_isShowing {
    _ylt_isShowing = _ylt_isShowing;
}
+ (BOOL)ylt_isShowing {
    return _ylt_isShowing;
}

+ (void)showContentView:(UIView *)contentView {
    [self showContentView:contentView bgColor:nil];
}

+ (void)showContentView:(UIView *)contentView bgColor:(UIColor *)bgColor {
    [self showContentView:contentView bgColor:bgColor autoDismiss:YES callback:nil];
}

/**
 * @brief 显示弹窗
 * @param bgColor 弹窗的背景色
 * @param autoDismiss 点击背景是否隐藏
 * @param callback 消失的回调
 */
+ (void)showContentView:(UIView *)contentView bgColor:(UIColor *)bgColor autoDismiss:(BOOL)autoDismiss callback:(void(^)(id sender))callback {
    YLT_Lock();
    if (YLT_ShowView.ylt_isShowing) {
        return;
    }
    YLT_ShowView.ylt_isShowing = YES;
    YLT_ShowView *show = [[YLT_ShowView alloc] init];
    @weakify(show);
    show.bgImageView = UIImageView.ylt_createLayout(show, ^(MASConstraintMaker *make) {
        make.edges.equalTo(show);
    }).ylt_backgroundColor(bgColor?:UIColor.blackColor)
    .ylt_convertToImageView();
    if (autoDismiss) {
        show.bgImageView.ylt_clickBlock(^(UIView *sender) {
            @strongify(show);
            [show dismiss];
        });
    }
    show.contentView = contentView;
    show.callback = callback;
    [show show];
    YLT_Unlock();
}

- (void)show {
    [YLT_AppWindow addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.bgImageView.alpha = 0.0;
    [self addSubview:self.contentView];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.contentView.ylt_height);
    }];
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.27 delay:0.0 options:(UIViewAnimationCurveLinear) animations:^{
        self.bgImageView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(self.contentView.ylt_height);
    }];
    [UIView animateWithDuration:0.2 delay:0.1 options:(UIViewAnimationCurveLinear) animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    YLT_ShowView.ylt_isShowing = NO;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.contentView.ylt_height);
    }];
    [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationCurveLinear) animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:0.27 delay:0.07 options:(UIViewAnimationCurveLinear) animations:^{
        self.bgImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
