//
//  PZNewsDetailData.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import <Foundation/Foundation.h>

@interface NewsDetailData : NSObject
{
    NSString * _info;           // 数据存在信息
    NSString * _title;          // 新闻标题
    NSString * _titleintact;    // 新闻标题接触
    NSString * _subheading;     // 副标题
    NSString * _keywords;       // 关键字
    NSString * _author;         // 新闻作者
    NSString * _copyfrom;       // 原创平台
    NSMutableString * _content; // 新闻内容
    NSString * _introduce;      // 新闻简介
    NSString * _time;           // 新闻发布时间
    NSString * _imgurl;         // 新闻插图
    NSArray * _contentArray;    // 内容数组
}

-(id)initWithDictionary:(NSDictionary *)aDict;

@property (nonatomic, copy) NSString * info;           // 数据存在信息
@property (nonatomic, copy) NSString * title;          // 新闻标题
@property (nonatomic, copy) NSString * titleintact;    // 新闻标题接触
@property (nonatomic, copy) NSString * subheading;     // 副标题
@property (nonatomic, copy) NSString * keywords;       // 关键字
@property (nonatomic, copy) NSString * author;         // 新闻作者
@property (nonatomic, copy) NSString * copyfrom;       // 原创平台
@property (nonatomic, copy) NSMutableString * content; // 新闻内容
@property (nonatomic, copy) NSString * introduce;      // 新闻简介
@property (nonatomic, copy) NSString * time;           // 新闻发布时间
@property (nonatomic, copy) NSString * imgurl;         // 新闻插图
@property (nonatomic, copy) NSArray * contentArray;    // 内容数组

@end
