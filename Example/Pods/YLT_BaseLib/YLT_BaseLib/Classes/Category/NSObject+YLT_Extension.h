//
//  NSObject+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (YLT_Extension)

/**
 获取当前的控制器

 @return 当前控制器
 */
- (UIViewController *)ylt_currentVC;

/**
 方法交换 类方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 方法交换 实例方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 *  存储对象
 *
 *  @param key key
 */
- (void)ylt_storeValueWithKey:(NSString *)key;

/**
 *  获取对象
 *
 *  @param key key
 *
 *  @return 对象
 */
+ (id)ylt_valueByKey:(NSString *)key;

/**
 *  移除对象
 *
 *  @param key key
 */
+ (void)ylt_removeValueForKey:(NSString *)key;


@end
