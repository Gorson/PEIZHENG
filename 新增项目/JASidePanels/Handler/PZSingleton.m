//
//  PZSingleton.m
//  TickePZhina
//
//  Created by liu jiada on 11/29/11.
//  Copyright (c) 2011 Wistronits. All rights reserved.
//

#import "PZSingleton.h"

#import "Reachability.h"

static PZSingleton *sharedSingleton = nil;

@implementation PZSingleton

//@synthesize userinfo;
//@synthesize cityItem;
//@synthesize provinces;
//@synthesize venuesItem;
//@synthesize getFriendsItem;
#pragma mark -
#pragma mark Init

/*
 单例对象
 */
+ (id)sharedSingleton {
    @synchronized(self) {
        if(sharedSingleton == nil)
            sharedSingleton = [[self alloc] init];
    }
    
    return sharedSingleton;
}


/*
 监测网络是否可用
 */
- (BOOL)isNetworkAvailable {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return (networkStatus != kNotReachable);
}


@end


@implementation PZSingleton (File)


/*
 根据文件名得到本地文件的路径
 */
- (NSString *)systemfilePathAppendFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths lastObject];
    if(!fileName) {
        return documentsDirectory;
    }
    
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}


/*
 根据链接从本地读取图片
 */
- (UIImage *)loadImageFromCacheFile:(NSString *)urlText path:(NSString *)path {
	urlText = [urlText stringByReplacingOccurrencesOfString:@"http://" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@":" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:path];
	NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
    
	UIImage *image = [UIImage imageWithContentsOfFile:filename];
    
	return image;
}

/*
 根据链接将图片保存到本地
 */
- (void)saveImageToCacheFile:(NSString *)urlText withImage:(NSData *)imageData path:(NSString *)path {
	urlText = [urlText stringByReplacingOccurrencesOfString:@"http://" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@":" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:path];
	BOOL isDirectory = NO;
	if ( [[NSFileManager defaultManager] fileExistsAtPath:filepath isDirectory:&isDirectory]) {
		if ( isDirectory ) {
			NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
			[imageData writeToFile:filename atomically:YES];
		}
	} else {
        [[NSFileManager defaultManager] createDirectoryAtPath:filepath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
        [imageData writeToFile:filename atomically:YES];
	}
}

@end
