//
//  ViewController.m
//  QBAnimationSequence
//
//  Created by Katsuma Tanaka on 2013/01/31.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "ViewController.h"

#import "FirstTutorialSheet.h"
#import "SecondTutorialSheet.h"
#import "ThirdTutorialSheet.h"

#import "JASidePanelController.h"
#import "PZMainViewController.h"
#import "JALeftViewController.h"
#import "JARightViewController.h"

#import "PZToolView.h"

@interface ViewController ()
{
    PZToolView * _bgtoolView;       // 底部切换界面
}

@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tutorialView.contentSize = CGSizeMake(960, 240);
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    
    self.experienceButton.hidden = YES;
    
    FirstTutorialSheet *firstSheet = [[FirstTutorialSheet alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    [self.tutorialView addSubview:firstSheet];
    [firstSheet release];
    
    SecondTutorialSheet *secondSheet = [[SecondTutorialSheet alloc] initWithFrame:CGRectMake(320, 0, 320, 240)];
    [self.tutorialView addSubview:secondSheet];
    [secondSheet release];
    
    ThirdTutorialSheet *thirdSheet = [[ThirdTutorialSheet alloc] initWithFrame:CGRectMake(640, 0, 320, 240)];
    [self.tutorialView addSubview:thirdSheet];
    [thirdSheet release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_tutorialView release];
    [_pageControl release];
    
    [super dealloc];
}

#warning  该处新手导航页还未移除，还是会有内存占用.
#pragma mark - UserOperation
- (IBAction)experienceAtOnce:(UIButton *)sender {

    theApp.viewController.leftPanel = [[[JALeftViewController alloc] init]autorelease];
    theApp.viewController.centerPanel = [[[PZMainViewController alloc] init]autorelease];
    theApp.viewController.rightPanel = [[[JARightViewController alloc] init]autorelease];
    
    //底部工具栏
//    _bgtoolView = [[PZToolView alloc] initWithFrame:CGRectMake(0.0f, IPHONE_HEIGHT - 60.0f, 320.0f, 46.0f)];
    [_bgtoolView.firstButton addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
    [_bgtoolView.secondButton addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
    [_bgtoolView.thirdButton addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
    [_bgtoolView.fourButton addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
    
    [theApp.viewController.view setFrame:CGRectMake(0, 20.0f, 320.0f, IPHONE_HEIGHT)];
    [theApp.viewController.view addSubview:_bgtoolView];
    [theApp.window addSubview:theApp.viewController.view];
    [self.view setHidden:YES];
//    [self release];
    
}

- (void)changeTab:(UIButton *)sender
{
    switch (sender.tag) {
        // 梦飞翔主页按钮
        case 1000:
            
            break;
        // 今日培正按钮
        case 1001:
            
            break;
        // 社团风采按钮
        case 1002:
            
            break;
        //更多精彩按钮
        case 1003:
            
            break;
            
        default:
            break;
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint contentOffset = self.tutorialView.contentOffset;
    NSInteger currentPage = contentOffset.x / 320;
    
    self.pageControl.currentPage = currentPage;
    
    switch (currentPage) {
        case 0:
            self.newInterfaceLabel.text = @"我们的资讯包括";
            break;
        case 1:
            self.newInterfaceLabel.text = @"我们可以这样做";
            break;
        case 2:
            self.newInterfaceLabel.text = @"我们让你更加了解培正";
            self.experienceButton.hidden = NO;
            break;
        default:
            break;
    }
}


- (void)viewDidUnload {
    [self setNewInterfaceLabel:nil];
    [super viewDidUnload];
}

@end