//
//  XXDatabase.m
//  DownLoadBankNumbers
//
//  Created by xxing on 15/2/4.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import "XXDatabase.h"
#import <errmsg.h>



@implementation XXDatabase

+ (XXDatabase *)sharedInstance
{
    return (XXDatabase *)[super sharedInstance];
}

- (BOOL)initWithHost:(NSString *)host port:(unsigned int)port user:(NSString *)user password:(NSString *)password dbName:(NSString *)dbName
{
    _host = host;
    _port = port;
    _user = user;
    _password = password;
    _dbName = dbName;
    _lastError = 0;
    
    mysql = mysql_init(mysql);
    
    MYSQL *connection;
    connection = mysql_real_connect(mysql, [host UTF8String], [user UTF8String], [password UTF8String], [dbName UTF8String], port, 0, 0);
    if(connection)
    {
        mysql_set_character_set(mysql, "utf8");
        return YES;
    }
    return NO;
}

- (NSInteger)executeSQL:(NSString *)sql
{
    NSInteger affectedRows = -1;
    if(mysql)
    {
        _lastError = mysql_query(mysql, [sql UTF8String]);
        if(_lastError == 0) // success
            affectedRows = mysql_affected_rows(mysql);
    }
    
    return affectedRows;
}

- (NSArray *) query:(NSString *)sql
{
    NSArray *row;
    if([self executeSQL:sql] == -1)
    {
        MYSQL_RES *result = mysql_store_result(mysql);
        row = [self fetchRow:result];
    }
    return row;
}

- (NSArray *)queryResults:(NSString *)sql
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if([self executeSQL:sql] == -1)
    {
        MYSQL_RES *result = mysql_store_result(mysql);
        int rowCount = (int)mysql_num_rows(result);
        for(int i = 0; i < rowCount; i++)
        {
            [resultArray addObject:[self fetchRow:result]];
        }
    }
    
    return resultArray;
}

- (NSArray *) fetchRow:(MYSQL_RES *)result
{
    MYSQL_ROW row;
    int fieldCount = mysql_field_count(mysql);
    NSMutableArray *rowArray = [[NSMutableArray alloc] init];
    
    row = mysql_fetch_row(result);
    if(row)
    {
        for(int i = 0; i < fieldCount; i++)
        {
            [rowArray addObject:[NSString stringWithUTF8String:row[i]]];
        }
    }
    row = NULL;
    
    return rowArray;
}

- (NSString *)getLastError
{
    NSString *errorMsg = @"没有错误";
    switch (_lastError) {
        case CR_UNKNOWN_ERROR:
            errorMsg = @"未知错误";
            break;
        case CR_SERVER_GONE_ERROR:
            errorMsg = @"mysql服务器不可用";
            break;
        case CR_SERVER_LOST:
            errorMsg = @"mysql连接丢失";
            break;
        case CR_COMMANDS_OUT_OF_SYNC:
            errorMsg = @"sql语句语法错误";
            break;
        default:
            errorMsg = [NSString stringWithUTF8String:mysql_error(mysql)];
            break;
    }
    
    return errorMsg;
}

- (void)close
{
    mysql_close(mysql);
}

@end
