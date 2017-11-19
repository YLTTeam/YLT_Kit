//
//  YLT_BaseVC.m
//  YLT_Kit
//
//  Created by YLT_Alex on 2017/10/25.
//

#import "YLT_BaseVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface YLT_BaseVC ()

@end

@implementation YLT_BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 往下一个页面传输数据和回调
 
 @param data 数据
 @param callback 回调
 */
- (void)YLT_nextData:(id)data callback:(void(^)(id response))callback {
    self.ylt_params = data;
    self.ylt_callback = callback;
}

/**
 从下级页面返回当前页面的调用
 
 @param response 返回的数据
 */
- (void)YLT_nextPageResponse:(id)response {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    YLT_BaseVC *vc = segue.destinationViewController;
    @weakify(self);
    if ([vc respondsToSelector:@selector(YLT_nextData:callback:)]) {
        [vc YLT_nextData:sender callback:^(id data) {
            @strongify(self);
            [self YLT_nextPageResponse:data];
        }];
    }
}

- (void)dealloc {
    YLT_LogWarn(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
