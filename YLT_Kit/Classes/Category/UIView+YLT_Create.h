//
//  UIView+YLT_Create.h
//  YLT_Kit
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIView (YLT_Create)

+ (UIView *(^)(void))YLT_Create;
/**
 视图的创建
 */
+ (UIView *(^)(UIView *superView, void (^)(MASConstraintMaker *make)))YLT_Layout;
/**
 视图的创建frame
 */
+ (UIView *(^)(UIView *superView, CGRect frame))YLT_Frame;
/**
 设置视图上的数据显示
 */
- (UIView *(^)(id data))YLT_Data;
/**
 设置背景颜色
 */
- (UIView *(^)(UIColor *bgColor))YLT_BackgroundColor;
/**
 设置圆角
 */
- (UIView *(^)(NSInteger radius))YLT_Radius;
/**
 设置边框颜色
 */
- (UIView *(^)(UIColor *borderColor))YLT_BorderColor;
/**
 设置边框宽度
 */
- (UIView *(^)(CGFloat borderWidth))YLT_BorderWidth;
/**
 设置阴影颜色
 */
- (UIView *(^)(UIColor *shadowColor))YLT_ShadowColor;
/**
 设置阴影的大小
 */
- (UIView *(^)(CGSize shadowOffset))YLT_ShadowSize;
/**
 设置阴影模糊度
 */
- (UIView *(^)(CGFloat blur))YLT_Blur;
/**
 设置tag
 */
- (UIView *(^)(NSInteger tag))YLT_Tag;
/**
 点击事件
 */
- (UIView *(^)(void (^)(id response)))YLT_ClickBlock;



#pragma mark - type convert
- (UIButton *(^)(void))YLT_ConvertToButton;
- (UILabel *(^)(void))YLT_ConvertToLabel;
- (UIImageView *(^)(void))YLT_ConvertToImageView;
- (UITableView *(^)(void))YLT_ConvertToTableView;
- (UITextField *(^)(void))YLT_ConvertToTextField;


#pragma mark - normal method

/**
 获取当前对象

 @return 当前对象
 */
- (id)YLT_Self;
/**
 获取当前视图的中心点
 
 @return 中心点
 */
- (CGPoint)YLT_Selfcenter;
/**
 获取当前view绑定的data
 
 @return data
 */
- (id)data;





@end
