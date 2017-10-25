//
//  YLT_BaseVC.h
//  YLT_Kit
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <UIKit/UIKit.h>
#import "YLT_BaseVCProtocol.h"

@interface YLT_BaseVC : UIViewController <YLT_BaseVCProtocol>

/**
 上一个页面传入的参数
 */
@property (nonatomic, strong) id ylt_params;

/**
 页面回调
 */
@property (nonatomic, copy) void(^ylt_callback)(id response);

@end
