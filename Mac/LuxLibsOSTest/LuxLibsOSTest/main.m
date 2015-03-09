//
//  main.m
//  LuxLibsOSTest
//
//  Created by xxing on 15/3/9.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXDatabase.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        if([sDatabase initWithHost:@"localhost" port:3306 user:@"lux" password:@"lux123" dbName:@"lux"])
        {
            NSLog(@"[SUCCESS] 连接mysql数据库成功");
            NSArray *result = [sDatabase queryResultWithFormat:@"SELECT * FROM test WHERE b = %d", 11];
            NSLog(@"%@", result[0][2]);
        }
        else
            NSLog(@"[ERROR] %@", [sDatabase getLastError]);
        
        int choose;
        scanf("%d", &choose);
        printf("%d", choose);
        
        [sDatabase close];
    }
    return 0;
}
