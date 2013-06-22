//
//  PZDflyRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import <Foundation/Foundation.h>
#import "PZDflyViewController.h"

@interface PZDflyRequest : NSObject
{
    NSMutableArray *_elements;
    PZDflyViewController *_dflyViewController;
}
@property (nonatomic, copy) NSMutableArray *elements;
@property (nonatomic, retain) PZDflyViewController *dflyViewController;

- (void)DflyRequeat:(NSString *)catId;
@end
