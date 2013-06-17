//
//  GuideInterfaceVC.m
//  Ipiao
//
//  Created by liujiada on 12-11-14.
//  Copyright (c) 2012年 Ipiao. All rights reserved.
//

#import "GuideInterfaceVC.h"
 #import "JAAppDelegate.h"
@interface GuideInterfaceVC ()<UIGestureRecognizerDelegate>

@end

@implementation GuideInterfaceVC
@synthesize gotoMainViewBtn;
@synthesize imageView;
@synthesize pageScroll;
@synthesize pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [pageControl release];
    [pageScroll release];
    [imageView release];
    [super  dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *imageArray=[[[NSArray alloc]initWithObjects:@"D-fly.png",@"D-fly-Introduction.png",@"PC-server.png",nil]autorelease];
    NSArray *imageArray5=[[[NSArray alloc]initWithObjects:@"D-fly.png",@"D-fly-Introduction.png",@"PC-server.png",nil]autorelease];
                     
	pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, IPHONE_HEIGHT)];
//    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(141, IPHONE_HEIGHT-60, 38, 36)];
//    pageControl.numberOfPages = imageArray.count;
//    pageControl.currentPage = 0;
    pageScroll.delegate = self;
    pageScroll.pagingEnabled=YES;
    pageScroll.bounces = NO;
    pageScroll.showsHorizontalScrollIndicator=NO;
    pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imageArray.count, IPHONE_HEIGHT);
//    [pageControl setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:pageScroll];
//    [self.view addSubview:pageControl];
    
   
    
    for (int i = 0; i<imageArray.count; i++) {
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, IPHONE_HEIGHT)];
        [imageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
        if (iPhone5) {
           [imageView setImage:[UIImage imageNamed:[imageArray5 objectAtIndex:i]]];
        }
        [pageScroll addSubview:imageView];
    }
    
    gotoMainViewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    gotoMainViewBtn.frame=CGRectMake(320*([imageArray count]-1), 0, 320, IPHONE_HEIGHT);
//    [gotoMainViewBtn setTitle:@"立即体检" forState:UIControlStateNormal];
    [gotoMainViewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [gotoMainViewBtn setBackgroundImage:[UIImage imageNamed:@"TC_ExperienceBtn.png"] forState:UIControlStateNormal];
    [gotoMainViewBtn addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventAllTouchEvents];
    [pageScroll addSubview:gotoMainViewBtn];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePanFrom:)];
    [gotoMainViewBtn addGestureRecognizer:swipeRecognizer];//关键语句，给self.view添加一个手势监测；
    swipeRecognizer.numberOfTouchesRequired = 1;
    swipeRecognizer.delegate = self;
    [swipeRecognizer release];
}



- (void)gotoMainView:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [self.view popOut:.4 delegate:nil];

    [self.gotoMainViewBtn setHidden:YES];
//
//    [self.view removeFromSuperview];     
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat pageWidth = self.view.frame.size.width;
//    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [self gotoMainView:nil];
    return YES;
}

@end
