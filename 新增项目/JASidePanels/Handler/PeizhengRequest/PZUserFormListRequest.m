//
//  PZUserFormListRequest.m
//  培正梦飞翔
//
//  Created by Air on 13-7-13.
//
//

#import "PZUserFormListRequest.h"
#import "PZSendMyFormListController.h"

@interface PZUserFormListRequest()

@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;

@end
@implementation PZUserFormListRequest
@synthesize user = _user;

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

-(void)PZUserFormListRequest
{
    [self startRequest];
}

// 开始请求
-(void)startRequest
{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0204&uid=%@&uname=%@&comtype=%@&faultdesc=%@&booktime=%@&phone=%@&dorm=%@&email=%@&area=%@",_user.uid,_user.uname,_user.comtype,_user.faultdesc,_user.booktime,_user.phone,_user.dorm,_user.email,_user.area];
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
    if ([[resDict valueForKey:@"status"]isEqualToString:@"0"])
    {
        self.notificationText = @"提交成功";
        self.imageName = @"PZ_Wrong.png";
        self.notify.image = [UIImage imageNamed:self.imageName];
        self.notify.text = self.notificationText;
        [self displayNotification];
    }
    else
    {
        self.notificationText = @"提交失败";
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
    
    self.notificationText = @"提交失败...";
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
