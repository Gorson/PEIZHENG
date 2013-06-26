//
//  PZPCFormDetailViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-6-25.
//
//

#import "PZNavigationViewController.h"
@class PZDetailOfFormData;
@interface PZPCFormDetailViewController : PZNavigationViewController
{
    NSString * _oid;
}
@property (nonatomic, copy)NSString * oid;     //oid是单号
- (void)refreshViewControl:(PZDetailOfFormData *)detailOfFormData;
@end
