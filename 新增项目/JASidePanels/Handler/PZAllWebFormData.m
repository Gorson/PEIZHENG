//
//  PZAllWebFormData.m
//  培正梦飞翔
//
//  Created by Air on 13-6-24.
//
//

#import "PZAllWebFormData.h"

@implementation PZAllWebFormData
@synthesize booktime;
@synthesize computertype;
@synthesize listid;
@synthesize state;
@synthesize submittime;
@synthesize uname;

-(id)initWithDictionary:(NSMutableDictionary *)aDict
{
    self.booktime = [[aDict objectForKey:@"booktime"]copy];
    self.uname = [[aDict objectForKey:@"uname"]copy];
    self.computertype = [[aDict objectForKey:@"computertype"] copy];
    self.listid = [[aDict objectForKey:@"listid"] copy];
    self.state = [[aDict objectForKey:@"state"] copy];
    self.submittime = [[aDict objectForKey:@"submittime"] copy];
    return self;
}

@end
