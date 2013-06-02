//
//  PZNewsDetailData.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PZNewsDetailData : NSManagedObject

@property (nonatomic, copy) NSString * info;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * titleintact;
@property (nonatomic, copy) NSString * subheading;
@property (nonatomic, copy) NSString * keywords;
@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * copyfrom;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * introduce;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * imgurl;
@property (nonatomic, copy) NSString * numOfNews;
@property (nonatomic, copy) NSString * mark;

/*
 初始化成为一个对象
 */
-(id)initWithDictionary:(NSMutableDictionary *)aDict withNewsId:(NSString *)newsId;
/*
 从数据库中保存一条数据
 */
+ (void)insertADataInDatabase:(PZNewsDetailData *)detailData withNewsid:(NSString *)newsid;
/*
 从数据库中保存一条数据
 */
+ (void)insertDataDicInDatabase:(NSDictionary *)dataDictonary withNewsid:(NSString *)newsid;
/*
 从数据库中获取所以数据
 */
+ (NSArray *)loadADataInDatabase;
/*
 从数据库中获取一条数据
 */
+ (PZNewsDetailData *)loadADataInDatabaseWithNewsId:(NSString *)newsID;
/*
 从数据库中更新一条数据
 */
+ (void)updateDataFromDatabase:(PZNewsDetailData *)newsDetailData;
/*
 把url地址转换成本地路径名
 */
+ (NSString *)adressOfImage:(NSString *)urlText;
@end
