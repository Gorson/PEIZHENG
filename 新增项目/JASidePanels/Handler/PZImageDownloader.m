//
//  PZImageDownloader.m
//  DiscountHands
//
//  Created by Asian Jiang on 3/7/11.
//  Copyright 2011 Wistronits. All rights reserved.
//

#import "PZImageDownloader.h"

#import "HttpRequest.h"
#import "PZSingleton.h"

@interface PZImageDownloader()<HttpRequestDelegate>

@end


@implementation PZImageDownloader

@synthesize imageIndex;
@synthesize imageURL;
@synthesize delegate;
@synthesize indexPath;
@synthesize bReDownload;
@synthesize tagStr;


#pragma mark -
#pragma mark HttpRequestDelegate

/*
 Http代理方法，已经接收完图片数据，并回调给代理对象
 */
- (void)didFinishedLoadData:(NSMutableData *)data Request:(HttpRequest *)httpRequest {
    _isFinishedLoading = YES;
    
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithData:data]];
    [[PZSingleton sharedSingleton] saveImageToCacheFile:self.imageURL
                                              withImage:data
                                                   path:@"Images"];
    
	if([delegate respondsToSelector:@selector(imageDidLoad:Image:Downloader:)]) {
		[delegate imageDidLoad:imageIndex Image:image Downloader:self];
	}
    
    [image release];
    image = nil;
    
    [httpRequest release];
    httpRequest = nil;
}


/*
 Http代理方法，下载图片数据失败，并回调给代理对象
 */
- (void)didFailedLoadData:(NSError *)error Request:(HttpRequest *)httpRequest {
    _isFinishedLoading = YES;
    
    if([delegate respondsToSelector:@selector(imageDidLoadError:Error:Downloader:)]) {
        [delegate imageDidLoadError:imageIndex Error:error Downloader:self];
    }
    
    [httpRequest release];
    httpRequest = nil;
}


#pragma mark -
#pragma mark Memory management

/*
 内存释放
 */
- (void)dealloc {
    [imageURL release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Public Methods

/*
 开始下载数据
 */
- (void)startDownload {
    // 判断本地是否缓存了该链接的图片，如果有且不需要重新下载，则直接回调，否则重新下载
    UIImage *image = [[PZSingleton sharedSingleton] loadImageFromCacheFile:self.imageURL path:@"Images"];
    if(image && !self.bReDownload) {
        _isFinishedLoading = YES;
        if([delegate respondsToSelector:@selector(imageDidLoad:Image:Downloader:)]) {
            [delegate imageDidLoad:imageIndex Image:image Downloader:self];
        }
    } else {
        _isFinishedLoading = NO;
        
        _httpRequest = [[HttpRequest alloc] init];
        _httpRequest.httpRequestDelegate = self;
        _httpRequest.urlString = imageURL;
        [_httpRequest sendHttpRequest:HTTPGET];
    }
}


/*
 取消图片下载
 */
- (void)cancelDownload {
    if(!_isFinishedLoading) {
        if(_httpRequest) {
            [_httpRequest cancelHttpRequest];
        }
    }
    
    delegate = nil;
}

@end
