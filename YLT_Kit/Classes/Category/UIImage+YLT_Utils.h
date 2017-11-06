//
//  UIImage+YLT_Utils.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLT_Utils)

/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)YLT_ImageNamed:(NSString *)imageName;

/**
 绘制圆角图片

 @return 圆角图片
 */
- (UIImage *)YLT_DrawCircleImage;

@end
