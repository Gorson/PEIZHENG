//
//  ViewController.m
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/21/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "PZMainViewController.h"
#import "MosaicData.h"
#import "MosaicDataView.h"
#import "CustomMosaicDatasource.h"
#import "PZNewsListTableViewController.h"
#import "PZMainNewsPictureRequest.h"
#import "PZMainDelegate.h"
#import "PZNewsDetailViewController.h"

@interface PZMainViewController()<PZMainDelegate>
{
    

}
@end

@implementation PZMainViewController

#pragma mark - Private

- (id)init
{
    self = [super init];
    if (self) {
        UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        self = [stryBoard instantiateInitialViewController];

    }
    return [self retain];
}

static UIImageView *captureSnapshotOfView(UIView *targetView){
    UIImageView *retVal = nil;
    
    UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, YES, 0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [[targetView layer] renderInContext:currentContext];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        
    retVal = [[UIImageView alloc] initWithImage:image];
    retVal.frame = [targetView frame];
    
    return retVal;
}

#pragma mark - Public

- (void)viewDidLayoutSubviews{
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view resignFirstResponder];
    
    [self initWithRequest];
    [self initWithData];
}

- (void)initWithRequest
{
    PZMainNewsPictureRequest * mainNewsPictureRequest = [[PZMainNewsPictureRequest alloc]init];
    [mainNewsPictureRequest MainNewsPictureRequest];
    
}

- (void)initWithData
{
    mosaicView.datasource = [CustomMosaicDatasource sharedInstance];
    mosaicView.delegate = self;
    mosaicView.mainDelegate = self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    snapshotBeforeRotation = captureSnapshotOfView(mosaicView);
    [self.view insertSubview:snapshotBeforeRotation aboveSubview:mosaicView];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    snapshotAfterRotation = captureSnapshotOfView(mosaicView);
    
    snapshotBeforeRotation.alpha = 0.0;
    [self.view insertSubview:snapshotAfterRotation belowSubview:snapshotBeforeRotation];
    mosaicView.hidden = YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [snapshotBeforeRotation removeFromSuperview];
    [snapshotAfterRotation removeFromSuperview];
    snapshotBeforeRotation = nil;
    snapshotAfterRotation = nil;
    mosaicView.hidden = NO;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

#pragma mark - MosaicViewDelegateProtocol

-(void)mosaicViewDidTap:(MosaicDataView *)aModule{
    if (aModule.module.catid) {
        DLog(@"%@",aModule.module.title);
        //模块触发事件
        if ([aModule.module.catid intValue] < 1000) 
        {
            PZNewsListTableViewController * newsListTableViewController = [[PZNewsListTableViewController alloc]init];
            newsListTableViewController.catid = aModule.module.catid;
            newsListTableViewController.headTitle = aModule.module.title;
            newsListTableViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:newsListTableViewController animated:YES];
        }
        //模块外触发事件
        else 
        {
            
        }
    }
}

-(void)mosaicViewDidDoubleTap:(MosaicDataView *)aModule{
    NSLog(@"#DEBUG Double Tapped %@", aModule.module);
}

#pragma mark mainDelagate

- (void)clickButtonWithNewsId:(NSString *)newsId withTitle:(NSString *)title
{
    PZNewsDetailViewController * newsDetailViewController = [[PZNewsDetailViewController alloc]init];
    switch ([newsId intValue]) {
        case 39:
            newsId = @"8555";
            break;
        case 38:
            newsId = @"8495";
            break;
        case 37:
            newsId = @"8483";
            break;
        case 36:
            newsId = @"8483";
            break;
        case 35:
            newsId = @"8414";
            break;
        default:
            break;
    }
    [self presentModalViewController:newsDetailViewController animated:YES];

}

@end
