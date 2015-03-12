//
//  XXShareHelper.h
//  LuxLibsIOSTest
//
//  Created by xxing on 15/3/12.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXSingleton.h"

#define sShareHelper [XXShareHelper sharedInstance]

@interface XXShareHelper : XXSingleton

- (BOOL)isWechatInstalled;

@end
