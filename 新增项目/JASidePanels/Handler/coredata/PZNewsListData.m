//
//  PZNewsListData.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-14.
//
//

#import "PZNewsListData.h"

@interface PZNewsListData()
@end

@implementation PZNewsListData
@dynamic newsidNum;
@dynamic imgurl;
@dynamic time;
@dynamic introduce;
@dynamic title;
@dynamic databaseid;
@dynamic typeOfNews;
@dynamic mark;

#pragma mark
#pragma mark - coredata

/*
 从数据库中保存一条数据
 */
+ (void)insertADataInDatabase:(PZNewsListData *)listData
{
    PZNewsListData *newsListData = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"PZNewsListData"
                                    inManagedObjectContext:theApp.managedObjectContext];
    newsListData.typeOfNews = listData.typeOfNews;
    newsListData.imgurl = listData.imgurl;
    newsListData.title = listData.title;
    newsListData.time = listData.time;
    newsListData.databaseid = listData.databaseid;
    newsListData.introduce = listData.introduce;
    newsListData.newsidNum = listData.newsidNum;
    
    NSError *error;
    if (![theApp.managedObjectContext save:&error]) {
        NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
    }
}

/*
 从数据库中保存一条数据
 */
+ (void)insertDataDicInDatabase:(NSDictionary *)dataDictonary withCatid:(NSString *)catid
{
        PZNewsListData *newsListData = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"PZNewsListData"
                                        inManagedObjectContext:theApp.managedObjectContext];
        newsListData.typeOfNews = catid;
        
        if ([dataDictonary objectForKey:@"imgurl"]!= NULL) {
            if ([[dataDictonary objectForKey:@"imgurl"] hasPrefix:@"http"])
            {
                newsListData.imgurl = [dataDictonary objectForKey:@"imgurl"];
            }
            else if([[dataDictonary objectForKey:@"imgurl"] hasPrefix:@"uploadfile"])
            {
                newsListData.imgurl = [NSString stringWithFormat:@"http://www.peizheng.cn/%@",[dataDictonary objectForKey:@"imgurl"]];
            }else
            {
                //获取一个随机整数范围在：[0,100)包括0，不包括100
                int x = arc4random() % 20;
                newsListData.imgurl = [NSString stringWithFormat:@"/var/mobile/Applications/9D2D7221-5E15-4C4A-B29C-3358EAD848B7/培正梦飞翔.app/%@",[NSString stringWithFormat:@"tb%d.jpg",x+1]];
            }
        }
        else
        {
            //获取一个随机整数范围在：[0,100)包括0，不包括100
            int x = arc4random() % 20;
            newsListData.imgurl = [NSString stringWithFormat:@"/var/mobile/Applications/9D2D7221-5E15-4C4A-B29C-3358EAD848B7/培正梦飞翔.app/%@",[NSString stringWithFormat:@"tb%d.jpg",x+1]];
        }
        
        newsListData.title = [dataDictonary objectForKey:@"title"];
        newsListData.time = [dataDictonary objectForKey:@"time"];
        newsListData.databaseid = [dataDictonary objectForKey:@"databaseid"];
        newsListData.introduce = [dataDictonary objectForKey:@"introduce"];
        id newsid = [dataDictonary valueForKey:@"newsid"];
        newsListData.newsidNum = [newsid intValue];
        
        NSError *error;
        if (![theApp.managedObjectContext save:&error]) {
            NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
        }
}

/*
 从数据库中保存一组数据
 */
+ (void)insertDataInDatabase:(NSArray *)dataArray withCatid:(NSString *)catid
{
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PZNewsListData *newsListData = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"PZNewsListData"
                                        inManagedObjectContext:theApp.managedObjectContext];
        newsListData.typeOfNews = catid;
        
        if ([obj objectForKey:@"imgurl"]!= NULL) {
            if ([[obj objectForKey:@"imgurl"] hasPrefix:@"http"])
            {
                newsListData.imgurl = [obj objectForKey:@"imgurl"];
            }
            else if([[obj objectForKey:@"imgurl"] hasPrefix:@"uploadfile"])
            {
                newsListData.imgurl = [NSString stringWithFormat:@"http://www.peizheng.cn/%@",[obj objectForKey:@"imgurl"]];
            }else
            {
                //获取一个随机整数范围在：[0,100)包括0，不包括100
                int x = arc4random() % 20;
                newsListData.imgurl = [NSString stringWithFormat:@"/var/mobile/Applications/9D2D7221-5E15-4C4A-B29C-3358EAD848B7/培正梦飞翔.app/%@",[NSString stringWithFormat:@"tb%d.jpg",x+1]];
            }
        }
        else
        {
            //获取一个随机整数范围在：[0,100)包括0，不包括100
            int x = arc4random() % 20;
            newsListData.imgurl = [NSString stringWithFormat:@"/var/mobile/Applications/9D2D7221-5E15-4C4A-B29C-3358EAD848B7/培正梦飞翔.app/%@",[NSString stringWithFormat:@"tb%d.jpg",x+1]];
        }
        
        newsListData.title = [obj objectForKey:@"title"];
        newsListData.time = [obj objectForKey:@"time"];
        newsListData.databaseid = [obj objectForKey:@"databaseid"];
        newsListData.introduce = [obj objectForKey:@"introduce"];
        id newsid = [obj valueForKey:@"newsid"];
        newsListData.newsidNum = [newsid intValue];
        
        NSError *error;
        if (![theApp.managedObjectContext save:&error]) {
            NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
        }
    }];
}

/*
 从数据库中获取一条数据
 */
+ (PZNewsListData *)loadADataInDatabaseAtIndex:(NSInteger )index
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PZNewsListData"
                                              inManagedObjectContext:theApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [theApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    PZNewsListData *newsListData = [fetchedObjects objectAtIndex:index];
    DLog(@"%@",newsListData.title);
    
    return newsListData;
}


/*
 从数据库中获取一组数据
 */
+ (NSArray *)loadDataInDatabase
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PZNewsListData"
                                              inManagedObjectContext:theApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [theApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

/*
 从数据库中删除一条数据
 */
+ (void)deleteOneFromStorage:(PZNewsListData *)newsListData {
	
	[theApp.managedObjectContext deleteObject:newsListData];
    
    NSError *error;
	if (![theApp.managedObjectContext save:&error]) {
		NSLog(@"Error while deleting from database: %@", [error userInfo]);
	}
}

/*
 从数据库中删除一组数据
 */
+ (void)deleteMoreFromStorage:(NSArray *)newsListDataArray
{
    [newsListDataArray enumerateObjectsUsingBlock:^(PZNewsListData* newsListData, NSUInteger idx, BOOL *stop)
     {
         [theApp.managedObjectContext deleteObject:newsListData];
         
         NSError *error;
         if (![theApp.managedObjectContext save:&error]) {
             NSLog(@"Error while deleting from database: %@", [error userInfo]);
         }
     }];
    
}

/*
 从数据库中更新一条数据
 */
+ (void)updateDataFromDatabase:(PZNewsListData *)newsListData
{
    [theApp.managedObjectContext refreshObject:newsListData mergeChanges:YES];
    NSError *error;
    if (![theApp.managedObjectContext save:&error]) {
        NSLog(@"Error while deleting from database: %@", [error userInfo]);
    }
}


+ (NSString *)adressOfImage:(NSString *)urlText
{
    urlText = [urlText stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    urlText = [urlText stringByReplacingOccurrencesOfString:@":" withString:@""];
    urlText = [urlText stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"photo"];
    NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
//    NSURL * imageUrl = [NSURL URLWithString:filename];
    
    return filename;
}
@end
