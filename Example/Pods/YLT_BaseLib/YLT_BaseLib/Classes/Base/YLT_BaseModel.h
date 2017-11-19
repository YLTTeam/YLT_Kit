//
//  YLT_BaseModel.h
//  Pods-YLT_BaseLib_Example
//
//  Created by YLT_Alex on 2017/10/26.
//

#import <Foundation/Foundation.h>

@interface YLT_BaseModel : NSObject<NSCopying>

/**
 返回当前ORM映射
 */
+ (NSDictionary *)YLT_KeyMapper;

/**
 返回数据中Model的映射
 */
+ (NSDictionary *)YLT_ClassInArray;

/**
 存储对象 存储到默认的KEY下

 @return 存储结果
 */
- (BOOL)save;

/**
 存储对象

 @param key 存储的KEY
 @return 存储结果
 */
- (BOOL)saveForKey:(NSString *)key;

/**
 读取默认key的对象

 @return 对象
 */
+ (id)read;

/**
 根据key读取对象

 @param key 存储的KEY
 @return 对象
 */
+ (id)readForKey:(NSString *)key;


/**
 读取数据到当前对象

 @return 读取结果
 */
- (BOOL)read;

/**
 根据KEY读取数据到当前对象

 @param key 存储的KEY
 @return 结果
 */
- (BOOL)readForKey:(NSString *)key;

/**
 移除当前对象

 @return 结果
 */
- (BOOL)remove;

/**
 根据KEY移除对象

 @param key 存储的KEY
 @return 结果
 */
+ (BOOL)removeForKey:(NSString *)key;

/**
 按对象分组存储 默认分组

 @return 存储结果
 */
- (BOOL)saveToGroup;

/**
 按对象分组存储

 @param key 自定义的KEY
 @return 存储结果
 */
- (BOOL)saveToGroupForKey:(NSString *)key;

/**
 按对象的分组读取 默认分组

 @return 数据
 */
+ (NSArray *)readFromGroup;

/**
 按对象的分组读取

 @param key 自定义的KEY
 @return 数据
 */
+ (NSArray *)readFromGroupForKey:(NSString *)key;


/**
 移除所有的当前Model的对象
 
 @return 移除结果
 */
+ (BOOL)removeAll;

@end
