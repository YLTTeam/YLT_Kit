//
//  YLT_LogHelper.m
//  FastCoding
//
//  Created by 項普華 on 2019/3/12.
//

#import "YLT_LogHelper.h"

@implementation YLT_LogModel

- (id)init {
    self = [super init];
    if (self) {
        self.logId = 0;
        self.log = @"";
        self.mark = @"";
        self.time = 0;
        self.dateTime = @"";
    }
    return self;
}

+ (NSDictionary *)ylt_keyMapper {
    NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

+ (NSDictionary *)ylt_classInArray {
    NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

- (NSInteger)saveDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    NSInteger result = 0;
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS DB_YLT_LogModel(logId INTEGER PRIMARY KEY AUTOINCREMENT, log TEXT, mark TEXT, time INTEGER, dateTime TEXT)"];
    result = [db executeUpdate:@"INSERT INTO DB_YLT_LogModel(log,mark,time,dateTime) VALUES (?,?,?,?)", self.log, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime];
    result = [db lastInsertRowId];
    if (sync) {
        [db close];
    }
    return result;
}

- (BOOL)delDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:@"DELETE FROM DB_YLT_LogModel WHERE logId = ?", [NSNumber numberWithInteger:self.logId]];
    if (sync) {
        [db close];
    }
    return result;
}

+ (BOOL)delDB:(FMDatabase *)db forConditions:(NSString *)sender {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM DB_YLT_LogModel WHERE %@", sender]];
    if (sync) {
        [db close];
    }
    return result;
}

- (BOOL)updateDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:@"UPDATE DB_YLT_LogModel SET  log = ?, mark = ?, time = ?, dateTime = ? WHERE logId = ?", self.log, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime, [NSNumber numberWithInteger:self.logId]];
    if (sync) {
        [db close];
    }
    return result;
}

+ (BOOL)updateDB:(FMDatabase *)db forConditions:(NSString *)sender {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:[NSString stringWithFormat:@"UPDATE DB_YLT_LogModel SET %@", sender]];
    if (sync) {
        [db close];
    }
    return result;
}

+ (NSArray *)findDB:(FMDatabase *)db forConditions:(NSString *)sender {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return nil;
    }
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet* set;
    if (sender.length == 0) {
        set = [db executeQuery:@"SELECT * FROM DB_YLT_LogModel"];
    }
    else {
        set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM DB_YLT_LogModel WHERE %@", sender]];
    }
    while ([set next]) {
        YLT_LogModel *item = [[YLT_LogModel alloc] init];
        item.logId = [set intForColumn:@"logId"];
        item.log = [set stringForColumn:@"log"];
        item.mark = [set stringForColumn:@"mark"];
        item.time = [set intForColumn:@"time"];
        item.dateTime = [set stringForColumn:@"dateTime"];
        [result addObject:item];
    }
    if (sync) {
        [db close];
    }
    return result;
}

+ (NSInteger)maxKeyValueDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    FMResultSet* set = [db executeQuery:@"SELECT MAX(CAST(logId as INT)) FROM DB_YLT_LogModel"];
    NSInteger result = 0;
    if ([set next]) {
        result = [set intForColumnIndex:0];
    }
    if (sync) {
        [db close];
    }
    return result;
}

@end


@implementation YLT_APILogModel

- (id)init {
    self = [super init];
    if (self) {
        self.logId = 0;
        self.url = @"";
        self.parameters = @"";
        self.result = @"";
        self.mark = @"";
        self.time = 0;
        self.dateTime = @"";
    }
    return self;
}

+ (NSDictionary *)ylt_keyMapper {
    NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

+ (NSDictionary *)ylt_classInArray {
    NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

- (NSInteger)saveDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    NSInteger result = 0;
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS DB_YLT_APILogModel(logId INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, parameters TEXT, result TEXT, mark TEXT, time INTEGER, dateTime TEXT)"];
    result = [db executeUpdate:@"INSERT INTO DB_YLT_APILogModel(url,parameters,result,mark,time,dateTime) VALUES (?,?,?,?,?,?)", self.url, self.parameters, self.result, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime];
    result = [db lastInsertRowId];
    if (sync) {
        [db close];
    }
    return result;
}

- (BOOL)delDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:@"DELETE FROM DB_YLT_APILogModel WHERE logId = ?", [NSNumber numberWithInteger:self.logId]];
    if (sync) {
        [db close];
    }
    return result;
}

+ (BOOL)delDB:(FMDatabase *)db forConditions:(NSString *)sender {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM DB_YLT_APILogModel WHERE %@", sender]];
    if (sync) {
        [db close];
    }
    return result;
}

- (BOOL)updateDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:@"UPDATE DB_YLT_APILogModel SET  url = ?, parameters = ?, result = ?, mark = ?, time = ?, dateTime = ? WHERE logId = ?", self.url, self.parameters, self.result, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime, [NSNumber numberWithInteger:self.logId]];
    if (sync) {
        [db close];
    }
    return result;
}

+ (BOOL)updateDB:(FMDatabase *)db forConditions:(NSString *)sender {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    BOOL result = NO;
    result = [db executeUpdate:[NSString stringWithFormat:@"UPDATE DB_YLT_APILogModel SET %@", sender]];
    if (sync) {
        [db close];
    }
    return result;
}

+ (NSArray *)findDB:(FMDatabase *)db forConditions:(NSString *)sender {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return nil;
    }
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet* set;
    if (sender.length == 0) {
        set = [db executeQuery:@"SELECT * FROM DB_YLT_APILogModel"];
    }
    else {
        set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM DB_YLT_APILogModel WHERE %@", sender]];
    }
    while ([set next]) {
        YLT_APILogModel *item = [[YLT_APILogModel alloc] init];
        item.logId = [set intForColumn:@"logId"];
        item.url = [set stringForColumn:@"url"];
        item.parameters = [set stringForColumn:@"parameters"];
        item.result = [set stringForColumn:@"result"];
        item.mark = [set stringForColumn:@"mark"];
        item.time = [set intForColumn:@"time"];
        item.dateTime = [set stringForColumn:@"dateTime"];
        [result addObject:item];
    }
    if (sync) {
        [db close];
    }
    return result;
}

+ (NSInteger)maxKeyValueDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
        return 0;
    }
    FMResultSet* set = [db executeQuery:@"SELECT MAX(CAST(logId as INT)) FROM DB_YLT_APILogModel"];
    NSInteger result = 0;
    if ([set next]) {
        result = [set intForColumnIndex:0];
    }
    if (sync) {
        [db close];
    }
    return result;
}

@end

@implementation YLT_LogHelper

/**
 清空日志
 */
+ (void)clearLogDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
    }
    [db executeUpdate:@"DROP TABLE IF NOT EXISTS DB_YLT_APILogModel"];
    [db executeUpdate:@"DROP TABLE IF NOT EXISTS DB_YLT_LogModel"];
    [db close];
}

@end
