//
//  YLT_PhotoHelper.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/9.
//

#import "YLT_PhotoHelper.h"
#import <UIKit/UIKit.h>
#import "NSObject+YLT_BaseObject.h"
#import "YLT_AuthorizationHelper.h"
#import "NSString+YLT_BaseString.h"

@implementation YLT_PhotoAlbumInfo

@end

@interface YLT_PhotoHelper()<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
}

@property (nonatomic, copy) void(^success)(NSDictionary *info);
@property (nonatomic, copy) void(^failed)(NSError *error);

@property (nonatomic, strong) UIImagePickerController *pickerVC;
@property (nonatomic, strong) NSArray *albums;

@end

@implementation YLT_PhotoHelper

YLT_ShareInstance(YLT_PhotoHelper);

- (void)YLT_init {
}
/**
 使用照相机
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)YLT_PhotoFromCameraAllowEdit:(BOOL)allowEdit
                             success:(void(^)(NSDictionary *info))success
                              failed:(void(^)(NSError *error))failed {
    [YLT_PhotoHelper shareInstance].success = success;
    [YLT_PhotoHelper shareInstance].failed = failed;
    [[YLT_AuthorizationHelper shareInstance] YLT_AuthorizationType:YLT_Camera success:^{
        [YLT_PhotoHelper shareInstance].pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [YLT_PhotoHelper shareInstance].pickerVC.allowsEditing = allowEdit;
        [[YLT_PhotoHelper shareInstance].YLT_CurrentVC presentViewController:[YLT_PhotoHelper shareInstance].pickerVC animated:YES completion:nil];
    } failed:^{
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:PHAuthorizationStatusDenied userInfo:@{NSLocalizedDescriptionKey:@"无权限访问"}];
        [YLT_PhotoHelper shareInstance].failed(error);
    }];
    
}

;

/**
 使用相册
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)YLT_PhotoFromLibraryAllowEdit:(BOOL)allowEdit
                              success:(void(^)(NSDictionary *info))success
                               failed:(void(^)(NSError *error))failed {
    [YLT_PhotoHelper shareInstance].success = success;
    [YLT_PhotoHelper shareInstance].failed = failed;
    [[YLT_AuthorizationHelper shareInstance] YLT_AuthorizationType:YLT_PhotoLibrary success:^{
        [YLT_PhotoHelper shareInstance].pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [YLT_PhotoHelper shareInstance].pickerVC.allowsEditing = allowEdit;
        [[YLT_PhotoHelper shareInstance].YLT_CurrentVC presentViewController:[YLT_PhotoHelper shareInstance].pickerVC animated:YES completion:nil];
    } failed:^{
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:PHAuthorizationStatusDenied userInfo:@{NSLocalizedDescriptionKey:@"无权限访问"}];
        [YLT_PhotoHelper shareInstance].failed(error);
    }];
}

/**
 获取系统相册
 
 @param callback 获取系统相册的回调
 */
+ (void)YLT_CameraRoll:(void(^)(PHAssetCollection *cameraRoll))callback {
    for (PHAssetCollection *asset in [YLT_PhotoHelper shareInstance].albums) {
        if ((asset.assetCollectionType == PHAssetCollectionTypeSmartAlbum) && (asset.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary)) {
            callback(asset);
        }
    }
}

+ (void)YLT_RequestAuthorizationStatus:(void(^)(PHAuthorizationStatus status))callback {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        callback(status);
    }];
}

/**
 加载所有相册
 
 @param finish 相册加载成功的block
 @param error 相册加载失败的block
 */
+ (void)YLT_LoadAlbums:(void(^)(NSArray *albums))finish
                 error:(void(^)(NSString *error))error {
    [[YLT_AuthorizationHelper shareInstance] YLT_AuthorizationType:YLT_PhotoLibrary success:^{
        if ([YLT_PhotoHelper shareInstance].albums.count == 0) {
            error(@"相册为空");
        } else {
            finish([YLT_PhotoHelper shareInstance].albums);
        }
    } failed:^{
        error(@"无权限访问");
    }];
}

+ (NSMutableArray *)YLT_AllAlbums {
    NSMutableArray *albums = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
            if (fetchResult.count > 0&&collection.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumVideos && collection.assetCollectionSubtype !=PHAssetCollectionSubtypeSmartAlbumTimelapses) {
                [albums addObject:collection];
            }
        } else {
            NSAssert1(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }];
    
    //所有用户创建的相册
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
            if (fetchResult.count > 0) {
                [albums addObject:collection];
            }
        }
        else {
            NSAssert1(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }];
    
    for (int i = 0; i < albums.count; i++) {
        for (int j = i; j < albums.count; j++) {
            PHFetchResult *fetchResult1 = [PHAsset fetchAssetsInAssetCollection:albums[i] options:nil];
            PHFetchResult *fetchResult2 = [PHAsset fetchAssetsInAssetCollection:albums[j] options:nil];
            if (fetchResult1.count < fetchResult2.count) {
                [albums exchangeObjectAtIndex:j withObjectAtIndex:i];
            }
        }
    }
    
    return albums;
}

/**
 获取一个相册中的照片
 
 @param album 指定的相册
 @param finish 照片获取成功的回调
 @param error 照片获取失败的回调
 */
+ (void)YLT_LoadPhotosFromAlbum:(PHAssetCollection *)album
                         finish:(void(^)(NSArray *photos))finish
                          error:(void(^)(NSString *error))error {
    [[YLT_AuthorizationHelper shareInstance] YLT_AuthorizationType:YLT_PhotoLibrary success:^{
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:album options:options];
        if (assets.count != 0) {
            NSMutableArray *photos = [NSMutableArray array];
            [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[PHAsset class]]) {
                    [photos addObject:obj];
                }
            }];
            finish(photos);
        } else {
            error(@"相片为空");
        }
    } failed:^{
        error(@"无权限访问");
    }];
}

/**
 加载缩略图
 
 @param asset asset
 @param finish 加载成功的回调
 @param error 加载失败的回调
 */
+ (void)YLT_LoadThumbnailFromAsset:(PHAsset *)asset
                            finish:(void(^)(UIImage *result, NSDictionary *info))finish
                             error:(void(^)(NSString *error))error {
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake((YLT_SCREEN_WIDTH-15)/3, (YLT_SCREEN_WIDTH-15)/3) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(result, info);
        });
    }];
}

/**
 加载原图
 
 @param asset asset
 @param finish 加载成功的回调
 @param error 加载失败的回调
 */
+ (void)YLT_LoadOriginalFromAsset:(PHAsset *)asset
                           finish:(void(^)(UIImage *result, NSDictionary *info))finish
                            error:(void(^)(NSString *error))error {
    static PHImageRequestOptions *originalOptions;
    if (!originalOptions) {
        originalOptions = [[PHImageRequestOptions alloc] init];
        originalOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        originalOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        originalOptions.synchronous = NO;
        originalOptions.networkAccessAllowed = YES;
        originalOptions.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        };
    }
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:originalOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        finish(result, info);
    }];
}

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
                             error:(void(^)(NSString *error))error {
    size.height = size.width*asset.pixelHeight/asset.pixelWidth;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(result, info);
        });
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([YLT_PhotoHelper shareInstance].success) {
        [YLT_PhotoHelper shareInstance].success(info);
    }
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"用户取消"}];
    [YLT_PhotoHelper shareInstance].failed(error);
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - get

- (NSMutableArray *)allAlbumInfo {
    if (!_allAlbumInfo) {
        _allAlbumInfo = [[NSMutableArray alloc] init];
        for (PHAssetCollection *album in self.allAlbums) {
            if (([album.localizedTitle YLT_CheckString])) {
                PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:album options:nil];
                if (assets.count > 0) {
                    YLT_PhotoAlbumInfo *info = [[YLT_PhotoAlbumInfo alloc] init];
                    info.assetCollection = album;
                    info.name = album.localizedTitle;
                    info.count = assets.count;
                    info.thumb = [assets lastObject];
                    [_allAlbumInfo addObject:info];
                }
            }
        }
    }
    return _allAlbumInfo;
}

- (NSMutableArray *)allAlbums {
    if (!_allAlbums) {
        _allAlbums = [YLT_PhotoHelper YLT_AllAlbums];
    }
    return _allAlbums;
}

- (void)setAllowsEditing:(BOOL)allowsEditing {
    _allowsEditing = allowsEditing;
    self.pickerVC.allowsEditing = allowsEditing;
}

- (UIImagePickerController *)pickerVC {
    if (!_pickerVC) {
        _pickerVC = [[UIImagePickerController alloc] init];
        _pickerVC.delegate = self;
    }
    return _pickerVC;
}

@end

