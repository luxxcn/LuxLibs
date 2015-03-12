//
//  ViewController.m
//  LuxLibsIOSTest
//
//  Created by xxing on 15/3/9.
//  Copyright (c) 2015年 xxing. All rights reserved.
//

#import "ViewController.h"
#import "XXShareHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [sShareHelper isWechatInstalled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
