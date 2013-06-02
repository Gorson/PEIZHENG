//
//  PZNewsListRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-5-2.
//
//

#import <Foundation/Foundation.h>
#import "PZNewsListTableViewController.h"


@interface PZNewsListRequest : NSObject
{
    NSMutableArray *_elements;
    NSMutableArray *_existElements;
    PZNewsListTableViewController *_newsListTableViewController;
    
    BOOL _hasLoadDynamics;                                                      // 是否已经加载动态数据
    NSInteger _startIndex;                                                      // 页面数量
}
@property (nonatomic, retain)PZNewsListTableViewController *newsListTableViewController;
@property (nonatomic, copy)NSMutableArray *elements;
@property (nonatomic) BOOL hasLoadDynamics;                                     // 是否已经加载动态数据
@property (nonatomic) NSInteger startIndex;                                     // 页面数量
@property (nonatomic, copy)NSMutableArray *existElements;                       // 已存在数据库得对象

- (void)NewsListRequest:(NSString *)catid;
@end
