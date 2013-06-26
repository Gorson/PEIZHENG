//  PZFriendsOfCommunicationViewController.m
//
//  Created by 朱 欣 on 13-1-29.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//

#import "PZCollectionListTableViewController.h"
#import "PZNewsDetailViewController.h"
#import "PZNewsListTableCell.h"
#import "PZNewsDetailData.h"

@interface PZCollectionListTableViewController ()
{
    PZNewsDetailViewController * _newsDetailViewController;  // 新闻详细视图
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;

@end

@implementation PZCollectionListTableViewController
@synthesize newsItemArray = _newsItemArray;
@synthesize newsTableView = _newsTableView;
@synthesize loadingView = _loadingView;
//@synthesize headTitle = _headTitle;

/*
 * 视图第一次展现时调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithData];
    [self initWithControl];
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
    NSArray * dataArray = [PZNewsDetailData loadADataInDatabase];
    //遍历数组把同catid的结构体对象加入可变数组中
    for (PZNewsDetailData * newsData in dataArray) {
        if ([newsData.mark isEqualToString:@"YES"]) {
            [_newsItemArray addObject:newsData];
        }
    }
    //如果数组数目小于1 则请求接口获取数据
    if ([_newsItemArray count] < 1)
    {
        [_newsTableView reloadData];
        self.notificationText = @"暂未有收藏.";
        self.imageName = @"PZ_Wrong.png";
        self.notify.image = [UIImage imageNamed:self.imageName];
        self.notify.text = self.notificationText;
        [self displayNotification];
        [_loadingView stopAnimating];
        [_loadingView removeFromSuperview];
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
        
    }
    return self;
}


/*
 * 初始化数据类型
 */
- (void)initWithData
{
    _newsItemArray = [[NSMutableArray array] retain];
}


/*
 * 初始化UI控件
 */
- (void)initWithControl
{
    _backButton.hidden = YES;
    _confirmButton.hidden = YES;
    _headerLabel.text = @"收藏夹";
    
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, IPHONE_WIDTH, IPHONE_HEIGHT-64) style:UITableViewStylePlain];
    _newsTableView.backgroundColor = [UIColor whiteColor];
    _newsTableView.backgroundView.alpha = 0;
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_newsTableView];
    
    _loadingView = [[CustomActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingView setFrame:CGRectOffset(LoadingRect, 0.0f, -22.0f)];
    [_loadingView startAnimating];
    [self.view addSubview:_loadingView];
    
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
        }
        if ([_newsItemArray count]) {
            PZNewsDetailData * newsData = [_newsItemArray objectAtIndex:indexPath.row];
            newsListCell.titleLabel.text = newsData.title;
//            if ([newsData.typeOfNews isEqualToString:@"249" ] || [newsData.typeOfNews isEqualToString:@"51" ]) {
//                [newsListCell.image setFrame:CGRectMake(210.0f, 3.0f, 100.0f, 140.0f)];
//                [newsListCell.headImageView setFrame:CGRectMake(210.0f, 3.0f, 100.0f, 140.0f)];
//                [newsListCell.timeLabel setFrame:CGRectMake(55.0f, 12311.0f, 130.0f, 20.0f)];
//                [newsListCell.contentLabel setFrame:CGRectMake(10.0f, 23.0f, 180.0f, 100.0f)];
//            }
            if ([newsData.imgurl hasPrefix:@"/var"])
            {
                newsListCell.image.image = [UIImage imageNamed:@"tb1.jpg"];

            }else
            {
                [newsListCell.image setImageWithURL:[NSURL URLWithString:newsData.imgurl] placeholderImage:[UIImage imageNamed:@""]];
                newsData.imgurl = [PZNewsDetailData adressOfImage:newsData.imgurl];
                [PZNewsDetailData updateDataFromDatabase:newsData];
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

//- (UIImage *)newThreadForLoadLocalImage:(PZNewsListData *)newsData
//{
//    return [UIImage imageWithContentsOfFile:newsData.imgurl];
//}

/*
 * 表格视图每行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PZNewsListData * newsData = [_newsItemArray objectAtIndex:indexPath.row];
//    
//    if ([newsData.typeOfNews isEqualToString:@"249"] || [newsData.typeOfNews isEqualToString:@"51" ])
//    {
//        return 150.0f;
//    }
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
            PZNewsDetailData * newsData = [_newsItemArray objectAtIndex:indexPath.row];
            _newsDetailViewController.newsid = [NSString stringWithFormat:@"%@",newsData.numOfNews];
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
    [_loadingView release];
    [_newsDetailViewController release];
    [super dealloc];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    NSLog(@"view move");
}

#pragma mark -
#pragma mark BDKNotifyHUD

- (BDKNotifyHUD *)notify {
    if (_notify != nil) return _notify;
    _notify = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:self.imageName] text:self.notificationText];
    _notify.center = CGPointMake(IPHONE_WIDTH/2, IPHONE_HEIGHT/2);
    [self.notify setHidden:YES];
    return _notify;
}


- (void)displayNotification {
    if (self.notify.isAnimating) return;
    
    [_notify makeKeyAndVisible];
    [self.notify presentWithDuration:0.6f speed:0.25f inView:nil completion:^{
        [self.notify removeFromSuperview];
        [self.notify setHidden:YES];
    }];
}
@end
