//
//  UIView+YLT_BaseView.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/16.
//

#import "UIView+YLT_BaseView.h"

@implementation UIView (YLT_BaseView)

@dynamic ylt_top, ylt_bottom, ylt_left, ylt_right;

- (void)setYlt_x:(CGFloat)x {
    self.frame = CGRectMake(x, self.ylt_x, self.ylt_width, self.ylt_height);
}

- (CGFloat)ylt_x {
    return self.frame.origin.x;
}

- (void)setYlt_y:(CGFloat)y {
    self.frame = CGRectMake(self.ylt_x, y, self.ylt_width, self.ylt_height);
}

- (CGFloat)ylt_y {
    return self.frame.origin.y;
}

- (void)setYlt_width:(CGFloat)width {
    self.frame = CGRectMake(self.ylt_x, self.ylt_y, width, self.ylt_height);
}

- (CGFloat)ylt_width {
    return self.frame.size.width;
}

- (void)setYlt_height:(CGFloat)height {
    self.frame = CGRectMake(self.ylt_x, self.ylt_y, self.ylt_width, height);
}

- (CGFloat)ylt_height {
    return self.frame.size.height;
}

- (CGFloat)ylt_centerX {
    return self.ylt_x+self.ylt_width/2.;
}

- (void)setYlt_centerX:(CGFloat)ylt_centerX {
    self.center = CGPointMake(ylt_centerX, self.center.y);
}

- (CGFloat)ylt_centerY {
    return self.ylt_y+self.ylt_height/2.;
}

- (void)setYlt_centerY:(CGFloat)ylt_centerY {
    self.center = CGPointMake(self.center.x, ylt_centerY);
}

/**
 坐标 x, y点
 */
- (CGPoint)ylt_origin {
    return CGPointMake(self.ylt_x, self.ylt_y);
}

- (void)setYlt_origin:(CGPoint)ylt_origin {
    CGRect frame = self.frame;
    frame.origin = ylt_origin;
    self.frame = frame;
}

/**
 宽高 width, height
 */
- (CGSize)ylt_size {
    return CGSizeMake(self.ylt_width, self.ylt_height);
}

- (void)setYlt_size:(CGSize)ylt_size {
    CGRect frame = self.frame;
    frame.size = ylt_size;
    self.frame = frame;
}

/**
 视图的 顶点 min_y
 */
- (CGFloat)ylt_top {
    return self.ylt_y;
}

/**
 视图的 底点 max_y
 */
- (CGFloat)ylt_bottom {
    return (self.ylt_y+self.ylt_height);
}

/**
 视图的 左边 min_x
 */
- (CGFloat)ylt_left {
    return self.ylt_x;
}

/**
 视图的 右边 max_x
 */
- (CGFloat)ylt_right {
    return (self.ylt_x+self.ylt_width);
}

/**
 移除所有的子视图
 */
- (void)removeAllSubViews {
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}

/**
 移除指定的所有子视图

 @param className 子视图类名字符串
 */
- (void)removeAllSubviewsClass:(NSString *)className {
    if ([className length] == 0 || className == nil) {
        [self removeAllSubViews];
        return;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(className)]) {
            [view removeFromSuperview];
        }
    }
}

@end
