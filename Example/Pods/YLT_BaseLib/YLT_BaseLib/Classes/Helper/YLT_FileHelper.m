//
//  YLT_FileHelper.m
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/26.
//

#import "YLT_FileHelper.h"

@implementation YLT_FileHelper

YLT_ShareInstance(YLT_FileHelper);

- (void)YLT_init {
}

+ (NSString *)defaultFilePath {
    NSString *basePath = [NSString stringWithFormat:@"%@/%@", YLT_CACHE_PATH, YLT_BundleIdentifier];
    if ([YLT_FileHelper createDirectory:basePath]) {
        return basePath;
    }
    return @"";
}

+ (BOOL)createDirectory:(NSString *)basePath {
    BOOL result = YES;
    BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:basePath isDirectory:&isDirectory]) {
        if (!isDirectory) {
            @try {
                result = [[NSFileManager defaultManager] createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
            } @catch (NSException *exception) {
                YLT_LogError(@"路径创建失败 %@", exception);
                result = NO;
            } @finally {
            }
        }
    }
    return result;
}

+ (NSString *)createPath:(NSString *)path filename:(NSString *)filename {
    NSString *filepath = [NSString stringWithFormat:@"%@/%@", path, filename];
    BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath isDirectory:&isDirectory]) {
        if (isDirectory) {
            @try {
                [[NSFileManager defaultManager] createFileAtPath:filepath contents:nil attributes:nil];
            } @catch (NSException *exception) {
                YLT_LogError(@"文件创建失败 %@", exception);
            } @finally {
            }
        }
    }
    YLT_LogError(@"%@", filepath);
    return filepath;
}

+ (NSString *)createLogWithFilename:(NSString *)filename {
    NSString *basePath = [NSString stringWithFormat:@"%@/OpenLog", YLT_CACHE_PATH];
    [YLT_FileHelper createDirectory:basePath];
    return [YLT_FileHelper createPath:basePath filename:filename];
}

+ (NSString *)createWithFilename:(NSString *)filename {
    NSString *basePath = [NSString stringWithFormat:@"%@/Other", YLT_CACHE_PATH];
    [YLT_FileHelper createDirectory:basePath];
    return [YLT_FileHelper createPath:basePath filename:filename];
}

+ (void)saveToPath:(NSString *)path file:(NSData *)data {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @try {
            [data writeToFile:path atomically:YES];
        } @catch (NSException *exception) {
            YLT_LogError(@"文件写入失败 %@", exception);
        } @finally {
        }
    });
}

+ (void)saveToPath:(NSString *)path image:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.95);
    [YLT_FileHelper saveToPath:path file:data];
}

+ (void)saveWithFileName:(NSString *)filename file:(NSData *)data {
    NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
    [YLT_FileHelper saveWithFileName:path file:data];
}

+ (void)saveWithFilename:(NSString *)filename image:(UIImage *)image {
    NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
    NSData *data = UIImageJPEGRepresentation(image, 0.95);
    [YLT_FileHelper saveToPath:path file:data];
}

+ (UIImage *)readImageWithFilename:(NSString *)filename {
    NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
    return [UIImage imageWithData:[YLT_FileHelper readFileFromPath:path]];
}

+ (NSData *)readFileWithFilename:(NSString *)filename {
    NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
    return [YLT_FileHelper readFileFromPath:path];
}

+ (UIImage *)readImageFromPath:(NSString *)path {
    return [UIImage imageWithData:[YLT_FileHelper readFileFromPath:path]];
}

+ (NSData *)readFileFromPath:(NSString *)path {
    return [NSData dataWithContentsOfFile:path];
}

@end
