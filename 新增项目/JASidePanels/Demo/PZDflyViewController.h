//
//  PZDflyViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import "PZNavigationViewController.h"

@interface PZDflyViewController : PZNavigationViewController
{
    NSMutableArray *_dflyItemArray;
    NSString *_catid;
}
@property (nonatomic, retain) NSMutableArray *dflyItemArray;
@property (nonatomic, copy) NSString *catid;
@end
