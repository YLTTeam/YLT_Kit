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
#import "YLTCollectionViewCell.h"
#import <YLT_Kit/YLT_Kit.h>

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation Person
@end

@interface YLTViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UIImageView *imageview;
@property (assign, nonatomic) NSInteger tag;
@property (strong, nonatomic) Person *p;
@property (strong, nonatomic) YLT_ImageFilter *imageFilter;
@end

@implementation YLTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton ylt_createSuperView:self.view buttonLayout:YLT_ButtonLayoutImageAtBottom image:[UIImage imageNamed:@"微信"] font:[UIFont systemFontOfSize:18] textColor:UIColor.redColor title:@"标题" spacing:4];
    btn.backgroundColor = UIColor.greenColor;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
//    YLT_CollectionSectionModel *model =
//    [YLT_CollectionSectionModel ylt_createSectionData:@[@"11", @"22", @"33"]
//                                         headerString:@"hahahha"
//                                         footerString:@"hahahhaFooter"];
//
//    YLT_CollectionSectionModel *model1 = [YLT_CollectionSectionModel ylt_createSectionData:@[@"123", @"234", @"456"] headerString:@"header" footerString:@"footer"];
//
//    UICollectionView.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }).ylt_convertToCollectionView().ylt_cell(CGSizeMake(120, 120), YLTCollectionViewCell.class).ylt_spacing(8).ylt_delegate(self).ylt_collectionData(@[model, model1]).ylt_cellClick(^(UICollectionViewCell *cell, NSIndexPath *indexPath, id response) {
//        NSLog(@"%zd", indexPath.row);
//    });
    
//    UIView *target = UIView.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
//    }).ylt_backgroundColor(UIColor.redColor).ylt_clickBlock(^(UIView *sender) {
//        NSLog(@"%@", sender);
//    });
//    target.hitsEdgeInsets = UIEdgeInsetsMake(-100, -100, -100, -100);
    
    
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
//    CGFloat start = [[NSDate date] timeIntervalSince1970];
//    NSData *res = [UIImage ylt_representationData:UIImageJPEGRepresentation(image, 0.9) kb:2048];
//    CGFloat end = [[NSDate date] timeIntervalSince1970];
//    NSLog(@"%f , imagesize:%zd, resSize:%zd", end-start, UIImageJPEGRepresentation(image, 0.9).length/1024, res.length/1024);
    
//    self.view.backgroundColor = [UIColor redColor];
//    self.imageview = UIImageView.ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }).ylt_backgroundColor(UIColor.clearColor)
//    .ylt_convertToImageView()
//    .ylt_image([UIImage ylt_imageNamed:@"icon_wifi"])
//    .ylt_contentMode(UIViewContentModeCenter);
//    @weakify(self);
//
//    UISlider *mySlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 280, 44)];
//    mySlider.minimumValue = -100;
//    mySlider.maximumValue = 100;
//    [self.view addSubview:mySlider];
//    [mySlider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view).inset(16);
//        make.height.mas_equalTo(44);
//    }];
//    [[mySlider rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UISlider * _Nullable x) {
//        @strongify(self);
//        self.imageFilter.filterValue = x.value;
//    }];
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
//   self.imageview = UIImageView
//    .ylt_createLayout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    })
//    .ylt_convertToImageView()
//    .ylt_image([[UIImage ylt_imageNamed:@"bg"] ylt_drawCircleImage])
//    .ylt_contentMode(UIViewContentModeScaleAspectFit);
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
    
//    UIView *header =
//    UIView
//    .ylt_create()
//    .ylt_backgroundColor([UIColor redColor])
//    .ylt_frame(CGRectMake(0, 0, YLT_SCREEN_WIDTH, 50));
//
//    UIView *footer =
//    UIView
//    .ylt_create()
//    .ylt_backgroundColor([UIColor blueColor])
//    .ylt_frame(CGRectMake(0, 0, YLT_SCREEN_HEIGHT, 100));
//
//    YLT_TableSectionModel *model =
//    [YLT_TableSectionModel ylt_createSectionData:@[@"sdfasdfasdfasdfdsafdsfsdfasdfsdfsadfasddfsadfsdfsdfsdfsdfdsfdsfsdfdsfds", @"2", @"3"]
//                                    headerString:@"header"
//                                    footerString:nil];
//
//    YLT_TableSectionModel *model1 = [YLT_TableSectionModel ylt_createSectionData:@[@"sdfasdfasdfasdfdsafdsfsdfasdfsdfsadfasddfsadfsdfsdfsdfsdfdsfdsfsdfdsfdssdfasdfasdfasdfdsafdsfsdfasdfsdfsadfasddfsadfsdfsdfsdfsdfdsfdsfsdfdsfds", @"2", @"3"]
//                                                                    headerHeight:80
//                                                                      headerView:UIView.ylt_create().ylt_backgroundColor([UIColor redColor])
//                                                                    footerHeight:20
//                                                                      footerView:UIView.ylt_create().ylt_backgroundColor([UIColor blackColor])];
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

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(240, 240);
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    YLT_Log(@"did selected");
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
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
    @weakify(self);
    self.imageFilter = [YLT_ImageFilter filterImage:[UIImage imageNamed:@"icon_wifi"] filterType:YLT_ImageFilterTypeTemperatureAndTint value:0.0 value2:0.0 completion:^(UIImage *outputImage) {
        @strongify(self);
        self.imageview.image = outputImage;
    }];
    return;
    
    [NSURLProtocol ylt_registerScheme:@"http"];
    [NSURLProtocol ylt_registerScheme:@"https"];
    
    YLT_BaseWebVC *vc = [YLT_BaseWebVC ylt_webVCFromURLString:@"https://static.ultimavip.cn/marketing/test/index2.html?navigationBarHidden=1"];
//    [[vc.webView webView] evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSString *userAgent = result;
//        NSString *newUserAgent = [userAgent stringByAppendingString:@" black_magic "];
//
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [[vc.webView webView] setCustomUserAgent:newUserAgent];
//        //        echo(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"UserAgent"]);
//
//        //    判断网址类型
//    }];
    
    @weakify(vc);
    [vc ylt_addObserverNames:@[@"getUserInfo1", @"getUserInfo", @"startNativeView"] callback:^(WKScriptMessage *message) {
        @strongify(vc);
        YLT_Log(@"%@ %@", message.name, message.body);
        [vc ylt_sendMethodName:@"native_callback" param:@"test", @"hello", nil];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
//    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:root animated:YES completion:nil];
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
