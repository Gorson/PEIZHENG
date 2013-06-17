//
//  PZUserInfo.h
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PZUserInfo : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * uname;
@property (nonatomic, retain) NSString * realname;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * dorm;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * pcnumber;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * identity;

-(id)initWithDictionary:(NSMutableDictionary *)aDict;
/*
 从数据库中获取一组数据
 */
+ (NSArray *)loadDataInDatabase;
/*
 从数据库中获取一条数据
 */
+ (PZUserInfo *)loadADataInDatabaseWithUid:(NSString *)uid;
/*
从数据库中更新一条数据
*/
+ (void)updateDataFromDatabase:(PZUserInfo *)userInfo;
/*
从数据库中删除一条数据
*/
+ (void)deleteOneFromStorage:(PZUserInfo *)userInfo;
@end
