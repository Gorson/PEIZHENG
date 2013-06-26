//
//  PZFriendsOfCommunicationViewController.h
//  Created by 朱 欣 on 13-1-29.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PZNavigationViewController.h"

@interface PZCollectionListTableViewController : PZNavigationViewController
{
    UITableView * _newsTableView;                       // 资讯新闻表格视图
    NSMutableArray * _newsItemArray;                    // 资讯新闻数组
    
    CustomActivityIndicatorView * _loadingView;         // 表格中部的菊花
    
    NSString * _headTitle;                              // 头标题
}

@property (nonatomic,copy) NSMutableArray * newsItemArray;                      // 资讯新闻数组
@property (nonatomic,retain) UITableView * newsTableView;                       // 资讯新闻表格视图
@property (nonatomic, retain) CustomActivityIndicatorView * loadingView;        // 表格中部的菊花
//@property (nonatomic, copy) NSString * headTitle;                               // 头标题

@end
