//
//  PZNewsListRequest.m
//  培正梦飞翔
//
//  Created by Air on 13-5-2.
//
//

#import "PZNewsListRequest.h"
#import "PZNewsListData.h"

@interface PZNewsListRequest ()
{
    NSError *error;
    NSString * _catid;
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@end


@implementation PZNewsListRequest
@synthesize newsListTableViewController = _newsListTableViewController;
@synthesize elements = _elements;
@synthesize hasLoadDynamics = _hasLoadDynamics;
@synthesize startIndex = _startIndex;
@synthesize existElements = _existElements;

/*
 初始化方法
 */
-(id)init
{
    if (self = [super init])
    {
        _startIndex = 1;
        _hasLoadDynamics = NO;
        _existElements = [[NSMutableArray alloc]initWithCapacity:150];
        
    }
    return self;
}


- (void)NewsListRequest:(NSString *)catid
{
    [self startRequest:catid];
    _catid = catid;
}

// 开始请求
-(void)startRequest:(NSString *)catid
{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0102&page=%d&limit=30&catid=%@&cname=dfly&cpwd=123456",_startIndex,catid];
    NSURL *url = [NSURL URLWithString:strURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
// 请求成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data  = [request responseData];
    NSDictionary *resDict = [NSJSONSerialization
                             JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([[resDict valueForKey:@"status"]isEqualToString:@"1"])
    {
        if ([[resDict valueForKey:@"hasdata"]isEqualToString:@"1"])
        {
            _elements = [[NSMutableArray array]retain];
            
            NSArray * dataContents =[resDict valueForKey:@"newsHead"];
//            [self newAThreadToOperationDatabase:dataContents];
//            _newsListTableViewController.hasLoadDynamics = _hasLoadDynamics;
//            _newsListTableViewController.startIndex = _startIndex;
            // 请求成功,把返回数组加入数据库
            if ([[PZNewsListData loadDataInDatabase]count] < 1)
            {
                [PZNewsListData insertDataInDatabase:dataContents withCatid:_catid];
            }
            else
            {
                NSArray * dataArray = [PZNewsListData loadDataInDatabase];
                
                for (NSDictionary * dataDic in dataContents)
                {
                    for (PZNewsListData *newsListData in dataArray)
                    {
                        float newId = [[dataDic valueForKey:@"newsid"] floatValue];
                        if (newId != newsListData.newsidNum)
                        {
                            [PZNewsListData insertDataDicInDatabase:dataDic withCatid:_catid];
                            break;
                        }
                        else
                        {
                            DLog(@"在数据库中已存在该数据..");
                        }
                    }
                    
                }
            }
            //获取本地数据库中PZNewsListData表中所有数据
            NSArray * dataArray = [PZNewsListData loadDataInDatabase];
            //遍历数组把同catid的结构体对象加入可变数组中
            for (PZNewsListData * newsData in dataArray) {
                if ([newsData.typeOfNews isEqualToString:_catid]) {
                    [_elements addObject:newsData];
                }
            }
            [_newsListTableViewController.newsItemArray removeAllObjects];
            [_newsListTableViewController.newsItemArray addObjectsFromArray:_elements];
            [_newsListTableViewController.newsTableView reloadData];
            [_newsListTableViewController.loadingView stopAnimating];
            [_newsListTableViewController.loadingView removeFromSuperview];
            if (_startIndex == 2) {
                [_newsListTableViewController refreshControlDidEndRefreshing];
                [_newsListTableViewController.view setUserInteractionEnabled:YES];
            }
            
        }
        else
        {
//            _hasLoadDynamics = NO;
//            _newsListTableViewController.hasLoadDynamics = _hasLoadDynamics;
//            [_newsListTableViewController.indicatorView stopAnimating];
//            [_newsListTableViewController.indicatorView removeFromSuperview];
//            _newsListTableViewController.newsTableView.tableFooterView = NULL;
            self.notificationText = @"没有更多数据了..";
            self.imageName = @"PZ_Wrong.png";
            self.notify.image = [UIImage imageNamed:self.imageName];
            self.notify.text = self.notificationText;
            [self displayNotification];
            
            [_newsListTableViewController.view setUserInteractionEnabled:YES];
            [_newsListTableViewController.loadingView stopAnimating];
            [_newsListTableViewController.loadingView removeFromSuperview];
            _newsListTableViewController.newsTableView.tableFooterView = NULL;
        }
    }
    else
    {
        self.notificationText = @"网络连接超时...";
        self.imageName = @"PZ_Wrong.png";
        self.notify.image = [UIImage imageNamed:self.imageName];
        self.notify.text = self.notificationText;
        [self displayNotification];

        [_newsListTableViewController.view setUserInteractionEnabled:YES];
        [_newsListTableViewController.loadingView stopAnimating];
        [_newsListTableViewController.loadingView removeFromSuperview];
        _newsListTableViewController.newsTableView.tableFooterView = NULL;
    }
}

- (void)newAThreadToOperationDatabase:(NSArray *)dataContents
{
    
}

// 请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    error = [request error];
    NSLog(@"%@", [error localizedDescription]);
    [self delayToRemove];
}

-(void)delayToRemove
{
    self.notificationText = @"网络连接超时...";
    self.imageName = @"PZ_Wrong.png";
    self.notify.image = [UIImage imageNamed:self.imageName];
    self.notify.text = self.notificationText;
    [self displayNotification];
    [_newsListTableViewController.view setUserInteractionEnabled:YES];
    [_newsListTableViewController.loadingView stopAnimating];
    [_newsListTableViewController.loadingView removeFromSuperview];
    _newsListTableViewController.newsTableView.tableFooterView = NULL;
    [_newsListTableViewController.newsTableView reloadData];
}

-(void)dealloc
{
    [super dealloc];
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
    [self.notify presentWithDuration:1.0f speed:0.5f inView:nil completion:^{
        [self.notify removeFromSuperview];
        [self.notify setHidden:YES];
    }];
}
@end
