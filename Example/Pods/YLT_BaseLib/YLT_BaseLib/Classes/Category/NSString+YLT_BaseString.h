//
//  NSString+YLT.h
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YLT_BaseString)

/**
 验证邮箱的有效性

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckEmail;

/**
 验证字符串的有效性

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckString;

/**
 验证手机号的有效性

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckTelphone;

/**
 验证密码的有效性 （6-18位数字和字母的组合    ）

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckPassword;

/**
 验证用户名的有效性（20位的中文或英文）

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckUsername;

/**
 验证身份证号码的有效性 （15或18位）

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckIDCard;

/**
 验证URL的有效性

 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckURL;

/**
 验证iOS目录结果的本地路径

 @return 有效性 YES:本地路径 NO:非本地路径
 */
- (BOOL)YLT_CheckLocalPath;

/**
 将当前字符串转化为颜色值

 @return 颜色值
 */
- (UIColor *)YLT_ColorFromHexString;

@end
