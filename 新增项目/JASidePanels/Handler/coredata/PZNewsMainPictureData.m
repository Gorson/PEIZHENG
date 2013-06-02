//
//  PZNewsMainPictureData.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-14.
//
//

#import "PZNewsMainPictureData.h"


@implementation PZNewsMainPictureData

@dynamic databaseid;
@dynamic imgurl;
@dynamic introduce;
@dynamic newsid;
@dynamic time;
@dynamic title;

/*
 生成一个空的coredata对象
 @param entityName:实体对象的名称
 */
- (id)initEmpty:(NSString *)entityName {
    SetApp
	
	NSManagedObjectContext *context = [app managedObjectContext];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName
														 inManagedObjectContext:context];
	self = [super initWithEntity:entityDescription insertIntoManagedObjectContext:context];
	
	if (self != nil) {
		
	}
	
	return self;
}


/*
 插入数据到数据库
 */
- (void)insertAndSave {
	SetApp;
	
	NSManagedObjectContext *context = [app managedObjectContext];
	[context insertObject:self];
	
	NSError *error;
	if (![context save:&error]) {
		NSLog(@"Error while adding to database: %@", [error userInfo]);
	}
}


/*
 从数据库中删除一条数据
 */
- (void)deleteFromStorage {
	SetApp;
	
	NSManagedObjectContext *context = [app managedObjectContext];
	[context deleteObject:self];
	
	NSError *error;
	if (![context save:&error]) {
		NSLog(@"Error while deleting from database: %@", [error userInfo]);
	}
}



/*
 根据实体对象的名称得到所有的数据
 */
+ (NSArray *)getAll:(NSString *)entityName {
	SetApp;
	NSManagedObjectContext *context = [app managedObjectContext];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:[NSEntityDescription entityForName:entityName
								   inManagedObjectContext:context]];
	
	NSError *err = nil;
	NSArray *ret = [context executeFetchRequest:request error:&err];
	if(err != nil) {
		NSLog(@"DB error: %@", [err description]);
	}
	
	return ret;
}
@end
