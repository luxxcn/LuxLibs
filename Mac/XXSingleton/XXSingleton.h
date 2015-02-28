//
//  XXSingleton.h
//  DownLoadBankNumbers
//
//  单例对象
//
//  Created by xxing on 15/2/7.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0; \
__strong static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = block(); \
}); \
return sharedInstance; \

@interface XXSingleton : NSObject

+(XXSingleton *)sharedInstance;

@end
