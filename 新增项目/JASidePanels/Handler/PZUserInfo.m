//
//  PZUserInfo.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZUserInfo.h"


@implementation PZUserInfo

@dynamic uid;
@dynamic uname;
@dynamic realname;
@dynamic area;
@dynamic sex;
@dynamic dorm;
@dynamic email;
@dynamic pcnumber;
@dynamic phone;
@dynamic identity;

#pragma mark
#pragma mark - coredata

-(id)initWithDictionary:(NSMutableDictionary *)aDict{
    
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PZUserInfo"
														 inManagedObjectContext:theApp.managedObjectContext];
	self = [super initWithEntity:entityDescription insertIntoManagedObjectContext:theApp.managedObjectContext];
    if (self){
        self.uid = [[aDict objectForKey:@"uid"]copy];
        self.uname = [[aDict objectForKey:@"uname"]copy];
        self.realname = [[aDict objectForKey:@"realname"] copy];
        self.area = [[aDict objectForKey:@"area"] copy];
        self.sex = [[aDict objectForKey:@"sex"] copy];
        self.dorm = [[aDict objectForKey:@"dorm"] copy];
        self.email = [[aDict objectForKey:@"email"] copy];
        self.pcnumber = [[aDict objectForKey:@"pcnumber"] copy];
        self.phone = [[aDict objectForKey:@"phone"] copy];
        self.identity = [[aDict objectForKey:@"identity"] copy];
        
        NSError *error;
        if (![theApp.managedObjectContext save:&error]) {
            NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
        }
    }
    return self;
}

/*
 从数据库中获取一组数据
 */
+ (NSArray *)loadDataInDatabase
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PZUserInfo"
                                              inManagedObjectContext:theApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [theApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

/*
 从数据库中获取一条数据
 */
+ (PZUserInfo *)loadADataInDatabaseWithUid:(NSString *)uid
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PZUserInfo"
                                              inManagedObjectContext:theApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [theApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (PZUserInfo *newsDetailData in fetchedObjects) {
        if ([newsDetailData.uid isEqualToString:uid]) {
            return newsDetailData;
        }
    }
    return NULL;
}

/*
 从数据库中更新一条数据
 */
+ (void)updateDataFromDatabase:(PZUserInfo *)userInfo
{
    [theApp.managedObjectContext refreshObject:userInfo mergeChanges:YES];
    NSError *error;
    if (![theApp.managedObjectContext save:&error]) {
        NSLog(@"Error while deleting from database: %@", [error userInfo]);
    }
}

/*
 从数据库中删除一条数据
 */
+ (void)deleteOneFromStorage:(PZUserInfo *)userInfo {
	
	[theApp.managedObjectContext deleteObject:userInfo];
    
    NSError *error;
	if (![theApp.managedObjectContext save:&error]) {
		NSLog(@"Error while deleting from database: %@", [error userInfo]);
	}
}
@end
