//
//  UIImage+YLT_HSV.h
//  Pods
//
//  Created by YLT_Alex on 2017/12/13.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLT_HSV)

/**
 改变图片的显示色调、明暗等
 
 @param hue 色调   用角度度量，取值范围为 0～255
 @param saturation 饱和度  取值范围为 0～1 值越大，颜色越饱和
 @param bright 透明度  通常取值范围为  0（黑）到 1（白）
 @return 改变后的图片
 */
- (UIImage *)YLT_ImageWithHue:(CGFloat)hue saturation:(CGFloat)saturation bright:(CGFloat)bright;

@end
