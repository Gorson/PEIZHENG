//
//  PZDetailRequestViewController.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import <UIKit/UIKit.h>
#import "PZNewsDetailViewController.h"
#import "NewsDetailData.h"

@interface PZDetailRequest : NSObject
{
    PZNewsDetailViewController *_newsDetailViewController;
}
@property (nonatomic, retain) PZNewsDetailViewController *newsDetailViewController;
@property (nonatomic, copy) NSMutableArray *elements;

- (void)DetailRequest:(NSString *)newsid;
@end
