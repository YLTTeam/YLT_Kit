//
//  UIImageView+YLT_Create.m
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIImageView+YLT_Create.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import "UIImage+YLT_Utils.h"
#import "UIView+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIImageView (YLT_Create)

/**
 设置image
 */
- (UIImageView *(^)(id))YLT_Image {
    @weakify(self);
    return ^id(id image) {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:image];
            }
            else if ([image isKindOfClass:[NSURL class]]) {
                [self setImageWithURL:(NSURL *)image];
            }
            else if ([image isKindOfClass:[NSString class]]) {
                
                if ([((NSString *)image) YLT_CheckURL]) {
                    [self setImageWithURL:[NSURL URLWithString:(NSString *)image]];
                }
                else {
                    [self setImage:[UIImage YLT_ImageNamed:(NSString *)image]];
                }
            }
        }
        return self;
    };
}

/**
 圆形图片
 */
- (UIImageView *(^)(id image))YLT_CirleImage {
    @weakify(self);
    return ^id(id image) {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:[image YLT_DrawCircleImage]];
            }
            else if ([image isKindOfClass:[NSURL class]]) {
                [self sd_setImageWithURL:(NSURL *)image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    @strongify(self);
                    [self setImage:[image YLT_DrawCircleImage]];
                }];
            }
            else if ([image isKindOfClass:[NSString class]]) {
                if ([((NSString *)image) YLT_CheckURL]) {
                    [self sd_setImageWithURL:(NSURL *)[NSURL URLWithString:(NSString *)image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        @strongify(self);
                        [self setImage:[image YLT_DrawCircleImage]];
                    }];
                }
                else {
                    [self setImage:[[UIImage YLT_ImageNamed:(NSString *)image] YLT_DrawCircleImage]];
                }
            }
        }
        return self;
    };
}

/**
 圆角图片
 */
- (UIImageView *(^)(id image, CGFloat radius))YLT_RectImage {
    @weakify(self);
    return ^id(id image, CGFloat radius) {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:[image YLT_DrawRectImage:radius]];
            }
            else if ([image isKindOfClass:[NSURL class]]) {
                [self sd_setImageWithURL:(NSURL *)image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    [self setImage:[image YLT_DrawRectImage:radius]];
                }];
            }
            else if ([image isKindOfClass:[NSString class]]) {
                if ([((NSString *)image) YLT_CheckURL]) {
                    [self sd_setImageWithURL:(NSURL *)[NSURL URLWithString:(NSString *)image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        [self setImage:[image YLT_DrawRectImage:radius]];
                    }];
                }
                else {
                    [self setImage:[[UIImage YLT_ImageNamed:(NSString *)image] YLT_DrawRectImage:radius]];
                }
            }
        }
        return self;
    };
}

/**
 设置显示方式
 */
- (UIImageView *(^)(UIViewContentMode contentMode))YLT_ContentMode {
    @weakify(self);
    return ^id(UIViewContentMode contentMode) {
        @strongify(self);
        self.contentMode = contentMode;
        return self;
    };
}



#pragma mark - 快速创建对象

/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局约束
 @param image image
 @param contentMode contentMode
 @return 当前对象
 */
+ (UIImageView *)YLT_CreateSuperView:(UIView *)superView
                              layout:(void(^)(MASConstraintMaker *make))layout
                               image:(id)image
                         contentMode:(UIViewContentMode)contentMode {
    UIImageView *result = UIImageView
    .YLT_Layout(superView, layout)
    .YLT_ConvertToImageView()
    .YLT_Image(image)
    .YLT_ContentMode(contentMode);
    return result;
}

@end
