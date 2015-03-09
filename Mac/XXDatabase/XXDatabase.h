//
//  XXDatabase.h
//
//  对数据库相关内容进行封装,如：mysql数据库封装
//
//  Created by xxing on 15/2/4.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mysql.h>
#import "XXSingleton.h"

#define sDatabase [XXDatabase sharedInstance] // 单例


@interface XXDatabase : XXSingleton {
    MYSQL *mysql;
}

- (BOOL)initWithHost:(NSString *)host port:(unsigned int)port user:(NSString *)user password:(NSString *)password dbName:(NSString *)dbName;

+ (XXDatabase *)sharedInstance;

- (NSInteger)executeSQLWithFormat:(NSString *)format, ...;
- (NSInteger)executeSQL:(NSString *)sql;

- (NSArray *)queryRowWithFormat:(NSString *)format, ...;
- (NSArray *)queryRow:(NSString *)sql; //一行结果
- (NSArray *)queryResultWithFormat:(NSString *)format, ...;
- (NSArray *)queryResult:(NSString *)sql;

- (NSString *)getLastError;
- (void)close;

@property (strong, nonatomic) NSString *host;   // 保存连接信息用于连接失败后重连
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *dbName;
@property unsigned int port;
@property NSInteger lastError;
@property (strong, nonatomic) NSString *lastErrorInfo;

@end
