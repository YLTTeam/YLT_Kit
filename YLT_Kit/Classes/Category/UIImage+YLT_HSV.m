//
//  UIImage+YLT_HSV.m
//  Pods
//
//  Created by YLT_Alex on 2017/12/13.
//

#import "UIImage+YLT_HSV.h"

@implementation UIImage (YLT_HSV)

//交换
static inline void SwapRGB(int *a, int *b) {
    *a+=*b;
    *b=*a-*b;
    *a-=*b;
}
//范围
static inline void CheckRGB(int *Value) {
    if (*Value < 0) *Value = 0;
    else if (*Value > 255) *Value = 255;
}
//赋值
static inline void AssignRGB(int *R, int *G, int *B, int intR, int intG, int intB) {
    *R = intR;
    *G = intG;
    *B = intB;
}
//设置明亮
static void SetBright(int *R, int *G, int *B, int bValue) {
    int intR = *R;
    int intG = *G;
    int intB = *B;
    if (bValue > 0)
    {
        intR = intR + (255 - intR) * bValue / 255;
        intG = intG + (255 - intG) * bValue / 255;
        intB = intB + (255 - intB) * bValue / 255;
    }
    else if (bValue < 0)
    {
        intR = intR + intR * bValue / 255;
        intG = intG + intG * bValue / 255;
        intB = intB + intB * bValue / 255;
    }
    CheckRGB(&intR);
    CheckRGB(&intG);
    CheckRGB(&intB);
    AssignRGB(R, G, B, intR, intG, intB);
}
//设置色相和饱和度
static void SetHueAndSaturation(int *R, int *G, int *B, int hValue, int sValue) {
    int intR = *R;
    int intG = *G;
    int intB = *B;
    
    if (intR < intG)
        SwapRGB(&intR, &intG);
    if (intR < intB)
        SwapRGB(&intR, &intB);
    if (intB > intG)
        SwapRGB(&intB, &intG);
    
    int delta = intR - intB;
    if (!delta) return;
    
    int entire = intR + intB;
    int H, S, L = entire >> 1;  //右移一位其实就是除以2（很巧妙）
    if (L < 128)
        S = delta * 255 / entire;
    else
        S = delta * 255 / (510 - entire);
    
    if (hValue) {
        if (intR == *R)
            H = (*G - *B) * 60 / delta;
        else if (intR == *G)
            H = (*B - *R) * 60 / delta + 120;
        else
            H = (*R - *G) * 60 / delta + 240;
        H += hValue;
        if (H < 0) H += 360;
        else if (H > 360) H -= 360;
        int index = H / 60;
        int extra = H % 60;
        if (index & 1) extra = 60 - extra;
        extra = (extra * 255 + 30) / 60;
        intG = extra - (extra - 128) * (255 - S) / 255;
        int Lum = L - 128;
        if (Lum > 0)
            intG += (((255 - intG) * Lum + 64) / 128);
        else if (Lum < 0)
            intG += (intG * Lum / 128);
        CheckRGB(&intG);
        switch (index) {
            case 1:
                SwapRGB(&intR, &intG);
                break;
            case 2:
                SwapRGB(&intR, &intB);
                SwapRGB(&intG, &intB);
                break;
            case 3:
                SwapRGB(&intR, &intB);
                break;
            case 4:
                SwapRGB(&intR, &intG);
                SwapRGB(&intG, &intB);
                break;
            case 5:
                SwapRGB(&intG, &intB);
                break;
        }
    } else {
        intR = *R;
        intG = *G;
        intB = *B;
    }
    if (sValue) {
        if (sValue > 0) {
            sValue = sValue + S >= 255? S: 255 - sValue;
            sValue = 65025 / sValue - 255;
        }
        intR += ((intR - L) * sValue / 255);
        intG += ((intG - L) * sValue / 255);
        intB += ((intB - L) * sValue / 255);
        CheckRGB(&intR);
        CheckRGB(&intG);
        CheckRGB(&intB);
    }
    AssignRGB(R, G, B, intR, intG, intB);
}

static CGContextRef RequestImagePixelData(CGImageRef inImage) {
    CGContextRef context = NULL;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    size_t bitmapBytesPerRow    = (pixelsWide * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //size_t bitmapByteCount    = (bitmapBytesPerRow * pixelsHigh);
    //bitmapData = malloc( bitmapByteCount );   //当年背时的用到了它，就悲剧了(申请的内存没有初使化)
    void *bitmapData = calloc( pixelsWide*pixelsHigh,4);
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    
    CGRect rect = {{0,0},{pixelsWide, pixelsHigh}};
    CGContextDrawImage(context, rect, inImage);
    
    CGColorSpaceRelease( colorSpace );
    return context;
}

/**
 改变图片的显示色调、明暗等
 
 @param hue 色调
 @param saturation 饱和度
 @param bright 透明度
 @return 改变后的图片
 */
- (UIImage *)YLT_ImageWithHue:(CGFloat)hue saturation:(CGFloat)saturation bright:(CGFloat)bright {
    if (hue==0&&saturation==0&&bright==0) {
        UIImage *my_Image=nil;
        if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
            my_Image=[UIImage imageWithCGImage:[self CGImage] scale:self.scale orientation:self.imageOrientation];
        }else {
            my_Image = [UIImage imageWithCGImage:[self CGImage]];
        }
        return my_Image;
    }
    saturation = (saturation>1)?saturation:(saturation*255.);
    bright = (bright>1)?bright:(bright*255.);
    
    CGImageRef inImageRef = [self CGImage];
    CGContextRef cgctx = RequestImagePixelData(inImageRef);
    if (cgctx==NULL) {
        fprintf (stderr, "Create PixelData error!");
        return nil;
    }
    NSUInteger w = CGBitmapContextGetWidth(cgctx);
    NSUInteger h = CGBitmapContextGetHeight(cgctx);
    unsigned char *imgPixel = CGBitmapContextGetData(cgctx);
    
    int pixOff = 0;  //每一个像素结束
    
    for(NSUInteger y = 0;y< h;y++){
        for (NSUInteger x = 0; x<w; x++){
            //int alpha = (unsigned char)imgPixel[pixOff];
            int red = (unsigned char)imgPixel[pixOff];
            int green = (unsigned char)imgPixel[pixOff+1];
            int blue = (unsigned char)imgPixel[pixOff+2];
            
            if ((red|green|blue)!=0) {
                //根据条件的不同，对图片的处理顺序不一样
                if (saturation > 0 && bright)
                    SetBright(&red, &green, &blue, bright);
                
                SetHueAndSaturation(&red, &green, &blue, hue, saturation);
                
                if (bright && saturation <= 0)
                    SetBright(&red, &green, &blue, bright);
            }
            
            imgPixel[pixOff] = red;
            imgPixel[pixOff+1] = green;
            imgPixel[pixOff+2] = blue;
            
            pixOff += 4;
        }
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(cgctx);
    
    UIImage *my_Image=nil;
    if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        my_Image=[UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    }else {
        my_Image = [UIImage imageWithCGImage:imageRef];
    }
    
    CFRelease(imageRef);
    CGContextRelease(cgctx);
    free(imgPixel);
    return my_Image;
}

@end
