/*
 * This file is part of the SDBWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDBWebImageCompat.h"

@class SDBWebImageDownloader;

@protocol SDBWebImageDownloaderDelegate <NSObject>

@optional

- (void)imageDownloaderDidFinish:(SDBWebImageDownloader *)downloader;
- (void)imageDownloader:(SDBWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image;
- (void)imageDownloader:(SDBWebImageDownloader *)downloader didFailWithError:(NSError *)error;

@end
