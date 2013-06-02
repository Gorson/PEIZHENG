//
//  JARightViewController+sinaMethod.m
//  培正梦飞翔
//
//  Created by Air on 13-3-31.
//
//

#import "JARightViewController+sinaMethod.h"

#import "SinaWeibo.h"


@implementation JARightViewController (sinaMethod)

#pragma mark -
#pragma mark SinaWeibo Delegate



/*
 * 账号登出
 */
- (void)logoutButtonPressed
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logOut];
}

/*
 *获取TCAppDelegate单例,返回程序下sinaweibo单一账号属性
 */
- (SinaWeibo *)sinaweibo
{
    JAAppDelegate *delegate = (JAAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

/*
 * 清空认证信息
 */
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

/*
 * 保存认证信息
 */
- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/*
 * 从api获取用户信息
 */
- (void)userInfoButtonPressed
{
    self.view.userInteractionEnabled = NO;
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
    
}


/*
 * 登入后状态协议
 */
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    
    [self storeAuthData];
    
    [self userInfoButtonPressed];
}

/*
 * 登出后状态协议
 */
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    DLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

/*
 * 登入取消状态协议
 */
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    DLog(@"sinaweiboLogInDidCancel");
}

/*
 * 登入失败状态协议
 */
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    DLog(@"sinaweibo logInDidFailWithError %@", error);
}

/*
 * 登入超时状态协议
 */
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    DLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
    
}

#pragma mark - SinaWeiboRequest Delegate
/*
 * api请求失败状态协议
 */
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [_userInfo release],_userInfo = nil;
    }
    
    
}

/*
 * api请求成功状态协议
 */
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [_userInfo release];
        _userInfo = (NSMutableDictionary *)[result retain];
    }
    SinaWeibo *sinaweibo = [self sinaweibo];
    NSMutableDictionary * midDict = [[[NSMutableDictionary alloc]initWithDictionary:_userInfo]autorelease];
    
    [midDict setValue:sinaweibo.accessToken forKey:@"weiboToken"];
    
}
@end
