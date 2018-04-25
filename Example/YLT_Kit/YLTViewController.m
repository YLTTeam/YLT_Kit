//
//  YLTViewController.m
//  YLT_Kit
//
//  Created by xphaijj0305@126.com on 10/25/2017.
//  Copyright (c) 2017 xphaijj0305@126.com. All rights reserved.
//

#import "YLTViewController.h"
#import <YLT_Kit/YLT_Kit.h>
#import "YLTTableViewCell.h"
#import <YLT_Kit/YLT_Kit.h>

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation Person
@end

@interface YLTViewController ()
@property (assign, nonatomic) NSInteger tag;
@property (strong, nonatomic) Person *p;
@end

@implementation YLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIImageView.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    })
    .ylt_convertToImageView()
    .ylt_image([[UIImage ylt_imageNamed:@"bg"] ylt_representation])
    .ylt_contentMode(UIViewContentModeScaleAspectFit);
//    UILabel
//    .ylt_layout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    })
//    .ylt_convertToLabel()
//    .ylt_textAlignment(NSTextAlignmentCenter)
//    .ylt_textColor([UIColor whiteColor])
//    .ylt_fontSize(40)
//    .ylt_signal(RACObserve(self, tag));
//
//   UIImageView
//    .ylt_layout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    })
//    .ylt_convertToImageView()
////    .ylt_image([[UIImage ylt_imageNamed:@"bg"] YLT_DrawCircleImage])
//    .ylt_contentMode(UIViewContentModeScaleAspectFit)
//    .ylt_signal(RACObserve(self, p.name));;//.ylt_tap(self, @selector(tapAction:));
////    self.ylt_params
//    self.ylt_callback(@{});
    
//    @weakify(self);
//    UIButton.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view);
//        make.height.equalTo(@50);
//    }).ylt_convertToButton()
//    .ylt_normalTitle(@"返回")
//    .ylt_buttonClickBlock(^(UIButton *btn) {
//        @strongify(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });
//
//    UIButton.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.equalTo(@50);
//    }).ylt_convertToButton()
//    .ylt_normalTitle(@"下一页")
//    .ylt_buttonClickBlock(^(UIButton *btn) {
//        [YLTViewController ylt_modalVCWithParam:[NSString stringWithFormat:@"下传数据 %zd", self.navigationController.viewControllers.count] callback:^(id response) {
//            YLT_LogInfo(@"%@", response);
//        }];
//    });
//    self.ylt_params = [NSString stringWithFormat:@"回调参数 %zd", self.navigationController.viewControllers.count];
//    YLT_LogInfo(@"---- %@   %zd", self.ylt_params, self.navigationController.viewControllers.count);
    
    UIView *header =
    UIView
    .ylt_create()
    .ylt_backgroundColor([UIColor redColor])
    .ylt_frame(CGRectMake(0, 0, YLT_SCREEN_WIDTH, 50));

    UIView *footer =
    UIView
    .ylt_create()
    .ylt_backgroundColor([UIColor blueColor])
    .ylt_frame(CGRectMake(0, 0, YLT_SCREEN_HEIGHT, 100));

    YLT_TableSectionModel *model =
    [YLT_TableSectionModel ylt_createSectionData:@[@"sdfasdfasdfasdfdsafdsfsdfasdfsdfsadfasddfsadfsdfsdfsdfsdfdsfdsfsdfdsfds", @"2", @"3"]
                                    headerString:@"header"
                                    footerString:nil];

    YLT_TableSectionModel *model1 = [YLT_TableSectionModel ylt_createSectionData:@[@"sdfasdfasdfasdfdsafdsfsdfasdfsdfsadfasddfsadfsdfsdfsdfsdfdsfdsfsdfdsfdssdfasdfasdfasdfdsafdsfsdfasdfsdfsadfasddfsadfsdfsdfsdfsdfdsfdsfsdfdsfds", @"2", @"3"]
                                                                    headerHeight:80
                                                                      headerView:UIView.ylt_create().ylt_backgroundColor([UIColor redColor])
                                                                    footerHeight:20
                                                                      footerView:UIView.ylt_create().ylt_backgroundColor([UIColor blackColor])];
//    UITableView
//    .ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }, UITableViewStylePlain)
//    .ylt_tableHeader(header)
//    .ylt_tableFooter(footer)
//    .ylt_convertToTableView()
//    .ylt_cell(60, [YLTTableViewCell class])
//    .ylt_tableData(@[model, model1]).ylt_cellClick(^(UITableViewCell *cell, NSIndexPath *indexPath, id response) {
//        YLT_LogInfo(@"%@", response);
//    });
}

- (void)ylt_dismiss {
}

- (void)ylt_addSubViews {
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"tap");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tag = self.tag+1;
    self.p = [Person new];
    if (self.tag%2==0) {
        self.p.name = @"bg";
    } else {
        self.p.name = @"icon";
    }
//    self.p.age = self.tag;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
