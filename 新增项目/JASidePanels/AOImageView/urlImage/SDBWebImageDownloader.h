/*
 * This file is part of the SDBWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDBWebImageDownloaderDelegate.h"
#import "SDBWebImageCompat.h"

extern NSString *const SDBWebImageDownloadStartNotification;
extern NSString *const SDBWebImageDownloadStopNotification;

@interface SDBWebImageDownloader : NSObject
{
    @private
    NSURL *url;
    id<SDBWebImageDownloaderDelegate> delegate;
    NSURLConnection *connection;
    NSMutableData *imageData;
    id userInfo;
    BOOL lowPriority;
}

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) id<SDBWebImageDownloaderDelegate> delegate;
@property (nonatomic, strong) NSMutableData *imageData;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, readwrite) BOOL lowPriority;

+ (id)downloaderWithURL:(NSURL *)url delegate:(id<SDBWebImageDownloaderDelegate>)delegate userInfo:(id)userInfo lowPriority:(BOOL)lowPriority;
+ (id)downloaderWithURL:(NSURL *)url delegate:(id<SDBWebImageDownloaderDelegate>)delegate userInfo:(id)userInfo;
+ (id)downloaderWithURL:(NSURL *)url delegate:(id<SDBWebImageDownloaderDelegate>)delegate;
- (void)start;
- (void)cancel;

// This method is now no-op and is deprecated
+ (void)setMaxConcurrentDownloads:(NSUInteger)max __attribute__((deprecated));

@end
