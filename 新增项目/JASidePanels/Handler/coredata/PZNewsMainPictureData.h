//
//  PZNewsMainPictureData.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PZNewsMainPictureData : NSManagedObject

@property (nonatomic, copy) NSString * databaseid;
@property (nonatomic, copy) NSString * imgurl;
@property (nonatomic, copy) NSString * introduce;
@property (nonatomic, copy) NSString * newsid;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * title;

@end
