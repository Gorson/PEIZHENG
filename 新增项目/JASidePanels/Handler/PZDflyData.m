//
//  PZDflyData.m
//  培正梦飞翔
//
//  Created by Air on 13-6-23.
//
//

#import "PZDflyData.h"

@implementation PZDflyData
@synthesize newsId;
@synthesize title;
@synthesize time;
@synthesize introduce;
@synthesize imgurl;
@synthesize width;
@synthesize height;

- (id)init
{
    if (self) {
        width = @"150";
        height = @"210";
    }
    return self;
}
@end
