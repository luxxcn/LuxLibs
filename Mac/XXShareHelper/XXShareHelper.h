//
//  XXShareHelper.h
//  LuxLibsIOSTest
//
//  Created by xxing on 15/3/12.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXSingleton.h"
#import <UIKit/UIKit.h>
#import "WXApi.h"

#define sShareHelper [XXShareHelper sharedInstance]

@interface XXShareHelper : XXSingleton<WXApiDelegate>

+ (XXShareHelper *)sharedInstance;

- (BOOL) isWechatInstalled;

@end
