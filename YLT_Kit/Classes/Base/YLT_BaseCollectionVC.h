//
//  YLT_BaseCollectionVC.h
//  AFNetworking
//
//  Created by 项普华 on 2018/4/20.
//

#import <UIKit/UIKit.h>
#import "YLT_BaseView.h"

@interface YLT_BaseCollectionVC : UITableViewController

/**
 上一个页面传入的参数
 */
@property (nonatomic, strong) id ylt_params;

/**
 页面回调
 */
@property (nonatomic, copy) void(^ylt_callback)(id response);

@end
