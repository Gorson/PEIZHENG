//
//  ImageDownloader.h
//  TicketChina
//
//  Created by yazhou jiang on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader()

@property (nonatomic, retain) NSDate *startDownloadDate;
@property (nonatomic, retain) NSMutableData *mutableData;
@property (nonatomic, retain) NSURLConnection *urlConnection;

- (void)postDownloadSucc;    // 发送图片下载成功的通知
- (void)postDownloadFail;    // 发送图片下载失败的通知
- (void)postDownloadProgress:(int)nPercent;    // 发送图片下载进度的通知

@end


@implementation ImageDownloader

@synthesize startDownloadDate, mutableData, urlConnection;

@synthesize strUrl;
@synthesize image;

#pragma mark -
#pragma mark Memory management

/*
 内存释放
 */

- (void)dealloc {
    self.startDownloadDate = nil;
    self.mutableData = nil;
    self.urlConnection = nil;
    
    self.strUrl = nil;
    self.image = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark Public


/*
 开始下载图片，并返回图片下载对象
 */
+ (ImageDownloader *)startDownload:(NSString *)strUrl {
    if(strUrl && strUrl.length > 0) {
        // 首先读取缓存，如果有则直接返回，没有则从服务器去下载
		UIImage *imageCache = [ImageDownloader loadImageFromCacheFile:strUrl];
		if(imageCache == nil) {
			ImageDownloader *imageDownloader = [[[ImageDownloader alloc] init] autorelease];
            imageDownloader.strUrl = strUrl;
            [imageDownloader startDownload];
            
            return imageDownloader;
		}
    }
    
	return nil;
}


/*
 开始下载图片数据
 */
- (void)startDownload {
	self.startDownloadDate = [NSDate date];
	self.mutableData = [[[NSMutableData alloc] initWithCapacity:1024] autorelease];
    
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]
                                                                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                                                  timeoutInterval:120.0] delegate:self];
	self.urlConnection = conn;
	[conn release];
}


/*
 重新下载图片数据
 */
- (void)restartDownload {
	self.mutableData = [[[NSMutableData alloc] initWithCapacity:1024] autorelease];
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]
                                                                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                                                  timeoutInterval:120.0] delegate:self];
	self.urlConnection = conn;
	[conn release];
}


/*
 取消图片下载
 */
- (void)cancelDownload {
    [self.urlConnection cancel];
    self.urlConnection = nil;
    self.mutableData = nil;
}


/*
 从本地缓存读取指定链接的图片
 */
+ (UIImage *)loadImageFromCacheFile:(NSString *)urlText {
	if([urlText isEqualToString:@"null"] )
		return nil;
	
	urlText = [urlText stringByReplacingOccurrencesOfString:@"http://" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@":" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"photo"];
	NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
	UIImage *image = [UIImage imageWithContentsOfFile:filename];
    
	return image;
}


/*
 用指定的链接保存图片到本地
 */
- (void)saveImageToCacheFile:(NSString *)urlText withImage:(NSData *)imageData {
	urlText = [urlText stringByReplacingOccurrencesOfString:@"http://" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@":" withString:@""];
	urlText = [urlText stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"photo"];
	BOOL isDirectory = NO;
	if([[NSFileManager defaultManager] fileExistsAtPath:filepath isDirectory:&isDirectory]) {
		if(isDirectory) {
			NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
			[imageData writeToFile:filename atomically:YES];
		}
	} else {
		[[NSFileManager defaultManager]createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error: nil];
		NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
		[imageData writeToFile:filename atomically:YES];
	}
}


#pragma mark -
#pragma mark NSURLConnectionDelegate

// 开始接收服务器图片数据
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_nContentLength = 0;
	
	if([response isKindOfClass:[NSHTTPURLResponse class]]) {
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		NSDictionary *dicAllHeader = [httpResponse allHeaderFields];
		NSString *strContentLength = [dicAllHeader valueForKey:@"Content-Length"];
        
        // 得到图片数据的长度
		if(strContentLength.length > 0) {
			_nContentLength = [strContentLength intValue];
		}
	}
}


/*
 接收服务器图片数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.mutableData appendData:data];
	if(_nContentLength > 0 ) {
		int nPercent = [self.mutableData length] * 100 / _nContentLength;
		[self postDownloadProgress:nPercent];
		
	}
}

/*
 请求失败，则在60s时间内重试
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSDate *dateNow = [NSDate date];
	NSTimeInterval interval = [dateNow timeIntervalSinceDate:self.startDownloadDate];
	if(interval < 60.0f) {
		[self performSelector:@selector(restartDownload) withObject:nil afterDelay:5.0];
		return;
	}
	
    self.mutableData = nil;
    self.urlConnection = nil;
	[self postDownloadFail];
}


/*
 图片下载完成，直接通知给相应的接收者
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// 是jpg，jpg最后2个字节是0xffd9
	if([strUrl rangeOfString:@"jpg" options:NSCaseInsensitiveSearch].location != NSNotFound) {
		// 图片失败
		if([self.mutableData length] < 2) {
			[self connection:connection didFailWithError:nil];
			return;
		}
		
		NSRange sr;
		sr.location = [self.mutableData length] - 2;
		sr.length = 2;
		
		char buffer[2];
		[self.mutableData getBytes:buffer range:sr];
		NSData *dataff = [NSData dataWithBytes:buffer length:2];
		NSString *typeStr = [dataff description];
		
		//最后2个字节
		if(![typeStr isEqualToString:@"<ffd9>"]) {
			[self connection:connection didFailWithError:nil];
			return;
		}
	}
	
    self.image = [[[UIImage alloc] initWithData:self.mutableData] autorelease];
	
	// 如果服务器返回异常,404,就会执行到这里
	if (image == nil) {
		[self connection:connection didFailWithError:nil];
		return;
	}
	
	[self saveImageToCacheFile:strUrl withImage:self.mutableData];
    
    self.mutableData = nil;
    self.urlConnection = nil;
	[self postDownloadSucc];
}


#pragma mark -
#pragma mark Private


/*
 发送图片下载完成的通知
 */
- (void)postDownloadSucc {
	NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
	[userInfo setObject:[NSString stringWithFormat:@"%d", kImageDownloaderStatusSuccessed] forKey:@"type"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kImageFinishedDownloadNotification
                                                        object:self
                                                      userInfo:userInfo];
}

/*
 发送图片下载失败的通知
 */
- (void)postDownloadFail {
	NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
	[userInfo setObject:[NSString stringWithFormat:@"%d", kImageDownloaderStatusFailed] forKey:@"type"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kImageFinishedDownloadNotification
                                                        object:self
                                                      userInfo:userInfo];
}

/*
 发送图片下载进度的通知
 */
- (void)postDownloadProgress:(int)nPercent {
	NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    [userInfo setObject:[NSString stringWithFormat:@"%d", kImageDownloaderStatusInProgress] forKey:@"type"];
    [userInfo setObject:[NSString stringWithFormat:@"%d", nPercent] forKey:@"percent"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kImageFinishedDownloadNotification
                                                        object:self
                                                      userInfo:userInfo];
}

@end

