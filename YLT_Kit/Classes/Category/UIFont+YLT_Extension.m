//
//  UIFont+YLT_Utils.m
//  YLT_Kit
//
//  Created by pz on 08/04/2018.
//

#import "UIFont+YLT_Extension.h"
#import "YLT_BaseMacro.h"

@implementation UIFont (YLT_Utils)
+ (UIFont *)ylt_mediumFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_lightFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_semiboldFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_thinFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Thin" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_regularFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_stRegularFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"FZQingKeBenYueSongS-R-GB" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_politicaBoldFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@"Politica-Bold" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_sfBoldFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@".HelveticaNeueDeskInterface-Bold" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
}

+ (UIFont *)ylt_sfRegularFont:(CGFloat)x {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:@".HelveticaNeueDeskInterface-Regular" size:x];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:x];
    
}
@end
