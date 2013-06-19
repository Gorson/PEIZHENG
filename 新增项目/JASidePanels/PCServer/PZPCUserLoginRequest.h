//
//  PZPCUserLoginRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import <Foundation/Foundation.h>
#import "PZUserInfo.h"
@class PZPCServerViewController;
@class PZPCUserLoginRequest;

@interface PZPCUserLoginRequest : NSObject
{
    NSString *_username;
    NSString *_password;
    PZPCServerViewController *_pcServerViewController;
    PZUserInfo *_user;
}
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,retain) PZUserInfo *_user;
@property (nonatomic,retain) PZPCServerViewController *pcServerViewController;
- (void)PCUserLoginRequest;
@end
