//
//  YLT_DBHelper.m
//  MJExtension
//
//  Created by YLT_Alex on 2017/11/3.
//

#import "YLT_DBHelper.h"
#import <sqlite3.h>

@implementation YLT_DBHelper

YLT_ShareInstance(YLT_DBHelper);

- (void)YLT_init {
}

- (NSString *)dbPath {
    if (!_dbPath) {
        _dbPath = [YLT_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", YLT_BundleIdentifier]];
    }
    return _dbPath;
}

- (FMDatabaseQueue *)databaseQueue {
    if (!_databaseQueue) {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[YLT_DBHelper shareInstance].dbPath];
    }
    return _databaseQueue;
}

@end
