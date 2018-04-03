//
//  YLTViewController.m
//  YLT_Kit
//
//  Created by xphaijj0305@126.com on 10/25/2017.
//  Copyright (c) 2017 xphaijj0305@126.com. All rights reserved.
//

#import "YLTViewController.h"
#import <YLT_Kit/YLT_Kit.h>

@interface YLTViewController ()
@property (assign, nonatomic) NSInteger tag;
@end

@implementation YLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    UIImageView.YLT_Layout(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }).YLT_ConvertToImageView().YLT_Image([UIImage YLT_ImageNamed:@"bg"]).YLT_ContentMode(UIViewContentModeScaleAspectFit);
    UIImageView
    .YLT_Layout(self.view, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    })
    .YLT_ConvertToImageView()
    .YLT_Image([[UIImage YLT_ImageNamed:@"bg"] YLT_DrawCircleImage])
    .YLT_ContentMode(UIViewContentModeScaleAspectFit);
    //.YLT_Signal(RACObserve(self, tag));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tag = self.tag+1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
