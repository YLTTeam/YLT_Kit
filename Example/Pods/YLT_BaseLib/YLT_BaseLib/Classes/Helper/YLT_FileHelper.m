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

+ (void)saveToPath:(NSString *)path file:(NSData *)data callback:(void (^)(NSString *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @try {
            BOOL result = [data writeToFile:path atomically:YES];
            if (result) {
                if (callback) {
                    callback(path);
                }
            }
        } @catch (NSException *exception) {
            YLT_LogError(@"文件写入失败 %@", exception);
        } @finally {
        }
    });
}

+ (void)saveToPath:(NSString *)path image:(UIImage *)image callback:(void (^)(NSString *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = UIImageJPEGRepresentation(image, 0.95);
        [YLT_FileHelper saveToPath:path file:data callback:callback];
    });
}

+ (void)saveWithFileName:(NSString *)filename file:(NSData *)data callback:(void (^)(NSString *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
        [YLT_FileHelper saveWithFileName:path file:data callback:callback];
    });
}

+ (void)saveWithFilename:(NSString *)filename image:(UIImage *)image callback:(void (^)(NSString *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
        NSData *data = UIImageJPEGRepresentation(image, 0.95);
        [YLT_FileHelper saveToPath:path file:data callback:callback];
    });
}

+ (void)readImageWithFilename:(NSString *)filename callback:(void (^)(UIImage *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
        [self readImageFromPath:path callback:callback];
    });
}

+ (void)readFileWithFilename:(NSString *)filename callback:(void (^)(NSData *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [YLT_FileHelper createPath:[YLT_FileHelper defaultFilePath] filename:filename];
        [self readFileFromPath:path callback:callback];
    });
}

+ (void)readImageFromPath:(NSString *)path callback:(void (^)(UIImage *))callback {
    [self readFileFromPath:path callback:^(NSData *result) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *result = [UIImage imageWithData:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback(result);
                }
            });
        });
    }];
}

+ (void)readFileFromPath:(NSString *)path callback:(void (^)(NSData *))callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfFile:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback && data) {
                callback(data);
            }
        });
    });
}

@end
