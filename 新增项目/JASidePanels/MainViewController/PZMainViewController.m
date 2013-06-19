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
}
@end

@implementation PZMainViewController
@synthesize comboBoxDatasource = _comboBoxDatasource;
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
    
}

- (void)initWithData
{
    _comboBoxDatasource = [[NSMutableArray array] retain];
    [self sendRequest];
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

- (void)sendRequest
{
    _mainRequest = [[PZMainRequest alloc]init];
    _mainRequest.mainViewController = self;
    [_mainRequest MainNewsRequest];
}

- (void)userOperation:(UIButton *)sender
{
    PZNewsListTableViewController *newsListTableViewController = [[PZNewsListTableViewController alloc]init];
    
    switch (sender.tag) {
        case 1000:
            newsListTableViewController.catid = PeiZhengToday;
            newsListTableViewController.headTitle = @"培正今日";
            break;
        case 1001:
            newsListTableViewController.catid = CampusAgent;
            newsListTableViewController.headTitle = @"校园探报";
            break;
        case 1002:
            newsListTableViewController.catid = StudentOrganizations;
            newsListTableViewController.headTitle = @"学生组织";
            break;
        case 1003:
            newsListTableViewController.catid = CommunitysStyle;
            newsListTableViewController.headTitle = @"社团风采";
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:newsListTableViewController animated:YES];
}

- (void)peizhengToday:(UIButton *)sender
{
    
}
@end
