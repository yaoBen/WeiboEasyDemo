//
//  StatusTool.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/11.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "StatusTool.h"
#import "FMDB.h"
@implementation StatusTool
static FMDatabase *_db;
+ (void)initialize
{
    // 打开数据库
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"status.data"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    // 创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
}
+ (NSArray *)statusesWithParams:(NSDictionary *)params
{
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20",params[@"since_id"]];
    }else if (params[@"max_id"]){
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20",params[@"max_id"]];
    }else{
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20"];
    }
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        
        [statuses addObject:status];
    }
    
    return statuses;
}
+ (void)saveStatuses:(NSArray *)statuses
{
    for (int i = 0; i < statuses.count ; i ++) {
        NSDictionary *status = statuses[i];
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        [_db executeUpdateWithFormat:@"INSERT INTO t_status (status, idstr) VALUES (%@, %@)",statusData,status[@"idstr"]];
    }
}
@end
