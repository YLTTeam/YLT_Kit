//
//  YLT_FileHelper.h
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/26.
//

#import <Foundation/Foundation.h>
#import "YLT_BaseMacro.h"
#import <UIKit/UIKit.h>

@interface YLT_FileHelper : NSObject

YLT_ShareInstanceHeader(YLT_FileHelper);

/**
 默认存储路径
 
 @return 路径
 */
+ (NSString *)defaultFilePath;

/**
 日志管理路径
 
 @param filename 文件名
 @return 路径
 */
+ (NSString *)createLogWithFilename:(NSString *)filename;

/**
 创建文件路径
 
 @param filename 文件名
 @return 路径
 */
+ (NSString *)createWithFilename:(NSString *)filename;

/**
 存储文件到本地
 
 @param path 本地路径 存储到默认路径
 @param data 文件的data
 @param callback 回调
 */
+ (void)saveToPath:(NSString *)path file:(NSData *)data callback:(void(^)(NSString *path))callback;

/**
 存储图片到本地
 
 @param path 本地路径 存储到默认路径
 @param image 图片
 @param callback 回调
 */
+ (void)saveToPath:(NSString *)path image:(UIImage *)image callback:(void(^)(NSString *path))callback;

/**
 存储文件到本地
 
 @param filename 本地路径 存储到默认路径
 @param data 文件的data
 @param callback 回调
 */
+ (void)saveWithFileName:(NSString *)filename file:(NSData *)data callback:(void(^)(NSString *path))callback;

/**
 存储图片到本地
 
 @param filename 本地路径 存储到默认路径
 @param image 图片
 @param callback 回调
 */
+ (void)saveWithFilename:(NSString *)filename image:(UIImage *)image callback:(void(^)(NSString *path))callback;

/**
 从默认路径中读取图片
 
 @param filename 图片名
 @param callback 回调
 */
+ (void)readImageWithFilename:(NSString *)filename callback:(void(^)(UIImage *result))callback;

/**
 从默认路径中读取文件
 
 @param filename 文件名
 @param callback 回调
 */
+ (void)readFileWithFilename:(NSString *)filename callback:(void(^)(NSData *result))callback;

/**
 从Path中读取图片
 
 @param path 路径
 @param callback 回调
 */
+ (void)readImageFromPath:(NSString *)path callback:(void(^)(UIImage *result))callback;

/**
 从Path中读取文件
 
 @param path 路径
 @param callback 回调
 */
+ (void)readFileFromPath:(NSString *)path callback:(void(^)(NSData *result))callback;


@end
