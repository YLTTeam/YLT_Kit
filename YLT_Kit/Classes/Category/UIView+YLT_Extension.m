//
//  UIView+YLT_Extension.m
//  AFNetworking
//
//  Created by 项普华 on 2018/4/13.
//

#import "UIView+YLT_Extension.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@interface UIView (YLT_EnlargeEdge)

@property (nonatomic, assign) UIEdgeInsets hitsEdgeInsets;

@end


@implementation UIView (YLT_Extension)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
static char touchButtonRangeKey;

/**
 view的标识
 */
+ (NSString *)ylt_identify {
    return NSStringFromClass(self);
}

- (void)ylt_shakeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.5;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)ylt_jitterAnimation {
    CAKeyframeAnimation *animationY = [CAKeyframeAnimation animation];
    animationY.keyPath = @"position.y";
    animationY.values = @[ @0, @5, @-5, @5, @0 ];
    animationY.keyTimes = @[ @0, @0.1, @0.3, @0.5, @1 ];
    animationY.duration = 0.5;
    animationY.additive = YES;
    [self.layer addAnimation:animationY forKey:@"shake"];
}

- (void)ylt_scaleAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.layer.anchorPoint = CGPointMake(.5,.5);
    animation.fromValue = @0.9f;
    animation.toValue = @1.10f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [animation setAutoreverses:NO];
    animation.duration = 0.3;
    [self.layer addAnimation:animation forKey:@"scale"];
}

- (void)ylt_clickableAfter:(NSTimeInterval)second {
    self.userInteractionEnabled = NO;
    NSTimeInterval delayInSeconds = second;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        YLT_MAIN(^{
            self.userInteractionEnabled = YES;
        });
    });
}

- (CAGradientLayer *)ylt_gradientLayerWithColors:(NSArray *)cgColorArray
                                       locations:(NSArray *)floatNumArray
                                      startPoint:(CGPoint )startPoint
                                        endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    } else {
        return nil;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
    
    return layer;
}

/**
 部分角生成圆角
 
 @param rectCorner 指定角
 @param radius 圆角率
 */
- (void)ylt_cornerType:(UIRectCorner)rectCorner radius:(NSUInteger)radius {
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)ylt_borderWidth:(CGFloat)width
           cornerRadius:(CGFloat)radius
            borderColor:(UIColor *)color{
    
    [self.layer setMasksToBounds:true];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

- (void)ylt_shadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

/**
 放大按钮点击范围
 
 @param top 向上扩展
 @param right 向右扩展
 @param bottom 向下扩展
 @param left 向左扩展
 */
- (void)ylt_enlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    return self.bounds;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
        if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES) {
            return nil;
        }
        
        // 如果 touch 的point 在 self 的bounds 内
        if ([self pointInside:point withEvent:event]) {
            for (UIView *subView in self.subviews) {
                //进行坐标转化
                CGPoint coverPoint = [subView convertPoint:point fromView:self];
                // 调用子视图的 hitTest 重复上面的步骤。找到了，返回hitTest view ,没找到返回有自身处理
                UIView *hitTestView = [subView hitTest:coverPoint withEvent:event];
                if (hitTestView) {
                    return hitTestView;
                }
            }
            return self;
        }
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

- (void)setHitsEdgeInsets:(UIEdgeInsets)hitsEdgeInsets {
    NSValue *value = [NSValue value:&hitsEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &touchButtonRangeKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitsEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &touchButtonRangeKey);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitsEdgeInsets, UIEdgeInsetsZero) || !self.userInteractionEnabled || self.hidden) {
        return NO;
    }
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitsEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end
