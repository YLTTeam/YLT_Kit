//
//  YLT_ImageFilter.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/12.
//

#import "YLT_ImageFilter.h"
#import <CoreImage/CoreImage.h>

@interface YLT_ImageFilter () {
}
/**
 滤镜数据
 */
@property (nonatomic, strong) NSDictionary *filterDatas;
/**
 滤镜
 */
@property (nonatomic, strong) CIFilter *filter;

@end

@implementation YLT_ImageFilter

/**
 图片增加滤镜
 
 @param originImage 原图
 @param filterType 滤镜类型
 @param value 滤镜强度
 @return 增加滤镜的图片
 */
+ (UIImage *)filterImage:(UIImage *)originImage
              filterType:(YLT_ImageFilterType)filterType
                   value:(CGFloat)value {
    UIImage *result = originImage;
    YLT_ImageFilter *imageFilter = [[YLT_ImageFilter alloc] init];
    imageFilter.originImage = originImage;
    imageFilter.filterType = filterType;
    
    
    return result;
}

@end
