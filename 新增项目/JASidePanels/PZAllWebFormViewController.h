//
//  PZAllWebFormViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-6-24.
//
//

#import "PZNavigationViewController.h"

@interface PZAllWebFormViewController : PZNavigationViewController
{
    UITableView * _allWebFormTableView;                       // 资讯新闻表格视图
    CustomActivityIndicatorView * _loadingView;         // 表格中部的菊花
    NSMutableArray *_itemArray;
}
@property (nonatomic, retain) UITableView * allWebFormTableView;                // 资讯新闻表格视图
@property (nonatomic, retain) CustomActivityIndicatorView * loadingView;        // 表格中部的菊花
@property (nonatomic, retain) NSMutableArray *itemArray;
@end
