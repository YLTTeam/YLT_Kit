//
//  YLT_BaseMacro.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/25.
//

#ifndef YLT_BaseMacro_h
#define YLT_BaseMacro_h

#import "NSObject+YLT_BaseObject.h"
/// iOS设备信息
#define iPad [NSObject YLT_DeviceIsiPad]
#define iPhone [NSObject YLT_DeviceIsiPhone]

//屏幕信息
#define iPhone_3_5 ([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==480)
#define iPhone_4 ([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==568)
#define iPhone_4_7 ([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==667)
#define iPhone_5_5 ([UIScreen mainScreen].bounds.size.width==414&&[UIScreen mainScreen].bounds.size.height==736)
#define iPhone_x ([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==812)

// iOS系统信息
#define YLT_iOS_VERSION [[UIDevice currentDevice] systemVersion]

#define iOS7 ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 8.0)
#define iOS7Later ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0)

#define iOS8 ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 9.0)
#define iOS8Later ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)

#define iOS9 ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 10.0)
#define iOS9Later ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)

#define iOS10 ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 11.0)
#define iOS10Later ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0)

#define iOS11 ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0 && [[UIDevice currentDevice] systemVersion].floatValue <= 12.0)
#define iOS11Later ([[UIDevice currentDevice] systemVersion].floatValue >= 11.0)

#define iOSNew ([[UIDevice currentDevice] systemVersion].floatValue >= 12.0)

//获取系统对象
#define YLT_Application        [UIApplication sharedApplication]
#define YLT_AppWindow          [UIApplication sharedApplication].keyWindow
#define YLT_AppDelegate        (AppDelegate *)[UIApplication sharedApplication].delegate
#define YLT_RootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define YLT_UserDefaults       [NSUserDefaults standardUserDefaults]
#define YLT_NotificationCenter [NSNotificationCenter defaultCenter]
//获取屏幕宽高
#define YLT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define YLT_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define YLT_SCREEN_BOUNDS [UIScreen mainScreen].bounds

// iOS沙盒目录
#define YLT_DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define YLT_CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#if DEBUG
//输出日志信息
#define YLT_LogAll(type,format,...) NSLog(@"%@ %s+%d " format,type,__func__,__LINE__,##__VA_ARGS__)
#define YLT_Log(format,...) YLT_LogAll(@"",format,##__VA_ARGS__)
#define YLT_LogInfo(format,...) YLT_LogAll(@"",format,##__VA_ARGS__)
#define YLT_LogWarn(format,...) YLT_LogAll(@"‼️",format,##__VA_ARGS__)
#define YLT_LogError(format,...) YLT_LogAll(@"❌❌",format,##__VA_ARGS__)
#else
#define YLT_Log(format,...)
#define YLT_LogInfo(format,...)
#define YLT_LogWarn(format,...)
#define YLT_LogError(format,...)
#define YLT_Log(format,...)
#endif

//当前语言
#define YLT_CurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]
//info.plist 文件信息
#define YLT_InfoDictionary [[NSBundle mainBundle] infoDictionary]
//当前应用程序的 bundle ID
#define YLT_BundleIdentifier [[NSBundle mainBundle] bundleIdentifier]
// app名称
#define YLT_AppName [YLT_InfoDictionary objectForKey:@"CFBundleDisplayName"]
//将URLTypes 中的第一个当做当前的回调参数
#define YLT_URL_SCHEME [[YLT_InfoDictionary[@"CFBundleURLTypes"] firstObject][@"CFBundleURLSchemes"] firstObject]
// app版本
#define YLT_AppVersion [YLT_InfoDictionary objectForKey:@"CFBundleShortVersionString"]
// app build版本
#define YLT_BuildVersion [YLT_InfoDictionary objectForKey:@"CFBundleVersion"]
// iPhone 别名
#define YLT_PhoneName [[UIDevice currentDevice] name]
//当前Bundle
#define YLT_CurrentBundle [NSBundle bundleForClass:[self class]]
//主bundle
#define YLT_MainBundle [NSBundle mainBundle]

#define YLT_WEAKSELF [self YLT_WeakSelf]

//颜色宏定义
#define YLT_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define YLT_RGB(r,g,b) RGBA(r,g,b,1.0f)
#define YLT_HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define YLT_HEXCOLORA(hex, alpha) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha]
#define YLT_StringColor(color) [color YLT_ColorFromHexString]
#define YLT_StringValue(str) [str YLT_CheckString]?str:@""


//快速生成单例对象
#define YLT_ShareInstanceHeader(cls)    + (cls *)shareInstance;
#define YLT_ShareInstance(cls)          static cls *share_cls = nil;\
                                        + (cls *)shareInstance {\
                                            static dispatch_once_t onceToken;\
                                            dispatch_once(&onceToken, ^{\
                                            share_cls = [[cls alloc] init];\
                                                if ([share_cls respondsToSelector:@selector(YLT_init)]) {\
                                                    [share_cls performSelector:@selector(YLT_init) withObject:nil];\
                                                    }\
                                                });\
                                                return share_cls;\
                                            }\
                                            + (instancetype)allocWithZone:(struct _NSZone *)zone {\
                                                if (share_cls == nil) {\
                                                    static dispatch_once_t onceToken;\
                                                    dispatch_once(&onceToken, ^{\
                                                        share_cls = [super allocWithZone:zone];\
                                                        if ([share_cls respondsToSelector:@selector(YLT_init)]) {\
                                                            [share_cls performSelector:@selector(YLT_init) withObject:nil];\
                                                        }\
                                                    });\
                                                }\
                                                return share_cls;\
                                            }
//懒加载宏定义
#define YLT_Lazy(cls, sel, _sel) \
                                    - (cls *)sel {\
                                        if (!_sel) {\
                                            _sel = [[cls alloc] init];\
                                        }\
                                        return _sel;\
                                    }

#define YLT_LazyCategory(cls, fun) - (cls *)fun {\
                                        cls *result = objc_getAssociatedObject(self, @selector(fun));\
                                        if (result == nil) {\
                                            result = [[cls alloc] init];\
                                            objc_setAssociatedObject(self, @selector(fun), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
                                        }\
                                        return result;\
                                    }



#endif /* YLT_BaseMacro_h */
