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

@interface YLTViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImageView *imageview;
@property (assign, nonatomic) NSInteger tag;
@property (strong, nonatomic) Person *p;
@end

@implementation YLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
//    CGFloat start = [[NSDate date] timeIntervalSince1970];
//    NSData *res = [UIImage ylt_representationData:UIImageJPEGRepresentation(image, 0.9) kb:2048];
//    CGFloat end = [[NSDate date] timeIntervalSince1970];
//    NSLog(@"%f , imagesize:%zd, resSize:%zd", end-start, UIImageJPEGRepresentation(image, 0.9).length/1024, res.length/1024);
    
//    self.view.backgroundColor = [UIColor redColor];
//    UIImageView.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    })
//    .ylt_convertToImageView()
//    .ylt_image([[UIImage ylt_imageNamed:@"bg"] ylt_representation])
//    .ylt_contentMode(UIViewContentModeScaleAspectFit);
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
   self.imageview = UIImageView
    .ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    })
    .ylt_convertToImageView()
    .ylt_image([[UIImage ylt_imageNamed:@"bg"] ylt_drawCircleImage])
    .ylt_contentMode(UIViewContentModeScaleAspectFit);
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat start = [[NSDate date] timeIntervalSince1970];
    image = [image ylt_representation];
    CGFloat end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%f , imagesize:%zd, resSize:%zd", end-start, data.length/1024, UIImageJPEGRepresentation(image, 1.0).length/1024);
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imageview.image = image;
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
    [NSURLProtocol ylt_registerScheme:@"http"];
    [NSURLProtocol ylt_registerScheme:@"https"];
    
    __block YLT_BaseWebVC *vc = [YLT_BaseWebVC webVCFromURLString:@"https://static.ultimavip.cn/marketing/test/index.html"];
    [vc addObserverNames:@[@"getUserInfo1", @"getUserInfo"] callback:^(WKScriptMessage *message) {
        YLT_Log(@"%@ %@", message.name, message.body);
        [vc sendString:@"hello world chenxue" toMethodName:@"callback"];
    }];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    //    [[vc.webView webView] evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    //        NSString *userAgent = result;
    //        NSString *newUserAgent = [userAgent stringByAppendingString:@" ios/jkbs/1.2.3"];
    //
    //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
    //        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //        [[vc.webView webView] setCustomUserAgent:newUserAgent];
    //        //        echo(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"UserAgent"]);
    //
    //        //    判断网址类型
    //    }];
//    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
//    imagepicker.delegate = self;
//    imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:imagepicker animated:YES completion:nil];
    
//    self.tag = self.tag+1;
//    self.p = [Person new];
//    if (self.tag%2==0) {
//        self.p.name = @"bg";
//    } else {
//        self.p.name = @"icon";
//    }
//    self.p.age = self.tag;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
