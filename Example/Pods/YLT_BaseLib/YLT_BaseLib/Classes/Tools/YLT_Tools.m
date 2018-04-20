//
//  YLT_Tools.m
//  BlackCard
//
//  Created by 项普华 on 2018/4/8.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "YLT_Tools.h"
#import <MJExtension/MJExtension.h>
#import <RMUniversalAlert/RMUniversalAlert.h>

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
    [RMUniversalAlert showAlertInViewController:self.ylt_currentVC withTitle:@"提示" message:title cancelButtonTitle:@"好的" destructiveButtonTitle:nil otherButtonTitles:(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)?@[@"设置"]:nil tapBlock:^(RMUniversalAlert * _Nonnull alert, NSInteger buttonIndex) {
        if (buttonIndex != 0) {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
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
