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

@implementation UIImageView (YLT_Create)

/**
 设置image
 */
- (UIImageView *(^)(id))YLT_Image {
    return ^id(id image) {
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:image];
            }
            else if ([image isKindOfClass:[NSURL class]]) {
                [self setImageWithURL:(NSURL *)image];
            }
            else if ([image isKindOfClass:[NSString class]]) {
                
                if ([((NSString *)image) YLT_CheckString]) {
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
 设置显示方式
 */
- (UIImageView *(^)(UIViewContentMode contentMode))YLT_ContentMode {
    return ^id(UIViewContentMode contentMode) {
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
