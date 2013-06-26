//
//  PZDetailOfFormData.m
//  培正梦飞翔
//
//  Created by Air on 13-6-25.
//
//

#import "PZDetailOfFormData.h"

@implementation PZDetailOfFormData
@synthesize area;
@synthesize booktime;
@synthesize computertype;
@synthesize dorm;
@synthesize listid;
@synthesize pcnumber;
@synthesize phone;
@synthesize remark;
@synthesize reviewlevel;
@synthesize state;
@synthesize time;
@synthesize uname;
@synthesize type;

-(id)initWithDictionary:(NSMutableDictionary *)aDict
{
    self.booktime = [[aDict objectForKey:@"booktime"]copy];
    self.uname = [[aDict objectForKey:@"uname"]copy];
    self.computertype = [[aDict objectForKey:@"computertype"] copy];
    self.listid = [[aDict objectForKey:@"listid"] copy];
    self.state = [[aDict objectForKey:@"state"] copy];
    self.area = [[aDict objectForKey:@"area"] copy];
    self.dorm = [[aDict objectForKey:@"dorm"]copy];
    self.pcnumber = [[aDict objectForKey:@"pcnumber"]copy];
    self.phone = [[aDict objectForKey:@"phone"] copy];
    self.remark = [[aDict objectForKey:@"remark"] copy];
    self.reviewlevel = [[aDict objectForKey:@"reviewlevel"] copy];
    self.time = [[aDict objectForKey:@"time"] copy];
    self.type = [[aDict objectForKey:@"type"] copy];
    return self;
}
@end
