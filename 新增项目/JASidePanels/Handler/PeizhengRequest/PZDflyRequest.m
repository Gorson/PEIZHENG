//
//  PZDflyRequest.m
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import "PZDflyRequest.h"
#import "PZDflyData.h"

@interface PZDflyRequest ()
{
    NSInteger _startIndex;                                         // 页面数量
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@end

@implementation PZDflyRequest
@synthesize elements = _elements;
@synthesize dflyViewController = _dflyViewController;

- (void)DflyRequeat:(NSString *)catId
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
    if ([_dflyViewController.dflyItemArray count]%12 > 0) {
        i = 2; // 最后一页不够整除12时
    }
    else
    {
        i = 1;
    }
    _startIndex = [_dflyViewController.dflyItemArray count]/12 + i;
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
            PZDflyData * dflyData = [[PZDflyData alloc]init];
            dflyData.newsId = [newsDataDict valueForKey:@"newsid"];
            dflyData.title = [newsDataDict valueForKey:@"title"];
            dflyData.introduce = [newsDataDict valueForKey:@"introduce"];
            dflyData.imgurl = [newsDataDict valueForKey:@"imgurl"];
            dflyData.time = [newsDataDict valueForKey:@"time"];
            [_elements addObject:dflyData];
        }
        [_dflyViewController.dflyItemArray addObjectsFromArray:_elements];
        [_dflyViewController.aoView refreshView:_dflyViewController.dflyItemArray];
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