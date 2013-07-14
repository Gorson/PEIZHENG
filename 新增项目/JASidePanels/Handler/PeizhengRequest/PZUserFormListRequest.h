//
//  PZUserFormListRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-7-13.
//
//

#import <Foundation/Foundation.h>
#import "PZUserFormList.h"

@interface PZUserFormListRequest : NSObject
{
    PZUserFormList *_user;
}

@property (nonatomic,retain)PZUserFormList *user;
-(void)PZUserFormListRequest;
@end
