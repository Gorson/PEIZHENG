//
//  PZPCUserLoginRequest.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZPCUserLoginRequest.h"
#import "PZUserInfo.h"

#import "PZUserFunctionController.h"
#import "PZEngineerFunctionController.h"

@interface PZPCUserLoginRequest()
{

}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@property (nonatomic, retain)PZUserFunctionController *userFunctionController;
@property (nonatomic, retain)PZEngineerFunctionController *engineerFunctionController;
@end


@implementation PZPCUserLoginRequest
@synthesize username = _username;
@synthesize password = _password;
@synthesize pcServerViewController = _pcServerViewController;

- (void)PCUserLoginRequest
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
        
    }
    return self;
}


// 开始请求
-(void)startRequest
{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0202&uname=%@&upwd=%@&cname=dfly&cpwd=123456",_username,_password];
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
            NSArray * userinfoArray =[resDict valueForKey:@"userinfo"];
            NSMutableDictionary * userInfoDataDict = [userinfoArray objectAtIndex:0];
            NSString * uidString = [userInfoDataDict valueForKey:@"uid"];
            PZUserInfo * userInfo = [PZUserInfo loadADataInDatabaseWithUid:uidString];
            if (userInfo) {
                DLog(@"什么都不做..");
            }
            else
            {
                userInfo = [[PZUserInfo alloc]initWithDictionary:userInfoDataDict];
            }
            self.notificationText = @"登陆成功";
            self.imageName = @"PZ_True.png";
            self.notify.image = [UIImage imageNamed:self.imageName];
            self.notify.text = self.notificationText;
            [self displayNotification];
            NSString * identityString = [userInfoDataDict valueForKey:@"identity"];
            if ([identityString isEqualToString:@"0"]) {
                PZUserFunctionController *user = [[PZUserFunctionController alloc]init];
                self.userFunctionController = user;
                [_pcServerViewController presentModalViewController:_userFunctionController animated:YES];
            }
            else if ([identityString isEqualToString:@"1"])
            {
                PZEngineerFunctionController *engineer = [[PZEngineerFunctionController alloc]init];
                self.engineerFunctionController = engineer;
                [_pcServerViewController presentModalViewController:_engineerFunctionController animated:YES];
            }
            else
            {
                DLog(@"其他人员..");
            }
        }
        else
        {
            self.notificationText = @"账户名密码错误";
            self.imageName = @"PZ_Wrong.png";
            self.notify.image = [UIImage imageNamed:self.imageName];
            self.notify.text = self.notificationText;
            [self displayNotification];
        }
    }
    else
    {
        self.notificationText = @"请输入用户名密码";
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
