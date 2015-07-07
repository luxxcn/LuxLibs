//
//  XXShareHelper.m
//  LuxLibsIOSTest
//
//  Created by xxing on 15/3/12.
//  Copyright (c) 2015年 xxing. All rights reserved.
//
//  微信开放平台地址： open.weixin.qq.com

#import "XXShareHelper.h"

@implementation XXShareHelper

+ (XXShareHelper *)sharedInstance
{
    return (XXShareHelper *)[super sharedInstance];
}

- (BOOL)isWechatInstalled
{
    BOOL bWechatInstalled = [WXApi isWXAppInstalled];
    
    if(!bWechatInstalled)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未安装微信" message:@"该功能需要安装微信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    return bWechatInstalled;
}

- (BOOL)shareImageToWechat:(UIImage *)image
{
    return NO;
}

@end
