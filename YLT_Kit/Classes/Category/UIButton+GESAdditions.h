//
//  UIButton+GESAdditions.h
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GESAdditions)

/**
 *  添加点按动作
 */
- (void(^)(id, SEL, UIControlEvents))ges_addAction;

@end
