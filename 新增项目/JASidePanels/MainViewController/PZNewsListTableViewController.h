//
//  PZFriendsOfCommunicationViewController.h
//  Created by 朱 欣 on 13-1-29.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PZNavigationViewController.h"

@interface PZNewsListTableViewController : PZNavigationViewController
{
    UITableView * _newsTableView;                       // 资讯新闻表格视图
    NSMutableArray * _newsItemArray;                    // 资讯新闻数组
    
    CustomActivityIndicatorView * _loadingView;         // 表格中部的菊花
    UIActivityIndicatorView * _indicatorView ;          // 表格脚的菊花
    
    BOOL _hasLoadDynamics;                              // 是否已经加载动态数据
    UIView * _loadingMoreView;                          // 表格脚加载视图
    NSInteger _startIndex;                              // 页面数量
    NSString * _catid;  
    NSString * _headTitle;                              // 头标题
}

@property (nonatomic,copy) NSMutableArray * newsItemArray;                      // 资讯新闻数组
@property (nonatomic,retain) UITableView * newsTableView;                       // 资讯新闻表格视图
@property (nonatomic) BOOL hasLoadDynamics;                                     // 是否已经加载动态数据
@property (nonatomic, retain) CustomActivityIndicatorView * loadingView;        // 表格中部的菊花
@property (nonatomic, retain) UIActivityIndicatorView * indicatorView;          // 表格脚的菊花
@property (nonatomic, copy) NSString * catid;
@property (nonatomic, copy) NSString * headTitle;                               // 头标题
@property (nonatomic) NSInteger startIndex; 


- (void)refreshControlDidEndRefreshing;
@end
