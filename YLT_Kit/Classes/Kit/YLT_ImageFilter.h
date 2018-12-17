//
//  YLT_ImageFilter.h
//  AFNetworking
//
//  Created by 项普华 on 2018/12/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YLT_ImageFilterType) {
    
    YLT_ImageFilterTypeCount
};

@interface YLT_ImageFilter : NSObject
/**
 原图
 */
@property (nonatomic, strong) UIImage *originImage;
/**
 滤镜类型
 */
@property (nonatomic, assign) YLT_ImageFilterType filterType;
/**
 滤镜强度 0~1
 */
@property (nonatomic, assign) CGFloat filterValue;
/**
 滤镜强度2 0 ~ 1
 */
@property (nonatomic, assign) CGFloat filterValue2;

/**
 图片增加滤镜

 @param originImage 原图
 @param filterType 滤镜类型
 @param value 滤镜强度
 @return 增加滤镜的图片
 */
+ (UIImage *)filterImage:(UIImage *)originImage
              filterType:(YLT_ImageFilterType)filterType
                   value:(CGFloat)value value2:(CGFloat)value2;

@end
