//
//  PZMainNewsPictureRequest.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import "PZMainRequest.h"
#import "PZNewsMainList.h"

@interface PZMainRequest()
{
    NSInteger _startIndex;                                         // 页面数量
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@end

@implementation PZMainRequest
@synthesize elements = _elements;
@synthesize mainViewController = _mainViewController;

- (void)MainNewsRequest:(NSString *)catId
{
    [self startRequest:catId];
}
/*
 初始化方法
 */
-(id)init
{
    if (self = [super init])
    {
        _elements = [[NSMutableArray array]retain];
    }
    return self;
}


// 开始请求
-(void)startRequest:(NSString *)catid
{
    int i = 0;
    if ([_mainViewController.comboBoxDatasource count]%12 > 0) {
        i = 2; // 最后一页不够整除12时
    }
    else
    {
        i = 1;
    }
    _startIndex = [_mainViewController.comboBoxDatasource count]/12 + i;
    NSString * p = [[NSString alloc]initWithFormat:@"%d",_startIndex];
    
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0102&page=%@&limit=12&catid=%@&cname=dfly&cpwd=123456",p,catid];

    NSURL *url = [NSURL URLWithString:strURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
// 请求成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    DLog(@"request string : %@",[request responseString]);
    NSData *data  = [request responseData];
    NSDictionary *resDict = [NSJSONSerialization
                             JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([[resDict valueForKey:@"hasdata"]isEqualToString:@"1"])
    {
        NSArray * dataContents =[resDict valueForKey:@"newsHead"];
        for (NSDictionary *newsDataDict in dataContents)
        {
            PZNewsMainList * newsListData = [[PZNewsMainList alloc]init];
            newsListData.newsId = [newsDataDict valueForKey:@"newsid"];
            newsListData.title = [newsDataDict valueForKey:@"title"];
            newsListData.introduce = [newsDataDict valueForKey:@"introduce"];
            newsListData.imgurl = [newsDataDict valueForKey:@"imgurl"];
            newsListData.time = [newsDataDict valueForKey:@"time"];
            [_elements addObject:newsListData];
        }
        [_mainViewController.comboBoxDatasource addObjectsFromArray:_elements];
        [_mainViewController comboBoxAppear];
        if (_startIndex == 1) {
            [_mainViewController newsTopOfView];
        }
        [_elements removeAllObjects];
        [_elements release];
        
    }
    else
    {
        
    }
    
}

// 请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", [error localizedDescription]);
    
    self.notificationText = @"网络连接超时...";
    self.imageName = @"PZ_Wrong.png";
    self.notify.image = [UIImage imageNamed:self.imageName];
    self.notify.text = self.notificationText;
    [self displayNotification];
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
    _notify.center = CGPointMake(160, 240);
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
