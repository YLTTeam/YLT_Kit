//
//  NSString+YLT.m
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import "NSString+YLT_BaseString.h"

@implementation NSString (YLT_BaseString)

/**
 验证邮箱的有效性
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckEmail {
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [pred evaluateWithObject:self];
}

/**
 验证字符串的有效性
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckString {
    if (self == nil || self == NULL) {
        return NO;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return NO;
    }
    return YES;
}

/**
 验证手机号的有效性
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckTelphone {
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 验证密码的有效性 （6-18位数字和字母的组合    ）
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckPassword {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 验证用户名的有效性（20位的中文或英文）
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckUsername {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:self];
}

/**
 验证身份证号码的有效性 （15或18位）
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckIDCard {
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 验证URL的有效性
 
 @return 有效性 YES:有效 NO:无效
 */
- (BOOL)YLT_CheckURL {
    NSString *pattern = @"^(http||https)://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 验证iOS目录结果的本地路径
 
 @return 有效性 YES:本地路径 NO:非本地路径
 */
- (BOOL)YLT_CheckLocalPath {
    NSString *pattern = @"/var/mobile/Applications/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 将当前字符串转化为颜色值
 
 @return 颜色值
 */
- (UIColor *)YLT_ColorFromHexString {
    NSString *resultString = self;
    //删除字符串中的空格
    resultString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([resultString hasPrefix:@"0X"]) {
        resultString = [resultString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([resultString hasPrefix:@"#"]) {
        resultString = [resultString substringFromIndex:1];
    }
    
    if (resultString.length != 3 && resultString.length != 4 && resultString.length != 6 && resultString.length != 8) {
        return [UIColor clearColor];
    }
    
    if (resultString.length == 3 || resultString.length == 4) {
        NSRange range;
        range.location = 0;
        range.length = 1;
        NSString *r = [resultString substringWithRange:range];
        range.location = 1;
        NSString *g = [resultString substringWithRange:range];
        range.location = 2;
        NSString *b = [resultString substringWithRange:range];
        NSString *a = @"FF";
        if (resultString.length == 4) {
            range.location = 3;
            a = [resultString substringWithRange:range];
        }
        
        resultString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", r, r, g, g, b, b, a, a];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [resultString substringWithRange:range];
    range.location = 2;
    NSString *gString = [resultString substringWithRange:range];
    range.location = 4;
    NSString *bString = [resultString substringWithRange:range];
    
    NSString *aString = @"FF";
    if ([resultString length] == 8) {
        range.location = 6;
        aString = [resultString substringWithRange:range];
    }
    
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
}

@end
