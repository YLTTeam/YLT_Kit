//
//  UIColor+YLT_Extension.m
//  AFNetworking
//
//  Created by YLT_Alex on 2018/2/12.
//

#import "UIColor+YLT_Extension.h"
#import "UIImage+YLT_Extension.h"
#import <objc/message.h>

@implementation UIColor (YLT_Extension)

-(CGColorSpaceModel)ylt_colorSpaceModel{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)ylt_colorSpaceString {
    switch (self.ylt_colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

-(BOOL)ylt_canProvideRGBComponents {
    switch (self.ylt_colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (NSArray *)ylt_arrayFromRGBAComponents {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be an RGB color to use -arrayFromRGBAComponents");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [NSArray arrayWithObjects:
            [NSNumber numberWithFloat:r],
            [NSNumber numberWithFloat:g],
            [NSNumber numberWithFloat:b],
            [NSNumber numberWithFloat:a],
            nil];
}

- (BOOL)ylt_red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.ylt_colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:    // We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (CGFloat)ylt_red {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)ylt_green {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.ylt_colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)ylt_blue {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.ylt_colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)ylt_white {
    NSAssert(self.ylt_colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)ylt_alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)ylt_rgbHex {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.ylt_red, 0.0f), 1.0f);
    g = MIN(MAX(self.ylt_green, 0.0f), 1.0f);
    b = MIN(MAX(self.ylt_blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

#pragma mark Arithmetic operations

- (UIColor *)ylt_colorByLuminanceMapping {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    // http://en.wikipedia.org/wiki/Luma_(video)
    // Y = 0.2126 R + 0.7152 G + 0.0722 B
    return [UIColor colorWithWhite:r*0.2126f + g*0.7152f + b*0.0722f
                             alpha:a];
    
}

- (UIColor *)ylt_colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(0.0, MIN(1.0, r * red))
                           green:MAX(0.0, MIN(1.0, g * green))
                            blue:MAX(0.0, MIN(1.0, b * blue))
                           alpha:MAX(0.0, MIN(1.0, a * alpha))];
}

- (UIColor *)ylt_colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(0.0, MIN(1.0, r + red))
                           green:MAX(0.0, MIN(1.0, g + green))
                            blue:MAX(0.0, MIN(1.0, b + blue))
                           alpha:MAX(0.0, MIN(1.0, a + alpha))];
}

- (UIColor *)ylt_colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(r, red)
                           green:MAX(g, green)
                            blue:MAX(b, blue)
                           alpha:MAX(a, alpha)];
}

- (UIColor *)ylt_colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MIN(r, red)
                           green:MIN(g, green)
                            blue:MIN(b, blue)
                           alpha:MIN(a, alpha)];
}

- (UIColor *)ylt_colorByMultiplyingBy:(CGFloat)f {
    return [self ylt_colorByMultiplyingByRed:f green:f blue:f alpha:1.0f];
}

- (UIColor *)ylt_colorByAdding:(CGFloat)f {
    return [self ylt_colorByMultiplyingByRed:f green:f blue:f alpha:0.0f];
}

- (UIColor *)ylt_colorByLighteningTo:(CGFloat)f {
    return [self ylt_colorByLighteningToRed:f green:f blue:f alpha:0.0f];
}

- (UIColor *)ylt_colorByDarkeningTo:(CGFloat)f {
    return [self ylt_colorByDarkeningToRed:f green:f blue:f alpha:1.0f];
}

- (UIColor *)ylt_colorByMultiplyingByColor:(UIColor *)color {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self ylt_colorByMultiplyingByRed:r green:g blue:b alpha:1.0f];
}

- (UIColor *)ylt_colorByAddingColor:(UIColor *)color {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self ylt_colorByAddingRed:r green:g blue:b alpha:0.0f];
}

- (UIColor *)ylt_colorByLighteningToColor:(UIColor *)color {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self ylt_colorByLighteningToRed:r green:g blue:b alpha:0.0f];
}

- (UIColor *)ylt_colorByDarkeningToColor:(UIColor *)color {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self ylt_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self ylt_colorByDarkeningToRed:r green:g blue:b alpha:1.0f];
}

#pragma mark String utilities

- (NSString *)ylt_stringFromColor {
    NSAssert(self.ylt_canProvideRGBComponents, @"Must be an RGB color to use -stringFromColor");
    NSString *result;
    switch (self.ylt_colorSpaceModel) {
        case kCGColorSpaceModelRGB:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.ylt_red, self.ylt_green, self.ylt_blue, self.ylt_alpha];
            break;
        case kCGColorSpaceModelMonochrome:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.ylt_white, self.ylt_alpha];
            break;
        default:
            result = nil;
    }
    return result;
}

- (NSString *)ylt_hexStringFromColor {
    return [NSString stringWithFormat:@"%0.6X", (int)self.ylt_rgbHex];
}

+ (UIColor *)ylt_colorWithString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    if (![scanner scanString:@"{" intoString:NULL]) return nil;
    const NSUInteger kMaxComponents = 4;
    CGFloat c[kMaxComponents];
    NSUInteger i = 0;
    if (![scanner scanFloat:(float *)&c[i++]]) return nil;
    while (1) {
        if ([scanner scanString:@"}" intoString:NULL]) break;
        if (i >= kMaxComponents) return nil;
        if ([scanner scanString:@"," intoString:NULL]) {
            if (![scanner scanFloat:(float *)&c[i++]]) return nil;
        } else {
            // either we're at the end of there's an unexpected character here
            // both cases are error conditions
            return nil;
        }
    }
    if (![scanner isAtEnd]) return nil;
    UIColor *color;
    switch (i) {
        case 2: // monochrome
            color = [UIColor colorWithWhite:c[0] alpha:c[1]];
            break;
        case 4: // RGB
            color = [UIColor colorWithRed:c[0] green:c[1] blue:c[2] alpha:c[3]];
            break;
        default:
            color = nil;
    }
    return color;
}

#pragma mark Class methods

+ (UIColor *)ylt_randomColor {
    return [UIColor colorWithRed:(arc4random()%256)/256.f
                           green:(arc4random()%256)/256.f
                            blue:(arc4random()%256)/256.f
                           alpha:1.0f];
}

+ (UIColor *)ylt_colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)ylt_colorWithHexString:(NSString *)stringToConvert {
    stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor ylt_colorWithRGBHex:hexNum];
}
+ (UIColor *)ylt_colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha{
    UIColor *color = [UIColor ylt_colorWithHexString:stringToConvert];
    return [UIColor colorWithRed:color.ylt_red green:color.ylt_green blue:color.ylt_blue alpha:alpha];
}

+ (UIColor *)ylt_colorWithGradientStyle:(UIGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray<UIColor *> * _Nonnull)colors{
    return [self ylt_colorWithGradientStyle:gradientStyle withFrame:frame andColors:colors locations:nil];
}

+ (UIColor *)ylt_colorWithGradientStyle:(UIGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray<UIColor *> * _Nonnull)colors locations:(NSArray *)c_locations{
    return [UIColor colorWithPatternImage:[UIImage ylt_imageWithGradientStyle:gradientStyle withFrame:frame andColors:colors locations:c_locations]];
}

/**
 * 颜色渐变
 * @param startColor 起始颜色
 * @param endColor 终止颜色
 * @param f 系数
 * @return 颜色
 */
+ (UIColor *)ylt_colorStartColor:(NSString *)startColor endColor:(NSString *)endColor f:(CGFloat)f {
    startColor = [startColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
    startColor = [startColor stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    startColor = [startColor stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    endColor = [endColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
    endColor = [endColor stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    endColor = [endColor stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    
    // Scan values
    unsigned int sr, sg, sb, sa;
    unsigned int er, eg, eb, ea;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [startColor substringWithRange:range];
    range.location = 2;
    NSString *gString = [startColor substringWithRange:range];
    range.location = 4;
    NSString *bString = [startColor substringWithRange:range];
    NSString *aString = @"FF";
    if ([startColor length] == 8) {
        range.location = 6;
        aString = [startColor substringWithRange:range];
    }
    [[NSScanner scannerWithString:rString] scanHexInt:&sr];
    [[NSScanner scannerWithString:gString] scanHexInt:&sg];
    [[NSScanner scannerWithString:bString] scanHexInt:&sb];
    [[NSScanner scannerWithString:aString] scanHexInt:&sa];
    
    
    range.location = 0;
    range.length = 2;
    rString = [endColor substringWithRange:range];
    range.location = 2;
    gString = [endColor substringWithRange:range];
    range.location = 4;
    bString = [endColor substringWithRange:range];
    
    aString = @"FF";
    if ([startColor length] == 8) {
        range.location = 6;
        aString = [endColor substringWithRange:range];
    }
    [[NSScanner scannerWithString:rString] scanHexInt:&er];
    [[NSScanner scannerWithString:gString] scanHexInt:&eg];
    [[NSScanner scannerWithString:bString] scanHexInt:&eb];
    [[NSScanner scannerWithString:aString] scanHexInt:&ea];
    
    int r,g,b,a;
    if (er >= sr) {
        r = (int)(sr+(er-sr)*f);
    } else {
        r = (int)(er+(sr-er)*f);
    }
    if (eg >= sg) {
        g = (int)(sg+(eg-sg)*f);
    } else {
        g = (int)(eg+(sg-eg)*f);
    }
    if (eb >= sb) {
        b = (int)(sb+(eb-sb)*f);
    } else {
        b = (int)(eb+(sb-eb)*f);
    }
    if (ea > sa) {
        a = (int)(sa+(ea-sa)*f);
    } else {
        a = (int)(ea+(sa-ea)*f);
    }
    
    return [UIColor colorWithRed:((CGFloat)r)/255. green:((CGFloat)g)/255. blue:((CGFloat)b)/255. alpha:((CGFloat)a)/255.];
}

@end
