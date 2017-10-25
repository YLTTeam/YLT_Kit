//
//  YLT_BaseVCProtocol.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <Foundation/Foundation.h>

@protocol YLT_BaseVCProtocol <NSObject>

/**
 往下一个页面传输数据和回调

 @param data 数据
 @param callback 回调
 */
- (void)YLT_nextData:(id)data callback:(void(^)(id response))callback;

/**
 从下级页面返回当前页面的调用

 @param response 返回的数据
 */
- (void)YLT_nextPageResponse:(id)response;


@end
