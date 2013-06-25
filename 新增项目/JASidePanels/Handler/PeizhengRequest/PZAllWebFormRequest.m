//
//  PZAllWebFormRequest.m
//  培正梦飞翔
//
//  Created by Air on 13-6-24.
//
//

#import "PZAllWebFormRequest.h"
#import "PZAllWebFormViewController.h"
#import "PZAllWebFormData.h"

@interface PZAllWebFormRequest()
{
    NSInteger _startIndex;                                         // 页面数量
    NSMutableArray *_elements;
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@end
@implementation PZAllWebFormRequest
@synthesize allWebFormViewController = _allWebFormViewController;
- (void)AllWebFormRequest
{
    [self startRequest];
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
-(void)startRequest
{
    int i = 0;
    if ([_allWebFormViewController.itemArray count]%12 > 0) {
        i = 2; // 最后一页不够整除12时
    }
    else
    {
        i = 1;
    }
    _startIndex = [_allWebFormViewController.itemArray count]/12 + i;
    NSString * p = [[NSString alloc]initWithFormat:@"%d",_startIndex];
    PZUserInfo * userInfo = [[PZUserInfo loadDataInDatabase]objectAtIndex:0];
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0211&workid=%@&page=%@&limit=10&type=web&cname=dfly&cpwd=123456",userInfo.uid,p];
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
            NSArray * dataContents =[resDict valueForKey:@"listHead"];
            for (NSMutableDictionary *listHeadDict in dataContents)
            {
                PZAllWebFormData * allWebFormData = [[PZAllWebFormData alloc]initWithDictionary:listHeadDict];
                [_elements addObject:allWebFormData];
            }
            [_allWebFormViewController.itemArray addObjectsFromArray:_elements];
            [_allWebFormViewController.allWebFormTableView reloadData];
            [_allWebFormViewController.loadingView stopAnimating];
            [_allWebFormViewController.loadingView removeFromSuperview];
            [_elements removeAllObjects];
            [_elements release];
//            NSArray * userinfoArray =[resDict valueForKey:@"userinfo"];
//            NSMutableDictionary * userInfoDataDict = [userinfoArray objectAtIndex:0];
//            NSString * uidString = [userInfoDataDict valueForKey:@"uid"];
//            PZUserInfo * userInfo = [PZUserInfo loadADataInDatabaseWithUid:uidString];
//            if (userInfo) {
//                DLog(@"什么都不做..");
//            }
//            else
//            {
//                userInfo = [[PZUserInfo alloc]initWithDictionary:userInfoDataDict];
//            }
            self.notificationText = @"获取成功";
            self.imageName = @"PZ_True.png";
            self.notify.image = [UIImage imageNamed:self.imageName];
            self.notify.text = self.notificationText;
            [self displayNotification];
        }
        else
        {
            self.notificationText = @"获取不了数据";
            self.imageName = @"PZ_Wrong.png";
            self.notify.image = [UIImage imageNamed:self.imageName];
            self.notify.text = self.notificationText;
            [self displayNotification];
        }
    }
    else
    {
        self.notificationText = @"获取失败";
        self.imageName = @"PZ_Wrong.png";
        self.notify.image = [UIImage imageNamed:self.imageName];
        self.notify.text = self.notificationText;
        [self displayNotification];
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
    
    [_allWebFormViewController.loadingView stopAnimating];
    [_allWebFormViewController.loadingView removeFromSuperview];
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
    [self.notify presentWithDuration:0.6f speed:0.25f inView:nil completion:^{
        [self.notify removeFromSuperview];
        [self.notify setHidden:YES];
    }];
}
@end
