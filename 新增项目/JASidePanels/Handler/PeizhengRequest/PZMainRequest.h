//
//  PZMainNewsPictureRequest.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import <Foundation/Foundation.h>
#import "PZMainViewController.h"

@interface PZMainRequest : NSObject
{
    NSMutableArray *_elements;
    PZMainViewController *_mainViewController;
}

@property (nonatomic, copy) NSMutableArray *elements;
@property (nonatomic, retain) PZMainViewController *mainViewController;

- (void)MainNewsRequest;
@end
