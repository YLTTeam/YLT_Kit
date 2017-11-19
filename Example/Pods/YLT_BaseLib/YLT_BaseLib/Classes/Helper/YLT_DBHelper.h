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
@property (nonatomic, strong) NSString *dbPath;

/**
 数据库队列
 */
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end
