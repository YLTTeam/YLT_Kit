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
    
    return result;
}


@end
