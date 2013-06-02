/*
 * This file is part of the SDBWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

@class SDBWebImageManager;

@protocol SDBWebImageManagerDelegate <NSObject>

@optional

- (void)webImageManager:(SDBWebImageManager *)imageManager didFinishWithImage:(UIImage *)image;
- (void)webImageManager:(SDBWebImageManager *)imageManager didFailWithError:(NSError *)error;

@end
