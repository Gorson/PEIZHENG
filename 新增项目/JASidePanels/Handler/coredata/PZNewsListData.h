//
//  PZNewsListData.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PZNewsListData : NSManagedObject

@property (nonatomic) float newsidNum;
@property (nonatomic, copy) NSString * imgurl;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * introduce;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * databaseid;
@property (nonatomic, copy) NSString * typeOfNews;
@property (nonatomic, copy) NSString * mark;

/*
 从数据库中保存一条数据
 */
+ (void)insertADataInDatabase:(PZNewsListData *)listData;
/*
 从数据库中保存一条数据
 */
+ (void)insertDataDicInDatabase:(NSDictionary *)dataDictonary withCatid:(NSString *)catid;
/*
 从数据库中保存一组数据(未用)
 */
+ (void)insertDataInDatabase:(NSArray *)dataArray withCatid:(NSString *)catid;
/*
 从数据库中获取一条数据
 */
+ (PZNewsListData *)loadADataInDatabaseAtIndex:(NSInteger )index;
/*
 从数据库中获取一组数据
 */
+ (NSArray *)loadDataInDatabase;
/*
 从数据库中删除一条数据
 */
+ (void)deleteOneFromStorage:(PZNewsListData *)newsListData;
/*
 从数据库中删除一组数据
 */
+ (void)deleteMoreFromStorage:(NSArray *)newsListDataArray;
/*
 从数据库中更新一条数据
 */
+ (void)updateDataFromDatabase:(PZNewsListData *)newsListData;
/*
 把url地址转换成本地路径名
 */
+ (NSString *)adressOfImage:(NSString *)urlText;
@end
