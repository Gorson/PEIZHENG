//
//  PZMapController.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "PZMapController.h"

@interface PZMapController ()

@end

@implementation PZMapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView release];
    
    [_scrollView setContentSize:CGSizeMake(320 * 1, 460)];
    
    for (int i = 0; i < 1; i++) {
        _zoomScrollView = [[MRZoomScrollView alloc]init];
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        _zoomScrollView.frame = frame;
        _zoomScrollView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mapOfPeiZheng.jpg"]];
        [self.scrollView addSubview:_zoomScrollView];
        [_zoomScrollView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
