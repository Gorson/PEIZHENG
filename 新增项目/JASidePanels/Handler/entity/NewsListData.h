//
//  MosaicModule.h
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/21/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZNewsListData.h"

@interface NewsListData : PZNewsListData{    
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
@property (nonatomic) float newsidNum;

@end