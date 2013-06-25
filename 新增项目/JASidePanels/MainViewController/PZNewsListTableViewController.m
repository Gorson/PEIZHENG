//  PZFriendsOfCommunicationViewController.m
//
//  Created by 朱 欣 on 13-1-29.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//

#import "PZNewsListTableViewController.h"
#import "PZNewsDetailViewController.h"
#import "PZNewsListTableCell.h"
#import "PZNewsListRequest.h"
#import "PZNewsListData.h"
#import "QBFunnyFaceRefreshControl.h"
#import "QBArrowRefreshControl.h"

@interface PZNewsListTableViewController ()<QBRefreshControlDelegate>
{
    PZNewsListRequest * newsListRequest;                    // 新闻列表请求
    PZNewsDetailViewController * _newsDetailViewController;  // 新闻详细视图
}
//@property (nonatomic, retain) QBFunnyFaceRefreshControl *myRefreshControl;
@property (nonatomic, retain) QBArrowRefreshControl *myRefreshControl;

@end

@implementation PZNewsListTableViewController
@synthesize newsItemArray = _newsItemArray;
@synthesize newsTableView = _newsTableView;
@synthesize indicatorView = _indicatorView;
@synthesize loadingView = _loadingView;
@synthesize catid = _catid;
@synthesize headTitle = _headTitle;

/*
 * 视图第一次展现时调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _backButton.hidden = YES;
    _confirmButton.hidden = YES;
}


/*
 * 视图出现时调用
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //每一次载入该界面清空数组,避免重复数据
    [_newsItemArray removeAllObjects];
    //获取本地数据库中PZNewsListData表中所有数据
    NSArray * dataArray = [PZNewsListData loadDataInDatabase];
    //遍历数组把同catid的结构体对象加入可变数组中
    for (PZNewsListData * newsData in dataArray) {
        if ([newsData.typeOfNews isEqualToString:_catid]) {
            [_newsItemArray addObject:newsData];
        }
    }
    //如果数组数目小于1 则请求接口获取数据
    if ([_newsItemArray count] < 1) {
        if (1 == _startIndex) {
            newsListRequest = [[PZNewsListRequest alloc]init];
            newsListRequest.newsListTableViewController = self;
            [newsListRequest NewsListRequest:_catid];
            _startIndex = 2;
            newsListRequest.startIndex = _startIndex;
        }
    }
    else
    {
        //如果数组数目大于1 则显示数组对象
        [_newsTableView reloadData];
        [_loadingView stopAnimating];
        [_loadingView removeFromSuperview];
    }
    
}


/*
 * 当视图每一次消失,把索引值设置回1
 */
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}


/*
 * 当内存出现紧张,该方法被调用
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


/*
 * 初始化方法
 */
- (id)init
{
    if (self = [super init])
    {
        [self initWithControl];
        [self initWithData];
    }
    return self;
}


/*
 * 初始化数据类型
 */
- (void)initWithData
{
    _hasLoadDynamics = NO;
    _startIndex = 1;
    
    _newsItemArray = [[NSMutableArray alloc]initWithCapacity:150];
}


/*
 * 初始化UI控件
 */
- (void)initWithControl
{
    _loadingMoreView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame = CGRectMake(IPHONE_WIDTH/2.0f-10.0f, 10.0f, 20.0f, 20.0f);
    activityIndicatorView.tag = 1000;
    [_loadingMoreView addSubview:activityIndicatorView];
    [activityIndicatorView release];
    
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, IPHONE_WIDTH, IPHONE_HEIGHT-64) style:UITableViewStylePlain];
    _newsTableView.backgroundColor = [UIColor whiteColor];
    _newsTableView.backgroundView.alpha = 0;
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_newsTableView];
    
//    QBFunnyFaceRefreshControl *refreshControl = [[QBFunnyFaceRefreshControl alloc] init];
//    refreshControl.delegate = self;
//    [_newsTableView addSubview:refreshControl];
//    self.myRefreshControl = refreshControl;
//    [refreshControl release];
    
    // Refresh Control
    QBArrowRefreshControl *refreshControl = [[QBArrowRefreshControl alloc] init];
    refreshControl.delegate = self;
    [_newsTableView addSubview:refreshControl];
    self.myRefreshControl = refreshControl;
    [refreshControl release];
    
    _loadingView = [[CustomActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingView setFrame:CGRectOffset(LoadingRect, 0.0f, -22.0f)];
    [_loadingView startAnimating];
    [self.view addSubview:_loadingView];
//    self.view.userInteractionEnabled = NO;
    
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
        return [_newsItemArray count];
    }
    return 0;
}


/*
 * 表格视图每行的内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        static NSString * CellIdentifier = @"Cell1";
        
        PZNewsListTableCell * newsListCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (newsListCell == nil)
        {
            newsListCell = [[[PZNewsListTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            newsListCell.selectionStyle = UITableViewCellSelectionStyleGray;
            _headerLabel.text = _headTitle;
        }
        if ([_newsItemArray count]) {
            PZNewsListData * newsData = [_newsItemArray objectAtIndex:indexPath.row];
            newsListCell.titleLabel.text = newsData.title;
            if ([_catid isEqualToString:@"249" ] || [_catid isEqualToString:@"51" ]) {
                [newsListCell.image setFrame:CGRectMake(210.0f, 3.0f, 100.0f, 140.0f)];
                [newsListCell.headImageView setFrame:CGRectMake(210.0f, 3.0f, 100.0f, 140.0f)];
                [newsListCell.timeLabel setFrame:CGRectMake(55.0f, 12311.0f, 130.0f, 20.0f)];
                [newsListCell.contentLabel setFrame:CGRectMake(10.0f, 23.0f, 180.0f, 100.0f)];
            }
            if ([newsData.imgurl hasPrefix:@"/var"])
            {
                newsListCell.image.image = [self newThreadForLoadLocalImage:newsData];

            }else
            {
                [newsListCell.image setImageWithURL:[NSURL URLWithString:newsData.imgurl] placeholderImage:[UIImage imageNamed:@""]];
                newsData.imgurl = [PZNewsListData adressOfImage:newsData.imgurl];
                [PZNewsListData updateDataFromDatabase:newsData];
            }
            newsListCell.timeLabel.text = newsData.time;
            if ([newsData.introduce isEqualToString:@""])
            {
                newsListCell.contentLabel.text = @"暂无介绍";
            }
            else
            {
                newsListCell.contentLabel.text = newsData.introduce;
            }
        }

        return newsListCell;
    }
    return NULL;
}

- (UIImage *)newThreadForLoadLocalImage:(PZNewsListData *)newsData
{
    return [UIImage imageWithContentsOfFile:newsData.imgurl];
}

/*
 * 表格视图每行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_catid isEqualToString:@"249"] || [_catid isEqualToString:@"51" ])
    {
        return 150.0f;
    }
    return 100.0f;
    
}


/*
 * 表格视图每一部分行距加大
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (0 == section) {
//        return 40.0f;
//    }
//    if (1 == section) {
//        return 40.0f;
//    }
//    return 0;
//    
//}


///*
// * section 之间颜色
// */
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * sectionView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//    sectionView.backgroundColor = [UIColor whiteColor];
//    if (0 == section) {
//        //已在ipiao的通信录玩友列表
//        UILabel * _separatorLabel =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 30.0f)];
//        _separatorLabel.text = @"已在ipiao";
//        if ([_mobileFriendList_unFriendedArray count] == 0) {
//            UILabel * nothingStr = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 100, 30)];
//            nothingStr.text = @"(暂无)";
//            nothingStr.font = [UIFont systemFontOfSize:16];
//            nothingStr.texPZolor = HEXCOLOR(0x898989);
//            nothingStr.backgroundColor = [UIColor clearColor];
//            [sectionView addSubview:nothingStr];
//        }
//        _separatorLabel.texPZolor = HEXCOLOR(0x898989);
//        _separatorLabel.font = [UIFont systemFontOfSize:16];
//        _separatorLabel.backgroundColor = [UIColor clearColor];
//        [sectionView addSubview:_separatorLabel];
//        [_separatorLabel release];
//    }
//    if (1 == section) {
//        //已在ipiao的通信录玩友列表
//        UILabel * _separatorLabel =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 30.0f)];
//        _separatorLabel.text = @"没在ipiao";
//        _separatorLabel.texPZolor =HEXCOLOR(0x898989);
//        _separatorLabel.font = [UIFont systemFontOfSize:16];
//        _separatorLabel.backgroundColor = [UIColor clearColor];
//        [sectionView addSubview:_separatorLabel];
//        [_separatorLabel release];
//    }
//    
//    return [sectionView autorelease];
//}


/*
 * 选中表格视图后触发事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_newsTableView deselectRowAtIndexPath: indexPath animated:YES];
    
    if (0 == indexPath.section) {
        
        if ([_newsItemArray count]) {
            _newsDetailViewController = [[PZNewsDetailViewController alloc]init];
            PZNewsListData * newsData = [_newsItemArray objectAtIndex:indexPath.row];
            _newsDetailViewController.newsid = [NSString stringWithFormat:@"%f",newsData.newsidNum];
            [self.navigationController pushViewController:_newsDetailViewController animated:YES];
        }    }
    else {
        
        
    }
}


/*
 * 视图出栈时调用释放全部私有变量
 */
-(void)dealloc
{
    [_newsTableView release];
    [_loadingMoreView release];
    [_indicatorView release];
    [_loadingView release];
    [newsListRequest release];
    [_newsDetailViewController release];
    [super dealloc];
}


#pragma mark -
#pragma mark UITableViewDelegate

/*
 * 当cell加载绘画时调用的方法
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_newsTableView.dragging && !_newsTableView.decelerating) {
        return;
    }
    if(indexPath.row == [_newsItemArray count] -1) {
        if([_newsItemArray count]) {
            newsListRequest =[PZNewsListRequest alloc];
//            newsListRequest.hasLoadDynamics = _hasLoadDynamics;
            newsListRequest.existElements = _newsItemArray;
            if (([_newsItemArray count]/30) >= _startIndex) {
                _startIndex = ([_newsItemArray count]/30);
            }
            // 开新线程加载
            [NSThread detachNewThreadSelector:@selector(newThreadForRequest) toTarget:self withObject:nil];
            
            _newsTableView.tableFooterView = _loadingMoreView;
            _indicatorView = (UIActivityIndicatorView *)[_loadingMoreView viewWithTag:1000];
            [_indicatorView startAnimating];
        }
    }
}

- (void)newThreadForRequest
{
    _startIndex += 1;
    newsListRequest.startIndex = _startIndex;
    newsListRequest.newsListTableViewController = self;
    [newsListRequest NewsListRequest:_catid];
}

/*
 * 按钮样式
 */
- (UIButton *)buttonWithFrame:(CGRect)frame action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


/*
 返回
 */
- (void)onBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    NSLog(@"view move");
}

#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    [NSThread detachNewThreadSelector:@selector(refreshControlAndDelete) toTarget:self withObject:nil];
}

- (void)refreshControlAndDelete
{
    [self.view setUserInteractionEnabled:NO];
    // 获取数据库内所有的值
    NSArray * listDataArray = [PZNewsListData loadDataInDatabase];
    // 在所有的值内筛选该模块的值 加入可变数组中
    for (PZNewsListData * newsListData in listDataArray) {
        if ([newsListData.typeOfNews isEqualToString:_catid]) {
            // 删除在数据库中的值
            [PZNewsListData deleteOneFromStorage:newsListData];
        }
    }
    
    // 调用请求,重新请求一批数据
    newsListRequest = [[PZNewsListRequest alloc]init];
    newsListRequest.newsListTableViewController = self;
    [newsListRequest NewsListRequest:_catid];
    _startIndex = 2;
    newsListRequest.startIndex = _startIndex;
}

- (void)refreshControlDidEndRefreshing
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myRefreshControl endRefreshing];
    });

}

@end
