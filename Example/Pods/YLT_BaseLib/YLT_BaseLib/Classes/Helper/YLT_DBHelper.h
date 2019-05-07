//
//  YLT_DBHelper.h
//  MJExtension
//
//  Created by YLT_Alex on 2017/11/3.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import <objc/message.h>
#import "YLT_BaseMacro.h"

@interface YLT_DBHelper : NSObject

YLT_ShareInstanceHeader(YLT_DBHelper);

/**
 数据库路径
 */
@property (nonatomic, copy) NSString *ylt_dbPath;

/**
 数据库队列
 */
@property (nonatomic, strong) FMDatabaseQueue *ylt_databaseQueue;

/**
 用户相关路径:可用 cardNum/userId 等
 */
@property (nonatomic, copy) NSString *ylt_userPath;

/**
 数据库路径
 */
@property (nonatomic, copy) NSString *ylt_userDbPath;

/**
 用户关联数据库
 */
@property (nonatomic, strong) FMDatabaseQueue *ylt_userDbQueue;

/**
 重置用户关联数据库
 */
- (void)ylt_dbReset;

@end
