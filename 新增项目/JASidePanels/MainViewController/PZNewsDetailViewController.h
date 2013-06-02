//
//  PZNewsDetailViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-5-5.
//
//

#import <UIKit/UIKit.h>
#import "PZNewsDetailData.h"

@interface PZNewsDetailViewController : PZNavigationViewController
{
    NSString * _newsid;                             // 新闻id
    CustomActivityIndicatorView * _loadingView;     // 表格中部的菊花
}

@property (nonatomic, retain) PZNewsDetailData * newsDetailData;
@property (nonatomic, retain) CustomActivityIndicatorView * loadingView;
@property (nonatomic, copy) NSString * newsid;

- (void)loadWebView;
@end
