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
    UINavigationController * peizhengFamily;
    PZComViewController * comViewController;
    Quare4MenuViewController * menuViewController;
    PZCollectionListTableViewController * collectionListTableViewController;
    PZMapController * mapController;
    NSMutableArray * _listItemArray;                                         // 资讯新闻数组

}

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *hide;
@property (nonatomic, weak) UIButton *show;
@property (nonatomic, weak) UIButton *removeRightPanel;
@property (nonatomic, weak) UIButton *addRightPanel;
@property (nonatomic, weak) UIButton *changeCenterPanel;
@property (nonatomic, retain) UITableView * itemListView;

@end

@implementation JALeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self initWithData];
}

- (void)initWithData
{
    _listItemArray = [[NSMutableArray alloc]initWithObjects:@"主页",@"培正周边",@"D-Fly视觉",@"培正地图",@"PC服务队",@"收藏夹",@"设置",@"关于", nil];
}

- (void)initWithUI
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44.0f, 320, IPHONE_HEIGHT - 64.0f) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.backgroundColor = [UIColor grayColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.itemListView = tableView;
//    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:self.itemListView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.label.center = CGPointMake(floorf(self.sidePanelController.leftVisibleWidth/2.0f), 25.0f);
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

- (void)changeCenterPanelTapped:(NSInteger)index {
    switch (index) {
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
//            comViewController = [[PZComViewController alloc]init];
//            self.sidePanelController.centerPanel = comViewController;
            break;
        case 1002:
            peizhengFamily = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]];
            self.sidePanelController.centerPanel = peizhengFamily;
            break;
        case 1003:
            mapController = [[PZMapController alloc]init];
            self.sidePanelController.centerPanel = mapController;
            break;
        case 1004:
            
            break;
        case 1005:
            collectionListTableViewController = [[PZCollectionListTableViewController alloc]init];
            self.sidePanelController.centerPanel = collectionListTableViewController;
            break;
        default:
            break;
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

}


#pragma mark -
#pragma mark UITableViewDataSource

/*
 * 表格视图section的个数，有1个section
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


/*
 * 表格视图每个section的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return [_listItemArray count];
    }
    return 0;
}


/*
 * 表格视图每行的内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell1";
    
    UITableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (listCell == nil)
    {
        listCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        listCell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    listCell.textLabel.text = [_listItemArray objectAtIndex:indexPath.row];
    listCell.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    listCell.imageView.image = [UIImage imageNamed:@"backToMain.png"];
    return listCell;
}


/*
 * 表格视图每行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0f;
}

/*
 * 选中表格视图后触发事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    [self changeCenterPanelTapped:indexPath.row + 1000.0f];
}
@end
