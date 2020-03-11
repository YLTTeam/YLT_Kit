//
//  AppModel+Extension.m
//  App
//
//  Created by 項普華 on 2020/3/10.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "AppModel+Extension.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation AppSectionModel (Extension)
@dynamic rowSize;
@dynamic headerSize;
@dynamic footerSize;

- (CGSize)rowSize {
    CGSize result = CGSizeMake(self.width, self.height);
    if (result.width == 0.) {
        result.width = 375.-self.left-self.right;
        if (self.columCount != 0) {
            result.width = (375.-self.left-self.right-self.spacing*(self.columCount))/(CGFloat)self.columCount;
        }
    }
    if (result.height == 0.) {
        result.height = result.width*9./16.+self.top+self.bottom;
        if (self.ratio != 0.) {
            result.height = result.width/self.ratio+self.top+self.bottom;
        }
    }
    return CGSizeMake(YLT_Scale_Width(result.width), YLT_Scale_Width(result.height));
}

- (CGSize)headerSize {
    return CGSizeMake(YLT_SCREEN_WIDTH, self.headerModel.height+self.headerModel.top+self.headerModel.bottom);
}

- (CGSize)footerSize {
    return CGSizeMake(YLT_SCREEN_WIDTH, self.footerModel.height+self.headerModel.top+self.headerModel.bottom);
}

- (UIEdgeInsets)appInsets {
    return UIEdgeInsetsMake(YLT_Scale_Width(self.top), YLT_Scale_Width(self.left), YLT_Scale_Width(self.bottom), YLT_Scale_Width(self.right));
}

- (CGFloat)appSpacing {
    return YLT_Scale_Width(self.spacing);
}

@end
