//
//  UIImage+YLT_Utils.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIImage+YLT_Utils.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation UIImage (YLT_Utils)

/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)YLT_ImageNamed:(NSString *)imageName {
    UIImage *result = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    if (result == nil) {
        NSArray *array = [imageName componentsSeparatedByString:@"/"];
        NSString *bundleName = nil;
        NSString *type = @"png";
        NSString *name = imageName;
        NSMutableString *dir = nil;
        if (array.count == 1) {
            result = [UIImage imageNamed:imageName];
        } else if (array.count > 1) {
            for (NSString *path in array) {
                if ([path hasPrefix:@".bundle"]) {
                    bundleName = path;
                } else if ([path rangeOfString:@"."].location != NSNotFound) {
                    NSArray *nameList = [path componentsSeparatedByString:@"."];
                    name = nameList[0];
                    if ([name hasSuffix:@"@2x"]) {
                        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
                    }
                    if ([name hasSuffix:@"@3x"]) {
                        name = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
                    }
                    type = nameList[1];
                } else {
                    if (dir == nil) {
                        dir = [[NSMutableString alloc] init];
                    }
                    [dir appendFormat:@"%@/", path];
                }
            }
            
            result = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForAuxiliaryExecutable:[NSString stringWithFormat:@"%@.bundle", bundleName]]]?:[NSBundle bundleForClass:[self class]] pathForResource:name ofType:type?:@"png" inDirectory:dir]];
        }
    }
    
    return result;
}

/**
 绘制圆角图片
 
 @return 圆角图片
 */
- (UIImage *)YLT_DrawCircleImage {
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.size.width/2., self.size.height/2.) radius:(self.size.width>=self.size.height)?self.size.height/2.:self.size.width/2. startAngle:0 endAngle:M_PI*2. clockwise:YES] addClip];
    [self drawInRect:bounds];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

/**
 绘制圆角
 
 @param radius 圆角
 @return 圆角图
 */
- (UIImage *)YLT_DrawRectImage:(CGFloat)radius {
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius] addClip];
    [self drawInRect:bounds];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}


@end
