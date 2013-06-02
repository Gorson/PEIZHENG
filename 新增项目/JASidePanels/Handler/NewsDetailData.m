//
//  PZNewsDetailData.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import "NewsDetailData.h"
#import "TFHpple.h"

@implementation NewsDetailData
@synthesize info = _info;
@synthesize title = _title;
@synthesize titleintact = _titleintact;
@synthesize subheading = _subheading;
@synthesize keywords = _keywords;
@synthesize author = _author;
@synthesize content = _content;
@synthesize copyfrom = _copyfrom;
@synthesize introduce = _introduce;
@synthesize time = _time;
@synthesize imgurl = _imgurl;
@synthesize contentArray = _contentArray;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        _content = [[NSMutableString alloc]initWithCapacity:10000];
//        _info = [[aDict objectForKey:@"info"] copy];
        _title = [[aDict objectForKey:@"title"] copy];
        _time = [[aDict objectForKey:@"time"] copy];
//        _imgurl = [[aDict objectForKey:@"imgurl"] copy];
        _titleintact = [[aDict objectForKey:@"titleintact"] copy];
        _subheading = [[aDict objectForKey:@"subheading"] copy];
        _keywords = [[aDict objectForKey:@"keywords"] copy];
        _author = [[aDict objectForKey:@"author"] copy];
//        _content = [[aDict objectForKey:@"content"] copy];
        _contentArray = [[self AnalyticalDetail:[aDict objectForKey:@"content"]] copy];
        for (NSString *contentString in _contentArray)
        {
            [_content appendFormat:@"      %@\n",contentString];
        }
//        [_content copy];
        _copyfrom = [[aDict objectForKey:@"copyfrom"] copy];
        _introduce = [[aDict objectForKey:@"introduce"] copy];
        
    }
    return self;
}

-(NSString *)description{
    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
    return retVal;
}

#pragma  Detail
-(NSArray *)AnalyticalDetail:(NSString *)String{
    
    NSData *dataTitle=[String dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements = [xpathParser searchWithXPathQuery:@"//font"];
    if (![elements count]) {
        elements = [xpathParser searchWithXPathQuery:@"//span"];
        if (![elements count]) {
            _contentArray = [NSArray arrayWithObject:_title];
            return _contentArray;
        }
    }
    
    NSMutableArray *_detailArray=[[NSMutableArray alloc]init];
    
    
    for (TFHppleElement *element in elements)
    {
        NSString *elementContent =[element content];
        // NSLog(@"%@",[elementContent objectForKey:@"src"]);
        if ([elementContent length] < 1)
        {
            DLog(@"乜都唔洗做..");
        }
        else
        {
            [_detailArray addObject:elementContent];
        }
    }
    
    return _detailArray;
    
    
}
@end
