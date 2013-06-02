////
////  MosaicModule.m
////  MosaicUI
////
////  Created by Ezequiel Becerra on 10/21/12.
////  Copyright (c) 2012 betzerra. All rights reserved.
////
//
//#import "MosaicData.h"
//
//@implementation MosaicData
//@synthesize newsid = _newsid;
//@synthesize databaseid = _databaseid;
//@synthesize title = _title;
//@synthesize introduce = _introduce;
//@synthesize time = _time;
//@synthesize imgurl = _imgurl;
//@synthesize size = _size;
//@synthesize imageFilename = _imageFilename;
//
//-(id)initWithDictionary:(NSDictionary *)aDict{
//    self = [self init];
//    if (self){
////        _newsid = [aDict objectForKey:@"newsid"];
////        _databaseid = [aDict objectForKey:@"databaseid"];
//        _title = [aDict objectForKey:@"title"];
////        if (_introduce) {
////            _introduce = [aDict objectForKey:@"introduce"];
////        }
////        _time = [aDict objectForKey:@"time"];
////        if (_imgurl) {
////            _imgurl = [aDict objectForKey:@"imgurl"];
////        }
//        
////        srand((unsigned)time(0));  //不加这句每次产生的随机数不变
//        _size = [aDict objectForKey:@"size"];
//        _imageFilename = [aDict objectForKey:@"imageFilename"];
//    }
//    return self;
//}
//
//-(NSString *)description{
//    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
//    return retVal;
//}
//
//@end

//
//  MosaicModule.m
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/21/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "MosaicData.h"

@implementation MosaicData
@synthesize imageFilename, title, size, catid;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        self.imageFilename = [[aDict objectForKey:@"imageFilename"] copy];
        self.size = [[aDict objectForKey:@"size"] integerValue];
        self.title = [[aDict objectForKey:@"title"] copy];
        self.catid = [[aDict objectForKey:@"catid"] copy];
    }
    return self;
}

-(NSString *)description{
    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
    return retVal;
}

@end
