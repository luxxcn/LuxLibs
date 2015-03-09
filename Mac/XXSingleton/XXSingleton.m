//
//  XXSingleton.m
//  DownLoadBankNumbers
//
//  Created by xxing on 15/2/7.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import "XXSingleton.h"

@implementation XXSingleton

+ (XXSingleton *)sharedInstance // 继承后重写此方法
{
    static XXSingleton *sharedInstance = nil;
    
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if(self) {
        //单例第一次初始化时调用
    }
    
    return self;
}

@end
