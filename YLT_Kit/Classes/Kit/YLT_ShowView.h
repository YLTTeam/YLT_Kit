//
//  YLT_ShowView.h
//  YLT_Kit
//
//  Created by 項普華 on 2020/8/30.
//

#import <YLT_Kit/YLT_Kit.h>

@interface YLT_ShowView : YLT_BaseView

/** 是否展示 */
@property (nonatomic, assign, class) BOOL ylt_isShowing;

+ (void)showContentView:(UIView *)contentView;

+ (void)showContentView:(UIView *)contentView bgColor:(UIColor *)bgColor;

/**
 * @brief 显示弹窗
 * @param bgColor 弹窗的背景色
 * @param clearOther 是否清除其他
 * @param autoDismiss 点击背景是否隐藏
 * @param callback 消失的回调
 */
+ (void)showContentView:(UIView *)contentView bgColor:(UIColor *)bgColor autoDismiss:(BOOL)autoDismiss callback:(void(^)(id sender))callback;

@end
