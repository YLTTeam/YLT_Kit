//
//  AppPageReusableView.h
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import "AppPageView.h"



@interface AppPageReusableView : UICollectionReusableView

@property (nonatomic, strong) AppPageView *mainView;

@property (nonatomic, strong) YLT_BaseModel *data;

- (Class)mainViewClass;

@end


