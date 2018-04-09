//
//  UIView+YLT_BaseView.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/16.
//

#import "UIView+YLT_BaseView.h"

@implementation UIView (YLT_BaseView)

@dynamic ylt_centerX;
@dynamic ylt_centerY;

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
    return (self.ylt_x+self.ylt_width)/2.;
}

- (CGFloat)ylt_centerY {
    return (self.ylt_y+self.ylt_height)/2.;
}


@end
