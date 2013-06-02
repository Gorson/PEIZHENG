//
//  PZImageDownloader.h
//  DiscountHands
//
//  Created by Asian Jiang on 3/7/11.
//  Copyright 2011 Wistronits. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 图片下载类
 */
@class HttpRequest;

@protocol PZImageDownloaderDelegate;

@interface PZImageDownloader : NSObject {
	NSIndexPath *indexPath;    // 图片下载的索引对象，用来标识下载对象
    NSString *imageURL;    // 图片下载链接
	id<PZImageDownloaderDelegate> delegate;    // 代理对象
    
    HttpRequest *_httpRequest;    // http请求对象
    BOOL _isFinishedLoading;    // 是否已经加载完成
}

@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, assign) id<PZImageDownloaderDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL bReDownload;    // 是否需要重新下载
@property (nonatomic, copy) NSString * tagStr ;

- (void)startDownload;    // 开始下载
- (void)cancelDownload;    // 取消下载

@end


/*
 协议，用来确定图片下载的状态信息
 */
@protocol PZImageDownloaderDelegate<NSObject>

@optional

- (void)imageDidLoad:(NSInteger)index Image:(UIImage *)image Downloader:(PZImageDownloader *)downloader;    // 图片下载成功
- (void)imageDidLoadError:(NSInteger)index Error:(NSError *)error Downloader:(PZImageDownloader *)downloader;    // 图片下载失败

@end
