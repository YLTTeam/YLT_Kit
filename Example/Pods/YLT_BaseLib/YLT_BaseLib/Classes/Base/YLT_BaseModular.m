//
//  YLT_BaseModular.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/23.
//

#import "YLT_BaseModular.h"
#import "YLT_BaseMacro.h"

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

@implementation YLT_BaseModular

- (void)YLT_init {
}

+ (void)applicationDidFinishLaunching:(UIApplication *)application {
    
}
#if UIKIT_STRING_ENUMS
+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions  {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    
    return YES;
}
#else
+ (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions  {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}
#endif

+ (void)applicationDidBecomeActive:(UIApplication *)application {
    
}
+ (void)applicationWillResignActive:(UIApplication *)application {
    
}
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return YES;
}
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options  {
    
    return YES;
}

+ (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}
+ (void)applicationWillTerminate:(UIApplication *)application {
    
}
+ (void)applicationSignificantTimeChange:(UIApplication *)application {
    
}

+ (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    
}
+ (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    
}

+ (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    
}
+ (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    
}

+ (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    
}

+ (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler  {
    
}

+ (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
}

+ (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    
}

+ (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler  {
    
}

+ (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary * __replyInfo))reply {
    
}

+ (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application  {
    
}

+ (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {
    
}

+ (void)applicationDidEnterBackground:(UIApplication *)application {
    
}
+ (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

+ (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    
}
+ (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    
}

+ (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskAll;
}
+ (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier  {
    
    return YES;
}

#pragma mark -+ State Restoration protocol adopted by UIApplication delegate --

+ (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder  {
    
    return self.YLT_CurrentVC;
}
+ (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder  {
    
    return YES;
}
+ (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder  {
    
    return YES;
}
+ (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder  {
    
}
+ (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder  {
    
}

#pragma mark -+ User Activity Continuation protocol adopted by UIApplication delegate --

+ (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType  {
    
    return YES;
}

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __restorableObjects))restorationHandler  {
    
    return YES;
}

+ (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error  {
    
}

+ (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity  {
    
}

#pragma mark -+ CloudKit Sharing Invitation Handling --

+ (void) application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata  {
    
}

+ (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
}
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
}

@end

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
