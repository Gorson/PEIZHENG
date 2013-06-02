//
//  AsynImageView.m
//  TicketChina
//
//  Created by liu jiada on 09-12-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import "AsynHeadImageView.h"


@implementation AsynHeadImageView

@synthesize imageDownloader;
@synthesize imageUrl;


/*
 停止下载
 */
- (void)stopDownload {
    if(self.imageDownloader) {
		[[NSNotificationCenter defaultCenter] removeObserver:self];
		self.imageDownloader = nil;
	}
}


/*
 重写imageUrl的set方法，在imageUrl被赋予值的同时，去服务器去下载图片
 */
- (void)setImageUrl:(NSString *)newImageUrl {
    [newImageUrl retain];
    [imageUrl autorelease];
    imageUrl = newImageUrl;
    
    // 首先加载缓存数据，如果没有，从服务器获取
    UIImage *imageCache = [ImageDownloader loadImageFromCacheFile:imageUrl];
    if(imageCache) {
        self.image = imageCache;
        
        return;
    }
    
    // 开始下载图片
    self.imageDownloader = [ImageDownloader startDownload:imageUrl];
    if(self.imageDownloader) {
        //获取一个随机整数范围在：[0,100)包括0，不包括100
        int x = arc4random() % 20;
        
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb%d.jpg",x+1]];
        // 使用通知监听图片的下载状态
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dealImageFinishedDownloadNotification:)
                                                     name:kImageFinishedDownloadNotification
                                                   object:self.imageDownloader];
    }
}


/*
 图片下载完后的处理
 */
- (void)dealImageFinishedDownloadNotification:(NSNotification *)notification {
	if(self.imageDownloader != nil && self.imageDownloader == notification.object) {
		NSDictionary *userInfo = notification.userInfo;
		NSString *strType = [userInfo valueForKey:@"type"];
		int nType = [strType intValue];
        // 图片下载失败
		if(nType == kImageDownloaderStatusFailed) {
            [self stopDownload];
            // 图片下载成功
		} else if(nType == kImageDownloaderStatusSuccessed) {
            [self setImageUrl:self.imageUrl];
            [self stopDownload];
		}
	}
}



@end