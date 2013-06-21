//
//  PZMainViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-19.
//
//

#import "PZMainViewController.h"
#import "PZNewsListTableViewController.h"
#import "PZMainView.h"
#import "ComboBoxView.h"
#import "PZMainRequest.h"
#import "PZNewsMainList.h"

@interface PZMainViewController ()
{
    ComboBoxView *_comboBox;
    PZMainRequest *_mainRequest;
    PZMainView *mainView;
    UIButton * topOfView;
}
@end

@implementation PZMainViewController
@synthesize comboBoxDatasource = _comboBoxDatasource;
@synthesize catId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithData];
    [self initWithControl];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithControl
{
    [_backButton setHidden:YES];
    [_headerImageView setHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    mainView = [[PZMainView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, IPHONE_HEIGHT - 20.0f)];
    [mainView.itemOneButton addTarget:self action:@selector(userOperation:) forControlEvents:UIControlEventTouchUpInside];
    [mainView.itemTwoButton addTarget:self action:@selector(userOperation:) forControlEvents:UIControlEventTouchUpInside];
    [mainView.itemThreeButton addTarget:self action:@selector(userOperation:) forControlEvents:UIControlEventTouchUpInside];
    [mainView.itemFourButton addTarget:self action:@selector(userOperation:) forControlEvents:UIControlEventTouchUpInside];
    if ([_comboBoxDatasource count]) {
        [self comboBoxAppear];
    }
    [self.view addSubview:mainView];
    
    topOfView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT - 20.0f)];
    [topOfView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    [topOfView addTarget:self action:@selector(removeTopNews) forControlEvents:UIControlEventAllEvents];
    UIButton * newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newsButton setFrame:CGRectMake(0.0f, IPHONE_HEIGHT/3 - 20.0f, 320.0f, IPHONE_HEIGHT/3)];
    [newsButton setBackgroundColor:[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:0.5]];
    [newsButton addTarget:self action:@selector(removeTopNews) forControlEvents:UIControlEventTouchUpInside];
    [topOfView addSubview:newsButton];
}

- (void)initWithData
{
    _comboBoxDatasource = [[NSMutableArray array] retain];
    [self sendRequest:PeiZhengToday];
}

- (void)comboBoxAppear
{
    if (!_comboBox) {
        _comboBox = [[ComboBoxView alloc] initWithFrame:CGRectMake(15.0f, 150.0f, 216.0f, 234.0f)];
        [mainView addSubview:_comboBox];
    }
    else
    {
        [_comboBox.comboBoxTableView reloadData];
    }
	_comboBox.comboBoxDatasource = _comboBoxDatasource;
    _comboBox.mainViewController = self;
	_comboBox.backgroundColor = [UIColor clearColor];
    PZNewsMainList *newsMainList = [[PZNewsMainList alloc]init];
    newsMainList = [_comboBoxDatasource objectAtIndex:0];
	[_comboBox setContent:newsMainList.title];
    
//	[_comboBox release];
//	[_comboBoxDatasource release];
}

- (void)sendRequest:(NSString *)catid
{
    _mainRequest = [[PZMainRequest alloc]init];
    _mainRequest.mainViewController = self;
    [_mainRequest MainNewsRequest:catid];
}

- (void)userOperation:(UIButton *)sender
{
//    PZNewsListTableViewController *newsListTableViewController = [[PZNewsListTableViewController alloc]init];
    [_comboBoxDatasource removeAllObjects];
    switch (sender.tag) {
        case 1000:
//            newsListTableViewController.catid = PeiZhengToday;
//            newsListTableViewController.headTitle = @"培正今日";
            catId = PeiZhengToday;
            [self sendRequest:PeiZhengToday];
            break;
        case 1001:
//            newsListTableViewController.catid = CampusAgent;
//            newsListTableViewController.headTitle = @"校园探报";
            catId = CampusAgent;
            [self sendRequest:CampusAgent];
            break;
        case 1002:
//            newsListTableViewController.catid = StudentOrganizations;
//            newsListTableViewController.headTitle = @"学生组织";
            catId = StudentOrganizations;
            [self sendRequest:StudentOrganizations];
            break;
        case 1003:
//            newsListTableViewController.catid = CommunitysStyle;
//            newsListTableViewController.headTitle = @"社团风采";
            catId = CommunitysStyle;
            [self sendRequest:CommunitysStyle];
            break;
            
        default:
            break;
    }
//    [self.navigationController pushViewController:newsListTableViewController animated:YES];
}

- (void)peizhengToday:(UIButton *)sender
{
    
}

- (void)newsTopOfView
{
    [self.view addSubview:topOfView];
}

- (void)removeTopNews
{
    [topOfView removeFromSuperview];
}
@end
