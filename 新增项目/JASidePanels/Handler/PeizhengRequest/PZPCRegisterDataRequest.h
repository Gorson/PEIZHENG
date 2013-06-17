//
//  PZPCRegisterDataRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import <Foundation/Foundation.h>
#import "userRegist.h"

@interface PZPCRegisterDataRequest : NSObject
{
    userRegist *_user;
}
@property (nonatomic,retain) userRegist *user;
-(void)PCRegisterDataRequest;
@end
