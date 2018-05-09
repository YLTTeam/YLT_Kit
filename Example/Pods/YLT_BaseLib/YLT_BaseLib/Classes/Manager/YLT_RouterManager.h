//
//  YLT_RouterManager.h
//  FastCoding
//
//  Created by Sean on 2018/4/28.
//

#import <Foundation/Foundation.h>

#define YLT_ROUTER_PREFIX @"ylt://"
//回调的KEY
#define YLT_ROUTER_COMPLETION @"YLT_ROUTER_COMPLETION"

@interface YLT_RouterManager : NSObject

/**
 路由

 @param routerURL 路由的URL 参数带到URL后面
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToURL:(NSString *)routerURL arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

/**
 路由

 @param clsname 路由到对应的classname
 @param selname 方法名对应的字串 后面可以带参数
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToClassname:(NSString *)clsname selname:(NSString *)selname arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

@end
