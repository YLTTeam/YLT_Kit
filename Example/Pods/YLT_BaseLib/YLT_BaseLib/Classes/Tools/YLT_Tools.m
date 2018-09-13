//
//  YLT_Tools.m
//  BlackCard
//
//  Created by 项普华 on 2018/4/8.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "YLT_Tools.h"
#import <MJExtension/MJExtension.h>
#import <LGAlertView/LGAlertView.h>
#import "NSString+YLT_Extension.h"

@implementation YLT_Tools

/**
 Data 转为DeviceToken
 
 @param data data
 @return DeviceToken字串
 */
+ (NSString *)ylt_deviceTokenFromData:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *deviceTokenInString = [token stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    return  deviceTokenInString;
}

/**
 json字串转字典
 
 @param jsonString 字串
 @return 结果
 */
+ (NSDictionary *)ylt_dictionaryFromString:(NSString *)jsonString {
    if ([NSString ylt_isBlankString:jsonString]) {
        return nil;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonString.mj_JSONData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        return nil;
    }
    return dic;
}

/**
 显示跳转设置提示
 
 @param title 标题
 */
+ (void)ylt_showSettingTitle:(NSString *)title {
    [[LGAlertView alertViewWithTitle:@"提示" message:title style:LGAlertViewStyleAlert buttonTitles:(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)?@[@"设置"]:nil cancelButtonTitle:@"好的" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } cancelHandler:nil destructiveHandler:^(LGAlertView * _Nonnull alertView) {}] show];
}


/**
 生成6位随机码 （数字和英文）
 
 @return 随机码
 */
+ (NSString *)ylt_makeCode {
    return [self ylt_makeCodeIsNumber:NO length:6];
}

/**
 生成随机码
 
 @param isNumber 是否是纯数字
 @param length 长度
 @return 随机码
 */
+ (NSString *)ylt_makeCodeIsNumber:(BOOL)isNumber length:(NSInteger)length {
    NSInteger ver = 0;
    if (isNumber) {
        for (int i = 0; i < length; i++) {
            ver = ver*10 + arc4random()%10;
        }
        return [NSString stringWithFormat:@"%06li", (long)ver];
    } else {
        char data[length];
        for (int x=0;x<length;data[x++] = (char)('A' + (arc4random_uniform(26))));
        return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
    }
    return @"";
}

@end
