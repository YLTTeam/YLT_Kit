//
//  UIImage+YLT_Extension.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLT_Extension)

/**
 改变图片的显示色调、明暗等
 
 @param hue 色调   用角度度量，取值范围为 0～255
 @param saturation 饱和度  取值范围为 0～1 值越大，颜色越饱和
 @param bright 透明度  通常取值范围为  0（黑）到 1（白）
 @return 改变后的图片
 */
- (UIImage *)ylt_imageWithHue:(CGFloat)hue saturation:(CGFloat)saturation bright:(CGFloat)bright;

/**
 通过颜色获取纯色的图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)ylt_imageFromColor:(UIColor *)color;
/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)ylt_imageNamed:(NSString *)imageName;

/**
 绘制圆角图片

 @return 圆形图片
 */
- (UIImage *)ylt_drawCircleImage;

/**
 绘制圆角

 @param radius 圆角
 @return 圆角图
 */
- (UIImage *)ylt_drawRectImage:(CGFloat)radius;


@end
