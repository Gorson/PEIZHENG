////
////  MosaicModule.h
////  MosaicUI
////
////  Created by Ezequiel Becerra on 10/21/12.
////  Copyright (c) 2012 betzerra. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@interface MosaicData : NSObject{
//    NSString * _size;         // 新闻插图大小
//    
//    NSString * _newsid;       // 新闻id
//    NSString * _databaseid;   // 数据库编号
//    NSString * _title;        // 新闻标题
//    NSString * _introduce;    // 新闻简介
//    NSString * _time;         // 新闻发布时间
//    NSString * _imgurl;       // 新闻插图
//    NSString * _imageFilename;// 图片文件名
//}
//
//-(id)initWithDictionary:(NSDictionary *)aDict;
//
//@property (nonatomic, copy) NSString * newsid;       // 新闻id
//@property (nonatomic, copy) NSString * databaseid;   // 数据库编号
//@property (nonatomic, copy) NSString * title;        // 新闻标题
//@property (nonatomic, copy) NSString * introduce;    // 新闻简介
//@property (nonatomic, copy) NSString * time;         // 新闻发布时间
//@property (nonatomic, copy) NSString * imgurl;       // 新闻插图
//@property (nonatomic, copy) NSString * imageFilename;// 图片文件名
//
//@property (nonatomic, copy) NSString * size;         // 新闻插图大小
//
//@end

//
//  MosaicModule.h
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/21/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MosaicData : NSObject{
    NSString *imageFilename;
    NSString *title;
    NSInteger size;
    NSString * catid;
}

-(id)initWithDictionary:(NSDictionary *)aDict;

@property (strong) NSString *imageFilename;
@property (strong) NSString *title;
@property (strong) NSString * catid;
//catid：新闻种类编号。
//校园探报：45	    培正今日：77	    社团风采：102
//学生组织：101	红人馆：169		D-Fly视觉：51
//培正周边：223	PC学堂：246

@property (readwrite) NSInteger size;

@end
