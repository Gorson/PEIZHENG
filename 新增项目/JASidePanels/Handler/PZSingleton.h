//
//  PZSingleton.h
//  TickePZhina
//
//  Created by liu jiada on 11/29/11.
//  Copyright (c) 2011 Wistronits. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "Venues_Item.h"
//#import "alipay_Item.h"
/*
 单例类，用来存放全局变量
 */
@interface PZSingleton : NSObject

//@property (nonatomic, retain) user_info *userinfo;             // 用户登陆后的信息对象
//@property (nonatomic, retain) getFriends_item * getFriendsItem; // 用户登陆后的好友列表
//@property (nonatomic, retain) city_list_Item *cityItem;        // 用户选择的城市
//@property (nonatomic, retain) Venues_Item *venuesItem;         // 电影院对象
//@property (nonatomic, retain) NSArray *provinces;              // 省份数组

+ (id)sharedSingleton;    // 单例对象
- (BOOL)isNetworkAvailable;    // 检测网络是否可用

@end


@interface PZSingleton(File)

- (NSString *)systemfilePathAppendFileName:(NSString *)fileName;    // 根据文件名得到本地文件的路径

- (UIImage *)loadImageFromCacheFile:(NSString *)urlText path:(NSString *)path;    // 根据链接从本地读取图片
- (void)saveImageToCacheFile:(NSString *)urlText withImage:(NSData *)imageData path:(NSString *)path;    //  根据链接将图片保存到本地

@end
