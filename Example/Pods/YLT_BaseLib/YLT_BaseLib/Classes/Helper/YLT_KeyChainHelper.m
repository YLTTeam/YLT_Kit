//
//  YLT_KeyChainHelper.m
//  MJExtension
//
//  Created by YLT_Alex on 2017/10/26.
//

#import "YLT_KeyChainHelper.h"

@implementation YLT_KeyChainHelper

YLT_ShareInstance(YLT_KeyChainHelper);

- (void)YLT_init {
}

+ (NSMutableDictionary *)YLT_getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)YLT_saveKeychainValue:(NSString *)aValue key:(NSString *)aKey{
    if (!aKey) {
        return ;
    }
    if(!aValue) {
        aValue = @"";
    }
    NSMutableDictionary * keychainQuery = [self YLT_getKeychainQuery:aKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:aValue] forKey:(__bridge_transfer id)kSecValueData];
    
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
}

+ (NSString *)YLT_readValueWithKeychain:(NSString *)aKey
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self YLT_getKeychainQuery:aKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            YLT_LogWarn(@"Unarchive of %@ failed: %@", aKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)YLT_deleteKeychainValue:(NSString *)aKey {
    NSMutableDictionary *keychainQuery = [self YLT_getKeychainQuery:aKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

+ (NSString *)YLT_uuid {
    NSString *deviceId = [YLT_KeyChainHelper YLT_readValueWithKeychain:@"Key_DeviceUUIDString"];
    if (!deviceId || !deviceId.length) {
        deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [YLT_KeyChainHelper YLT_saveKeychainValue:deviceId key:@"Key_DeviceUUIDString"];
    }
    return deviceId;
}

@end
