//
//  YLT_PhotoHelper.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/9.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "YLT_BaseMacro.h"

@interface YLT_PhotoAlbumInfo : NSObject

@property (nonatomic, strong) PHAssetCollection *assetCollection;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) PHAsset *thumb;

@end

@interface YLT_PhotoHelper : NSObject

YLT_ShareInstanceHeader(YLT_PhotoHelper);

/**
 是否可以编辑 默认NO
 */
@property (nonatomic, assign) BOOL allowsEditing;

/**
 所有相册的基本信息 包括名称 name 数量 count 缩略图 thumb
 */
@property (nonatomic, copy) NSMutableArray *allAlbumInfo;

/**
 所有相册
 */
@property (nonatomic, copy) NSMutableArray *allAlbums;

/**
 使用照相机
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)YLT_PhotoFromCameraAllowEdit:(BOOL)allowEdit
                             success:(void(^)(NSDictionary *info))success
                              failed:(void(^)(NSError *error))failed;

/**
 使用相册
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)YLT_PhotoFromLibraryAllowEdit:(BOOL)allowEdit
                              success:(void(^)(NSDictionary *info))success
                               failed:(void(^)(NSError *error))failed;

/**
 获取系统相册
 
 @param callback 获取系统相册的回调
 */
+ (void)YLT_CameraRoll:(void(^)(PHAssetCollection *cameraRoll))callback;

/**
 获取系统相册权限
 
 @param callback 获取到系统相册权限的回调
 */
+ (void)YLT_CheckAuthorizationStatus:(void(^)(PHAuthorizationStatus status))callback;

/**
 加载所有相册
 
 @param finish 相册加载成功的block
 @param error 相册加载失败的block
 */
+ (void)YLT_LoadAlbums:(void(^)(NSArray *albums))finish
                 error:(void(^)(NSString *error))error;

/**
 获取一个相册中的照片
 
 @param album 指定的相册
 @param finish 照片获取成功的回调
 @param error 照片获取失败的回调
 */
+ (void)YLT_LoadPhotosFromAlbum:(PHAssetCollection *)album
                         finish:(void(^)(NSArray *photos))finish
                          error:(void(^)(NSString *error))error;


/**
 加载缩略图
 
 @param asset asset
 @param finish 加载成功的回调
 @param error 加载失败的回调
 */
+ (void)YLT_LoadThumbnailFromAsset:(PHAsset *)asset
                            finish:(void(^)(UIImage *result, NSDictionary *info))finish
                             error:(void(^)(NSString *error))error;

/**
 加载原图
 
 @param asset asset
 @param finish 加载成功的回调
 @param error 加载失败的回调
 */
+ (void)YLT_LoadOriginalFromAsset:(PHAsset *)asset
                           finish:(void(^)(UIImage *result, NSDictionary *info))finish
                            error:(void(^)(NSString *error))error;


/**
 加载固定size的图片
 
 @param asset asset
 @param size size
 @param finish 成功回调
 @param error 失败回调
 */
+ (void)YLT_LoadSizePhotoFromAsset:(PHAsset *)asset
                              size:(CGSize)size
                            finish:(void(^)(UIImage *result, NSDictionary *info))finish
                             error:(void(^)(NSString *error))error;



@end

