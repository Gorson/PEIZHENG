//
//  GuideInterfaceVC.h
//  Ipiao
//
//  Created by liujiada on 12-11-14.
//  Copyright (c) 2012年 Ipiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FTAnimation+UIView.h"

@interface GuideInterfaceVC : UIViewController<UIScrollViewDelegate>
@property (nonatomic,strong)  UIImageView *imageView;


@property (retain, nonatomic)  UIScrollView *pageScroll;
@property (retain, nonatomic)  UIPageControl *pageControl;

@property (retain, nonatomic)  UIButton *gotoMainViewBtn;
@end
