/*
 Copyright (c) 2012 Jesse Andersen. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */


#import "JALeftViewController.h"

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "JARightViewController.h"
#import "PZMainViewController.h"
#import "Quare4MenuViewController.h"
#import "PZNewsListTableViewController.h"
#import "PZCollectionListTableViewController.h"
#import "PZMapController.h"

#import "PZLeftView.h"
#import "RootViewController.h"
#import "PZComViewController.h"

@interface JALeftViewController ()
{
    RootViewController * peizhengFamily;
    PZComViewController * comViewController;
    Quare4MenuViewController * menuViewController;
    PZCollectionListTableViewController * collectionListTableViewController;
    PZMapController * mapController;
}

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *hide;
@property (nonatomic, weak) UIButton *show;
@property (nonatomic, weak) UIButton *removeRightPanel;
@property (nonatomic, weak) UIButton *addRightPanel;
@property (nonatomic, weak) UIButton *changeCenterPanel;

@end

@implementation JALeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
}

- (void)initWithUI
{
    PZLeftView * leftView = [[PZLeftView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, IPHONE_HEIGHT) target:self action:nil];
    [leftView.itemOneButton addTarget:self action:@selector(itemButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftView.itemTwoButton addTarget:self action:@selector(itemButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftView.itemThreeButton addTarget:self action:@selector(itemButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftView.itemFourButton addTarget:self action:@selector(itemButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftView.itemFiveButton addTarget:self action:@selector(itemButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [leftView.itemSixButton addTarget:self action:@selector(itemButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.label.center = CGPointMake(floorf(self.sidePanelController.leftVisibleWidth/2.0f), 25.0f);
}

#pragma mark - Button Items Press

- (void)itemButtonPress:(UIButton *)sender
{
    switch (sender.tag) {
        // 梦飞翔
        case 1000:
            [self _changeCenterPanelTapped:sender];
            break;
        // 培正社区
        case 1001:
            [self _changeCenterPanelTapped:sender];
            break;
        // 培正家园
        case 1002:
            [self _changeCenterPanelTapped:sender];
            break;
        // 培正live
        case 1003:
            
            break;
        // PC服务队
        case 1004:
            [self _changeCenterPanelTapped:sender];
            break;
        // 培正地图
        case 1005:
            [self _changeCenterPanelTapped:sender];
            
            break;

        default:
            break;
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

}


#pragma mark - Button Actions

- (void)_hideTapped:(id)sender {
    [self.sidePanelController setCenterPanelHidden:YES animated:YES duration:0.2f];
    self.hide.hidden = YES;
    self.show.hidden = NO;
}

- (void)_showTapped:(id)sender {
    [self.sidePanelController setCenterPanelHidden:NO animated:YES duration:0.2f];
    self.hide.hidden = NO;
    self.show.hidden = YES;
}

- (void)_removeRightPanelTapped:(id)sender {
    self.sidePanelController.rightPanel = nil;
    self.removeRightPanel.hidden = YES;
    self.addRightPanel.hidden = NO;
}

- (void)_addRightPanelTapped:(id)sender {
    self.sidePanelController.rightPanel = [[JARightViewController alloc] init];
    self.removeRightPanel.hidden = NO;
    self.addRightPanel.hidden = YES;
}

- (void)_changeCenterPanelTapped:(UIButton *)sender {
    switch (sender.tag) {
        case 1000:
        {
            PZNewsListTableViewController * vc1 = [[PZNewsListTableViewController alloc]init];
            vc1.catid = CommunitysStyle;
            vc1.headTitle = @"社团风采";
            PZNewsListTableViewController * vc2 = [[PZNewsListTableViewController alloc]init];
            vc2.catid = StudentOrganizations;
            vc2.headTitle = @"学生组织";
            PZNewsListTableViewController * vc3 = [[PZNewsListTableViewController alloc]init];
            vc3.catid = PeiZhengToday;
            vc3.headTitle = @"今日培正";
            PZNewsListTableViewController * vc4 = [[PZNewsListTableViewController alloc]init];
            vc4.catid = CampusAgent;
            vc4.headTitle = @"校园探报";
            menuViewController = [[Quare4MenuViewController alloc]initWithTopLeft:vc1 TopRight:vc2 bottomLeft:vc3 bottomRight:vc4];
            self.sidePanelController.centerPanel = menuViewController;
        }
            
            break;
        case 1001:
            comViewController = [[PZComViewController alloc]init];
            self.sidePanelController.centerPanel = comViewController;
            break;
        case 1002:
            peizhengFamily = [[RootViewController alloc]init];
            self.sidePanelController.centerPanel = peizhengFamily;
            break;
        case 1003:
            
            break;
        case 1004:
            collectionListTableViewController = [[PZCollectionListTableViewController alloc]init];
            self.sidePanelController.centerPanel = collectionListTableViewController;
            break;
        case 1005:
            mapController = [[PZMapController alloc]init];
            self.sidePanelController.centerPanel = mapController;
            break;
        default:
            break;
    }
    
    
}

@end
