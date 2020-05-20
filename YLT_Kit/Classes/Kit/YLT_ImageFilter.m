//
//  YLT_ImageFilter.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/12.
//

#import "YLT_ImageFilter.h"
#import <CoreImage/CoreImage.h>
#import <ReactiveObjC/ReactiveObjC.h>

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

@property (nonatomic, copy) void(^completion)(UIImage *outputImage);

@end

@implementation YLT_ImageFilter

/**
 图片增加滤镜
 
 @param originImage 原图
 @param filterType 滤镜类型
 @param value 滤镜强度
 @param value2 滤镜强度2
 @param completion 回调
 @return 实例
 */
+ (YLT_ImageFilter *)filterImage:(UIImage *)originImage
                      filterType:(YLT_ImageFilterType)filterType
                           value:(CGFloat)value
                          value2:(CGFloat)value2
                      completion:(void(^)(UIImage *outputImage))completion {
    YLT_ImageFilter *imageFilter = [[YLT_ImageFilter alloc] init];
    imageFilter.completion = completion;
    imageFilter.originImage = originImage;
    imageFilter.filterType = filterType;
    imageFilter.filterValue = value;
    imageFilter.filterValue2 = value2;
    @weakify(imageFilter);
    [[RACObserve(imageFilter, outputImage) takeUntil:imageFilter.rac_willDeallocSignal] subscribeNext:^(UIImage *x) {
        @strongify(imageFilter);
        if (imageFilter.completion) {
            imageFilter.completion(x);
        }
    }];
    
    return imageFilter;
}

- (NSString *)filternameFromType:(YLT_ImageFilterType)type {
    switch (type) {
        case YLT_ImageFilterTypeTemperatureAndTint: {
            return @"CITemperatureAndTint";
        }
            break;
            
        default:
            break;
    }
    return @"";
}

- (void)setFilterValue:(CGFloat)filterValue {
    _filterValue = filterValue;
    CGFloat value = (filterValue+100.)/200.;
    switch (self.filterType) {
        case YLT_ImageFilterTypeTemperatureAndTint: {
            [self.filter setValue:[[CIVector alloc] initWithX:6200 Y:0] forKey:@"inputNeutral"];
            [self.filter setValue:[[CIVector alloc] initWithX:6200 Y:value*4.0*100] forKey:@"inputTargetNeutral"];
        }
            break;
            
        default:
            break;
    }
    CIImage *outputImage = [self.filter outputImage];
    self.outputImage = [UIImage imageWithCIImage:outputImage];
}

- (void)setFilterValue2:(CGFloat)filterValue2 {
    _filterValue2 = filterValue2;
    CGFloat value = (filterValue2+100.)/200.;
    switch (self.filterType) {
        case YLT_ImageFilterTypeTemperatureAndTint: {
        }
            break;
            
        default:
            break;
    }
    CIImage *outputImage = [self.filter outputImage];
    self.outputImage = [UIImage imageWithCIImage:outputImage];
}

- (void)setFilterType:(YLT_ImageFilterType)filterType {
    _filterType = filterType;
    NSString *filtername = [self filternameFromType:filterType];
    if (!(self.filter && [self.filter.name isEqualToString:filtername])) {
        self.filter = [CIFilter filterWithName:filtername];
        [self.filter setDefaults];
        [self.filter setValue:[[CIImage alloc] initWithImage:self.originImage] forKey:kCIInputImageKey];
    }
}

/** 通过字符串，宽度创建二维码 */
+ (UIImage *)createImageFromString:(NSString *)string width:(CGFloat)size {
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
