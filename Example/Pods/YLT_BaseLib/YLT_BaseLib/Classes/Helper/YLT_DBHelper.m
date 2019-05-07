//
//  YLT_DBHelper.m
//  MJExtension
//
//  Created by YLT_Alex on 2017/11/3.
//

#import "YLT_DBHelper.h"
#import <sqlite3.h>

@interface YLT_DBHelper () {
}

@end

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

- (NSString *)ylt_userDbPath {
    if (!_ylt_userDbPath) {
        _ylt_userDbPath = [YLT_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.db", self.ylt_userPath?:@"", YLT_BundleIdentifier]];
    }
    return _ylt_userDbPath;
}

- (FMDatabaseQueue *)ylt_userDbQueue {
    if (!_ylt_userDbQueue) {
        _ylt_userDbQueue = [FMDatabaseQueue databaseQueueWithPath:self.ylt_userDbPath];
    }
    return _ylt_userDbQueue;
}

- (void)ylt_dbReset {
    self.ylt_userPath = nil;
    self.ylt_userDbPath = nil;
    self.ylt_userDbQueue = nil;
}

@end
