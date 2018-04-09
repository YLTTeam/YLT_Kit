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

- (void)ylt_init {
}

- (NSString *)ylt_dbPath {
    if (!_ylt_dbPath) {
        _ylt_dbPath = [YLT_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", YLT_BundleIdentifier]];
    }
    return _ylt_dbPath;
}

- (FMDatabaseQueue *)ylt_databaseQueue {
    if (!_ylt_databaseQueue) {
        _ylt_databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    return _ylt_databaseQueue;
}

@end
