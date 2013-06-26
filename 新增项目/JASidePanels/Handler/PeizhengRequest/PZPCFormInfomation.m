//
//  PZPCRegisterDataRequest.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZPCFormInfomation.h"
#import "PZDetailOfFormData.h"
#import "PZPCFormDetailViewController.h"

@interface PZPCFormInfomation()

@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;

@end

@implementation PZPCFormInfomation
@synthesize oid = _oid;
@synthesize pcFormDetailViewController = _pcFormDetailViewController;
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

-(void)PCFormInfomation
{
    [self startRequest];
}

// 开始请求
-(void)startRequest
{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0212&oid=%@&cname=dfly&cpwd=123456",_oid];
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
    DLog(@"resDict : %@",resDict);
    if ([[resDict valueForKey:@"status"]isEqualToString:@"1"])
    {
        if ([[resDict valueForKey:@"hasdata"]isEqualToString:@"1"])
        {
            NSMutableDictionary * userInfoDataDict = [resDict valueForKey:@"listInfo"];
            PZDetailOfFormData * detailOfFormData = [[PZDetailOfFormData alloc]initWithDictionary:userInfoDataDict];
            [_pcFormDetailViewController refreshViewControl:detailOfFormData];
            
            self.notificationText = @"获取成功";
            self.imageName = @"PZ_True.png";
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
