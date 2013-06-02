//
//  NewsMainPictureData.h
//  培正梦飞翔
//
//  Created by Air on 13-5-13.
//
//

#import <Foundation/Foundation.h>

@interface NewsMainPictureData : NSObject
{
    NSString * _newsid;       // 新闻id
    NSString * _databaseid;   // 数据库编号
    NSString * _title;        // 新闻标题
    NSString * _introduce;    // 新闻简介
    NSString * _time;         // 新闻发布时间
    NSString * _imgurl;       // 新闻插图
}

-(id)initWithDictionary:(NSDictionary *)aDict;

@property (nonatomic, copy) NSString * newsid;       // 新闻id
@property (nonatomic, copy) NSString * databaseid;   // 数据库编号
@property (nonatomic, copy) NSString * title;        // 新闻标题
@property (nonatomic, copy) NSString * introduce;    // 新闻简介
@property (nonatomic, copy) NSString * time;         // 新闻发布时间
@property (nonatomic, copy) NSString * imgurl;       // 新闻插图
@end
