//
//  UIImage+YLT_Extension.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIImage+YLT_Extension.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (YLT_Extension)

/**
 通过颜色获取纯色的图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)ylt_imageFromColor:(UIColor *)color {
    return [UIImage ylt_imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)ylt_imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame {
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)ylt_renderColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)ylt_imageNamed:(NSString *)imageName {
    UIImage *result = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    if (result == nil) {
        NSArray *array = [imageName componentsSeparatedByString:@"/"];
        NSString *bundleName = nil;
        NSString *type = @"png";
        NSString *name = imageName;
        NSMutableString *dir = nil;
        if (array.count == 1) {
            result = [UIImage imageNamed:imageName];
        } else if (array.count > 1) {
            for (NSString *path in array) {
                if ([path hasPrefix:@".bundle"]) {
                    bundleName = path;
                } else if ([path rangeOfString:@"."].location != NSNotFound) {
                    NSArray *nameList = [path componentsSeparatedByString:@"."];
                    name = nameList[0];
                    if ([name hasSuffix:@"@2x"]) {
                        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
                    }
                    if ([name hasSuffix:@"@3x"]) {
                        name = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
                    }
                    type = nameList[1];
                } else {
                    if (dir == nil) {
                        dir = [[NSMutableString alloc] init];
                    }
                    [dir appendFormat:@"%@/", path];
                }
            }
            
            result = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForAuxiliaryExecutable:[NSString stringWithFormat:@"%@.bundle", bundleName]]]?:[NSBundle bundleForClass:[self class]] pathForResource:name ofType:type?:@"png" inDirectory:dir]];
        }
    }
    
    return result;
}

/**
 绘制圆角图片
 
 @return 圆角图片
 */
- (UIImage *)ylt_drawCircleImage {
    CGFloat x = (self.size.width>self.size.height)?(self.size.width-self.size.height)/2.:0;
    CGFloat y = (self.size.width>self.size.height)?0:(self.size.height-self.size.width)/2.;
    CGFloat width = (self.size.width>self.size.height)?self.size.height:self.size.width;
    CGRect bounds = CGRectMake(0, 0, width, width);
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2., width/2.) radius:width/2. startAngle:0 endAngle:M_PI*2. clockwise:YES] addClip];
    [self drawInRect:CGRectMake(-x, -y, self.size.width, self.size.height)];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

/**
 绘制圆角
 
 @param radius 圆角
 @return 圆角图
 */
- (UIImage *)ylt_drawRectImage:(CGFloat)radius {
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius] addClip];
    [self drawInRect:bounds];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

//对图片尺寸进行压缩--
- (UIImage*)ylt_scaledToSize:(CGSize)size {
    return [self ylt_scaledToSize:size highQuality:NO];
}

- (UIImage*)ylt_scaledToSize:(CGSize)size highQuality:(BOOL)highQuality{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = size.width / imageSize.width;
        CGFloat heightFactor = size.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    size = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    if (highQuality) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    }else{
        UIGraphicsBeginImageContext(size); // this will crop
    }
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage * __nonnull)ylt_fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage* __nonnull) ylt_thumbnailImageForVideo:(NSURL *)videoURL {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    NSError *thumbnailImageGenerationError = nil;
    //CMTimeMake(a,b),a为第几帧开始，b为每秒多少帧，copyCGImageAtTime获取该时间点的帧图片
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(0, 10)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef) {
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    }
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

+ (UIImage *)ylt_fullResolutionImageFromALAsset:(ALAsset *)asset {
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

+ (UIImage *)ylt_fullScreenImageALAsset:(ALAsset *)asset {
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullScreenImage];//fullScreenImage已经调整过方向了
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    return img;
}

//截取当前屏幕
+ (UIImage *)ylt_screenshotImage {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
    }
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ylt_convertViewToImage:(UIView *)view {
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIColor *)ylt_colorAtPixel:(CGPoint)point {
    
    // Cancel if point is outside image coordinates
    
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        
        return nil;
        
    }
    NSInteger pointX = trunc(point.x);
    
    NSInteger pointY = trunc(point.y);
    
    CGImageRef cgImage = self.CGImage;
    
    NSUInteger width = self.size.width;
    
    NSUInteger height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    int bytesPerPixel = 4;
    
    int bytesPerRow = bytesPerPixel * 1;
    
    NSUInteger bitsPerComponent = 8;
    
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 
                                                 1,
                                                 
                                                 1,
                                                 
                                                 bitsPerComponent,
                                                 
                                                 bytesPerRow,
                                                 
                                                 colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    
    // Draw the pixel we are interested in onto the bitmap context
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    
    CGFloat red = (CGFloat)pixelData[0] / 255.0f;
    
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    
    CGFloat blue = (CGFloat)pixelData[2] / 255.0f;
    
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

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
- (UIImage *)ylt_imageWithHue:(CGFloat)hue saturation:(CGFloat)saturation bright:(CGFloat)bright {
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


//- (UIImage * __nonnull)ylt_pngImageDataWithKB:(NSUInteger)KB {
//    int scale=1;
//    //   等比例缩放
//    NSData *imageAfterProcessing = UIImagePNGRepresentation(self);
//    while ((imageAfterProcessing.length/1024)>KB) {
//        scale++;
//        imageAfterProcessing=UIImagePNGRepresentation([self ylt_scaledToSize:CGSizeMake(self.size.width/scale, self.size.height/scale)]);
//    }
//    return [[UIImage alloc] initWithData:imageAfterProcessing];
//}
/**
 图片的默认优化算法
 
 @return 优化后的图片，返回的一定是JPEG格式的
 */
- (UIImage *)ylt_representation {
    return [UIImage imageWithData:[UIImage ylt_representationData:UIImageJPEGRepresentation(self, 0.95) kb:512]];
}

/**
 获取图片的类型
 
 @param imageData 图片数据
 @return 类型名称 PNG、JPEG等
 */
+ (NSString *)ylt_imageTypeFromData:(NSData *)imageData {
    if (imageData.length < 1) {
        return nil;
    }
    uint8_t c;
    [imageData getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"JPEG";
        case 0x89:
            return @"PNG";
        case 0x47:
            return @"GIF";
        case 0x49:
        case 0x4D:
            return @"TIFF";
        case 0x52:
            if ([imageData length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[imageData subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

/**
 图片压缩算法处理
 
 @param imageData 图片压缩前的数据 PNG的使用 UIImagePNGRepresentation JPEG使用 UIImageJPEGRepresentation
 @param kb 大小
 @return 压缩后的Data
 */
+ (NSData *)ylt_representationData:(NSData *)imageData kb:(NSUInteger)kb {
    if (imageData.length <= kb) {
        return imageData;
    }
    NSString *imageType = [self ylt_imageTypeFromData:imageData];
    if ([imageType isEqualToString:@"PNG"]) {
        while (imageData.length > kb) {
            @autoreleasepool {
                CGFloat scale = ((CGFloat)kb)/((CGFloat)imageData.length);
                UIImage *image = [UIImage imageWithData:imageData];
                imageData = UIImagePNGRepresentation([image ylt_scaledToSize:CGSizeMake(image.size.width*scale*2., image.size.height*scale*2.) highQuality:YES]);
            }
        }
        return imageData;
    } else if ([imageType isEqualToString:@"JPEG"]) {
        while (imageData.length > kb) {
            @autoreleasepool {
                CGFloat scale = ((CGFloat)kb)/((CGFloat)imageData.length);
                UIImage *image = [UIImage imageWithData:imageData];
                imageData = UIImageJPEGRepresentation([image ylt_scaledToSize:CGSizeMake(image.size.width*scale*2., image.size.height*scale*2.) highQuality:YES], 0.98);
            }
        }
        return imageData;
    }
    return imageData;
}

@end
