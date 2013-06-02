//
//  MosaicModule.m
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/21/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "NewsListData.h"

@implementation NewsListData
@synthesize newsid = _newsid;
@synthesize databaseid = _databaseid;
@synthesize title = _title;
@synthesize introduce = _introduce;
@synthesize time = _time;
@synthesize imgurl = _imgurl;
@synthesize newsidNum;


-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        id newsid = [aDict valueForKey:@"newsid"];
        newsidNum = [newsid intValue];
        _databaseid = [[aDict objectForKey:@"databaseid"] copy];
        _title = [[aDict objectForKey:@"title"] copy];
        if ([aDict objectForKey:@"introduce"] != NULL) {
            _introduce = [[aDict objectForKey:@"introduce"] copy];
        }
        _time = [[aDict objectForKey:@"time"] copy];
        if ([aDict objectForKey:@"imgurl"] != NULL) {
            if ([[aDict objectForKey:@"imgurl"] hasSuffix:@"http"]) {
                _imgurl = [[aDict objectForKey:@"imgurl"] copy];
            }
            else
            {
                _imgurl = [[NSString stringWithFormat:@"http://www.peizheng.cn/%@",[aDict objectForKey:@"imgurl"]] copy];
            }
        }
        else
        {
            _imgurl = [[NSString stringWithFormat:@"http://news.vrhr.com/node_137/node_140/img/2009/06/17/124520698535082_1.jpg"] copy];
        }
        
    }
    return self;
}

-(NSString *)description{
    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
    return retVal;
}

@end