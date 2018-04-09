//
//  NSFileManager+YLT_Extension.m
//  FMDB
//
//  Created by 项普华 on 2018/4/8.
//

#import "NSFileManager+YLT_Extension.h"

@implementation NSFileManager (YLT_Extension)

/**
 Direcroty对应的沙盒路径URL
 
 @param directory 沙盒
 @return URL
 */
+ (NSURL *)ylt_URLForDirectory:(NSSearchPathDirectory)directory {
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

/**
 directory对应的沙盒路径Path
 
 @param directory 沙盒
 @return Path
 */
+ (NSString *)ylt_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

/**
 Documents URL
 
 @return URL
 */
+ (NSURL *)ylt_documentsURL {
    return [self ylt_URLForDirectory:NSDocumentDirectory];
}

/**
 Documents Path
 
 @return Path
 */
+ (NSString *)ylt_documentsPath {
    return [self ylt_pathForDirectory:NSDocumentDirectory];
}

/**
 Library URL
 
 @return URL
 */
+ (NSURL *)ylt_libraryURL {
    return [self ylt_URLForDirectory:NSLibraryDirectory];
}

/**
 Library Path
 
 @return Path
 */
+ (NSString *)ylt_libraryPath
{
    return [self ylt_pathForDirectory:NSLibraryDirectory];
}

/**
 Cache URL
 
 @return URL
 */
+ (NSURL *)ylt_cachesURL {
    return [self ylt_URLForDirectory:NSCachesDirectory];
}

/**
 Cache Path
 
 @return Path
 */
+ (NSString *)ylt_cachesPath {
    return [self ylt_pathForDirectory:NSCachesDirectory];
}

/**
 防止文件被备份
 
 @param path 路径
 @return 结果
 */
+ (BOOL)ylt_addSkipBackupAttributeToFile:(NSString *)path {
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

/**
 获取磁盘可用空间
 
 @return 空间大小
 */
+ (double)ylt_availableDiskSpace {
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.ylt_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

@end
