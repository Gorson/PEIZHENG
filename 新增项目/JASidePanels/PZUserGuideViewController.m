//
//  TCUserGuideViewController.m
//  IpiaoSNS
//
//  Created by 朱 欣 on 13-1-28.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//

#import "PZUserGuideViewController.h"

@interface PZUserGuideViewController ()

@end

@implementation PZUserGuideViewController

#pragma mark -
#pragma mark View lifecycle

/*
 视图加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];        
	_headerLabel.text = @"使用指引";
    _backButton.hidden = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
