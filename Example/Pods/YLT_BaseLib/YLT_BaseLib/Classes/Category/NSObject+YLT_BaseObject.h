//
//  NSObject+YLT_BaseObject.h
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

@interface NSObject (YLT_BaseObject)

/**
 判断当前设备是否是iPad

 @return 是否是iPad YES:是 NO:不是
 */
- (BOOL)YLT_DeviceIsiPad;

/**
 判断当前设备是否是iPhone
 
 @return 是否是iPhone YES:是 NO:不是
 */
- (BOOL)YLT_DeviceIsiPhone;

/**
 设备名称

 @return 设备名称
 */
- (NSString *)YLT_DeviceName;

/**
 获取当前的控制器

 @return 当前控制器
 */
- (UIViewController *)YLT_CurrentVC;

/**
 生成6位随机码 （数字和英文）

 @return 随机码
 */
- (NSString *)YLT_MakeCode;

/**
 生成随机码

 @param isNumber 是否是纯数字
 @param length 长度
 @return 随机码
 */
- (NSString *)YLT_MakeCodeIsNumber:(BOOL)isNumber length:(NSInteger)length;

/**
 方法交换

 @param theClass 方法交换的类
 @param originalSel 原始方法
 @param replaceSel 替换的方法
 */
- (void)YLT_SwizzleSelectorInClass:(Class)theClass originalSel:(SEL)originalSel replaceSel:(SEL)replaceSel;


@end
