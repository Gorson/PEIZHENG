//
//  PZDetailRequestViewController.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import "PZDetailRequest.h"
#import "PZNewsDetailData.h"

@interface PZDetailRequest ()
{
    NSString * _newsid;
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@end

@implementation PZDetailRequest

- (void)DetailRequest:(NSString *)newsid
{
    [self startRequest:newsid];
    _newsid = newsid;
}
/*
 初始化方法
 */
-(id)init
{
    if (self = [super init])
    {

    }
    return self;
}


// 开始请求
-(void)startRequest:(NSString *)newsid
{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0104&databaseid=4&newsid=%@&cname=dfly&cpwd=123456",newsid];
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
    DLog(@"resDict : %@",resDict);
    if ([[resDict valueForKey:@"status"]isEqualToString:@"1"])
    {
        if ([[resDict valueForKey:@"hasdata"]isEqualToString:@"1"])
        {
            NSMutableDictionary * newsDetailDataDict =[resDict valueForKey:@"content"];
            PZNewsDetailData * newsDetail = [[PZNewsDetailData alloc]initWithDictionary:newsDetailDataDict withNewsId:_newsid];
            NSArray *newsDetailArray = [PZNewsDetailData loadADataInDatabase];
            if ([newsDetailArray count] < 1) {
                [PZNewsDetailData insertADataInDatabase:newsDetail withNewsid:_newsid];
            }
            for (int i = 0; i < [newsDetailArray count];i++) {
                if ([newsDetail isEqual:[newsDetailArray objectAtIndex:i]])
                {
                    DLog(@"在数据库中已存在该数据..");
                    break;
                }
                else if (i == [newsDetailArray count])
                {
                    [PZNewsDetailData insertADataInDatabase:newsDetail withNewsid:_newsid];
                }
            }
            PZNewsDetailData * newsDetailData = [PZNewsDetailData loadADataInDatabaseWithNewsId:_newsid];
            _newsDetailViewController.newsDetailData = newsDetailData;
            [_newsDetailViewController loadWebView];
        }
        else
        {
            
        }
        
        [self performSelector:@selector(delayToRemove) withObject:Nil afterDelay:0.5];
        
    }
    else
    {
        self.notificationText = @"网络连接超时...";
        self.imageName = @"PZ_Wrong.png";
        self.notify.image = [UIImage imageNamed:self.imageName];
        self.notify.text = self.notificationText;
        [self displayNotification];
        [_newsDetailViewController.loadingView stopAnimating];
        [_newsDetailViewController.loadingView removeFromSuperview];
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
    [self delayToRemove];
}

-(void)delayToRemove
{
    [_newsDetailViewController.loadingView stopAnimating];
    [_newsDetailViewController.loadingView removeFromSuperview];
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
