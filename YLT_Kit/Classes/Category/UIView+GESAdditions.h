//
//  UIView+GESAdditions.h
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  添加手势封装
 *  使用方法ges_手势类型(target,SEL)
 *  内部自动设置userInteractionEnabled = YES
 */
@interface UIView (GESAdditions)

/**
 *  添加点按手势
 */
- (UITapGestureRecognizer *(^)(id, SEL))ges_tap;
/**
 *  添加拖动手势
 */
- (UIPanGestureRecognizer *(^)(id, SEL))ges_pan;
/**
 *  添加捏合手势
 */
- (UIPinchGestureRecognizer *(^)(id, SEL))ges_pinch;
/**
 *  添加旋转手势
 */
- (UIRotationGestureRecognizer *(^)(id, SEL))ges_rotation;
/**
 *  添加长按手势
 */
- (UILongPressGestureRecognizer *(^)(id, SEL))ges_longPress;
/**
 *  添加轻扫手势
 */
- (UISwipeGestureRecognizer *(^)(id, SEL))ges_swipe;

/**
 *  添加手势
 *
 *  @param cls 系统自带或者自定义手势Class
 */
- (id(^)(id, SEL))ges_add:(Class)cls;

/**
 *  移除手势，参数可以是手势实例对象或者手势Class
 */
- (void(^)(id))ges_remove;

/**
 *  移除所有已添加的手势
 */
- (void (^)(void))ges_removeAll;

@end
