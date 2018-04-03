//
//  UIView+YLT_BaseView.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/16.
//

#import "UIView+YLT_BaseView.h"

@implementation UIView (YLT_BaseView)

- (void)setYLT_x:(CGFloat)x {
    self.frame = CGRectMake(x, self.YLT_y, self.YLT_width, self.YLT_height);
}

- (CGFloat)YLT_x {
    return self.frame.origin.x;
}

- (void)setYLT_y:(CGFloat)y {
    self.frame = CGRectMake(self.YLT_x, y, self.YLT_width, self.YLT_height);
}

- (CGFloat)YLT_y {
    return self.frame.origin.y;
}

- (void)setYLT_width:(CGFloat)width {
    self.frame = CGRectMake(self.YLT_x, self.YLT_y, width, self.YLT_height);
}

- (CGFloat)YLT_width {
    return self.frame.size.width;
}

- (void)setYLT_height:(CGFloat)height {
    self.frame = CGRectMake(self.YLT_x, self.YLT_y, self.YLT_width, height);
}

- (CGFloat)YLT_height {
    return self.frame.size.height;
}

- (CGFloat)YLT_centerX {
    return (self.YLT_x+self.YLT_width)/2.;
}

- (CGFloat)YLT_centerY {
    return (self.YLT_y+self.YLT_height)/2.;
}


@end
