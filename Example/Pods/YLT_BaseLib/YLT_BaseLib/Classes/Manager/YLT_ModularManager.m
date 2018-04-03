//
//  YLT_ModularManager.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/23.
//

#import "YLT_ModularManager.h"

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

@interface YLT_ModularManager() {
}
/**
 模块列表
 */
@property (nonatomic, strong) NSMutableArray *modularList;

YLT_ShareInstanceHeader(YLT_ModularManager);

@end

@implementation YLT_ModularManager

YLT_ShareInstance(YLT_ModularManager);

- (void)YLT_init {
}

- (NSMutableArray *)modularList {
    if (!_modularList) {
        _modularList = [[NSMutableArray alloc] init];
    }
    return _modularList;
}
/**
 模块初始化

 @param plistPath 路径
 */
+ (void)modularWithPlistPath:(NSString *)plistPath {
    [[NSArray arrayWithContentsOfFile:plistPath] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[YLT_ModularManager shareInstance].modularList addObject:NSClassFromString(obj)];
    }];
}



+ (void)applicationDidFinishLaunching:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
            [cls applicationDidFinishLaunching:application];
        }
    }
}
#if UIKIT_STRING_ENUMS
+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
            [cls application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [cls application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}
#else
+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
            [cls application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [cls application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}
#endif

+ (void)applicationDidBecomeActive:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [cls applicationDidBecomeActive:application];
        }
    }
}
+ (void)applicationWillResignActive:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationWillResignActive:)]) {
            [cls applicationWillResignActive:application];
        }
    }
}
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleOpenURL:)]) {
            [cls application:application handleOpenURL:url];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            [cls application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return YES;
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:openURL:options:)]) {
            [cls application:application openURL:url options:options];
        }
    }
    return YES;
}

+ (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            [cls applicationDidReceiveMemoryWarning:application];
        }
    }
}
+ (void)applicationWillTerminate:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationWillTerminate:)]) {
            [cls applicationWillTerminate:application];
        }
    }
}
+ (void)applicationSignificantTimeChange:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationSignificantTimeChange:)]) {
            [cls applicationSignificantTimeChange:application];
        }
    }
}

+ (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:willChangeStatusBarOrientation:duration:)]) {
            [cls application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
        }
    }
}
+ (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didChangeStatusBarOrientation:)]) {
            [cls application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
        }
    }
}

+ (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:willChangeStatusBarFrame:)]) {
            [cls application:application willChangeStatusBarFrame:newStatusBarFrame];
        }
    }
}
+ (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didChangeStatusBarFrame:)]) {
            [cls application:application didChangeStatusBarFrame:oldStatusBarFrame];
        }
    }
}

+ (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]) {
            [cls application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [cls application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
            [cls application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [cls application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didReceiveLocalNotification:)]) {
            [cls application:application didReceiveLocalNotification:notification];
        }
    }
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:withResponseInfo:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:)]) {
            [cls application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
            [cls application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]) {
            [cls application:application performFetchWithCompletionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:performActionForShortcutItem:completionHandler:)]) {
            [cls application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]) {
            [cls application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

+ (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary * __replyInfo))reply {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleWatchKitExtensionRequest:reply:)]) {
            [cls application:application handleWatchKitExtensionRequest:userInfo reply:reply];
        }
    }
}

+ (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationShouldRequestHealthAuthorization:)]) {
            [cls applicationShouldRequestHealthAuthorization:application];
        }
    }
}

+ (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:handleIntent:completionHandler:)]) {
            [cls application:application handleIntent:intent completionHandler:completionHandler];
        }
    }
}

+ (void)applicationDidEnterBackground:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [cls applicationDidEnterBackground:application];
        }
    }
}
+ (void)applicationWillEnterForeground:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [cls applicationWillEnterForeground:application];
        }
    }
}

+ (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationProtectedDataWillBecomeUnavailable:)]) {
            [cls applicationProtectedDataWillBecomeUnavailable:application];
        }
    }
}
+ (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)]) {
            [cls applicationProtectedDataDidBecomeAvailable:application];
        }
    }
}

+ (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)]) {
            [cls application:application supportedInterfaceOrientationsForWindow:window];
        }
    }
    return UIInterfaceOrientationMaskAll;
}
+ (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:shouldAllowExtensionPointIdentifier:)]) {
            [cls application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
        }
    }
    return YES;
}

#pragma mark -+ State Restoration protocol adopted by UIApplication delegate --

+ (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:viewControllerWithRestorationIdentifierPath:coder:)]) {
            [cls application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder];
        }
    }
    return self.YLT_CurrentVC;
}
+ (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:shouldSaveApplicationState:)]) {
            [cls application:application shouldSaveApplicationState:coder];
        }
    }
    return YES;
}
+ (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:shouldRestoreApplicationState:)]) {
            [cls application:application shouldRestoreApplicationState:coder];
        }
    }
    return YES;
}
+ (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:willEncodeRestorableStateWithCoder:)]) {
            [cls application:application willEncodeRestorableStateWithCoder:coder];
        }
    }
}
+ (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didDecodeRestorableStateWithCoder:)]) {
            [cls application:application didDecodeRestorableStateWithCoder:coder];
        }
    }
}

#pragma mark -+ User Activity Continuation protocol adopted by UIApplication delegate --

+ (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:willContinueUserActivityWithType:)]) {
            [cls application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return YES;
}

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __restorableObjects))restorationHandler  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)]) {
            [cls application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return YES;
}

+ (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didFailToContinueUserActivityWithType:error:)]) {
            [cls application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

+ (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:didUpdateUserActivity:)]) {
            [cls application:application didUpdateUserActivity:userActivity];
        }
    }
}

#pragma mark -+ CloudKit Sharing Invitation Handling --

+ (void) application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata  {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(application:userDidAcceptCloudKitShareWithMetadata:)]) {
            [cls application:application userDidAcceptCloudKitShareWithMetadata:cloudKitShareMetadata];
        }
    }
}

+ (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
            [cls userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
        }
    }
}
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    for (Class cls in [YLT_ModularManager shareInstance].modularList) {
        if ([cls respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
            [cls userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }
}

@end
#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
