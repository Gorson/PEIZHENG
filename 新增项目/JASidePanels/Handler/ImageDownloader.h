//
//  ImageDownloader.h
//  TicketChina
//
//  Created by yazhou jiang on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define kImageFinishedDownloadNotification @"ImageFinishedDownloadNotification"    // 常量，图片下载完成的通知

/*
 图片下载类
 */

/*
 图片下载的各种状态
 */
enum {
    kImageDownloaderStatusFailed = 0,    // 图片下载失败
    kImageDownloaderStatusSuccessed,    // 图片下载成功
    kImageDownloaderStatusInProgress    // 图片正在下载中
};

@interface ImageDownloader : NSObject {
	NSDate *startDownloadDate;    // 图片开始下载的时间
    NSMutableData *mutableData;    // 用来接收图片数据
    NSURLConnection *urlConnection;    // URLConnection对象
	
	NSInteger _nContentLength;    // 内容长度
}

@property (nonatomic, copy) NSString *strUrl;    // 下载图片的链接
@property (nonatomic, retain) UIImage *image;    // 图片对象

+ (ImageDownloader *)startDownload:(NSString *)urlText;    // 开始下载图片，并返回图片下载对象
- (void)startDownload;    // 开始下载

+ (UIImage *)loadImageFromCacheFile:(NSString *)urlText;    // 从本地缓存读取指定链接的图片
- (void)saveImageToCacheFile:(NSString *)urlText withImage:(NSData *)imageData;    // 用指定的链接保存图片到本地

@end
