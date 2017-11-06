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

@end

@implementation YLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIImageView.YLT_Layout(self.view, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }).YLT_ConvertToImageView().YLT_Image([[UIImage YLT_ImageNamed:@"bg"] YLT_DrawCircleImage]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
