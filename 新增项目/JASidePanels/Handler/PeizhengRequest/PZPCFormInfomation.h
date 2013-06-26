//
//  PZPCRegisterDataRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import <Foundation/Foundation.h>
@class PZPCFormDetailViewController;

@interface PZPCFormInfomation : NSObject
{
    NSString * _oid;
    PZPCFormDetailViewController *_pcFormDetailViewController;
}
@property (nonatomic, copy)NSString * oid;                                 //oid是单号
@property (nonatomic, retain)PZPCFormDetailViewController *pcFormDetailViewController;
-(void)PCFormInfomation;
@end
