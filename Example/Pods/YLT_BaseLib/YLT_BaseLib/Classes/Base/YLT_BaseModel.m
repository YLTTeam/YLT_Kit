//
//  YLT_BaseModel.m
//  Pods-YLT_BaseLib_Example
//
//  Created by YLT_Alex on 2017/10/26.
//

#import "YLT_BaseModel.h"
#import <MJExtension/MJExtension.h>
#import "YLT_BaseMacro.h"
#import <objc/message.h>
#import "NSString+YLT_BaseString.h"

#define OBJECT_MEMORY_KEY [NSString stringWithFormat:@"YLT_OBJECT_SYSTEM_%@_%@", YLT_BundleIdentifier, NSStringFromClass([self class])]
#define GROUP_MEMORY_KEY [NSString stringWithFormat:@"YLT_GROUP_SYSTEM_%@_%@", YLT_BundleIdentifier, NSStringFromClass([self class])]

@implementation YLT_BaseModel

#pragma mark - system
- (instancetype)copyWithZone:(NSZone *)zone {
    return [[self class] mj_objectWithKeyValues:self.mj_keyValues];
}

#pragma mark - ORM
/**
 返回当前ORM映射
 */
+ (NSDictionary *)YLT_KeyMapper {
    return @{};
}

/**
 返回数据中Model的映射
 */
+ (NSDictionary *)YLT_ClassInArray {
    return @{};
}

#pragma mark - MJMethod
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [[self class] YLT_KeyMapper];
}

+ (NSDictionary *)mj_objectClassInArray {
    return [[self class] YLT_ClassInArray];
}

/**
 存储对象 存储到默认的KEY下
 
 @return 存储结果
 */
- (BOOL)save {
    return [self saveForKey:OBJECT_MEMORY_KEY];
}

/**
 存储对象
 
 @param key 存储的KEY
 @return 存储结果
 */
- (BOOL)saveForKey:(NSString *)key {
    NSDictionary *data = self.mj_keyValues;
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 读取默认key的对象
 
 @return 对象
 */
+ (id)read {
    return [self readForKey:OBJECT_MEMORY_KEY];
}

/**
 根据key读取对象
 
 @param key 存储的KEY
 @return 对象
 */
+ (id)readForKey:(NSString *)key {
    if ([key YLT_CheckString]) {
        NSDictionary *data = nil;
        if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
            data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        }
        id result = nil;
        if (data) {
            @try {
                result = [[self class] mj_objectWithKeyValues:data];
            } @catch (NSException *exception) {
                YLT_LogError(@"%@", exception);
            } @finally {
                return result;
            }
        }
        return result;
    }
    return nil;
}


/**
 读取数据到当前对象
 
 @return 读取结果
 */
- (BOOL)read {
    return [self readForKey:OBJECT_MEMORY_KEY];
}

/**
 根据KEY读取数据到当前对象
 
 @param key 存储的KEY
 @return 结果
 */
- (BOOL)readForKey:(NSString *)key {
    if ([key YLT_CheckString]) {
        NSDictionary *data = nil;
        if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
            data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        }
        if (data) {
            @try {
                [self mj_setKeyValues:data];
            } @catch (NSException *exception) {
                YLT_LogError(@"%@", exception);
            } @finally {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}

/**
 移除当前对象
 
 @return 结果
 */
- (BOOL)remove {
    return [[self class] removeForKey:OBJECT_MEMORY_KEY];
}

/**
 根据KEY移除对象
 
 @param key 存储的KEY
 @return 结果
 */
+ (BOOL)removeForKey:(NSString *)key {
    if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        return [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}

/**
 按对象分组存储 默认分组
 
 @return 存储结果
 */
- (BOOL)saveToGroup {
    return [self saveToGroupForKey:GROUP_MEMORY_KEY];
}

/**
 按对象分组存储
 
 @param key 自定义的KEY
 @return 存储结果
 */
- (BOOL)saveToGroupForKey:(NSString *)key {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] && [[[NSUserDefaults standardUserDefaults] objectForKey:key] isKindOfClass:[NSArray class]]) {
        [list addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    }
    [list addObject:[self mj_keyValues]];
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 按对象的分组读取 默认分组
 
 @return 数据
 */
+ (NSArray *)readFromGroup {
    return [self readFromGroupForKey:GROUP_MEMORY_KEY];
}

/**
 按对象的分组读取
 
 @param key 自定义的KEY
 @return 数据
 */
+ (NSArray *)readFromGroupForKey:(NSString *)key {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] && [[[NSUserDefaults standardUserDefaults] objectForKey:key] isKindOfClass:[NSArray class]]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return @[];
}


/**
 移除所有的当前Model的对象
 
 @return 移除结果
 */
+ (BOOL)removeAll {
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in defaults.allKeys) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    return [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
