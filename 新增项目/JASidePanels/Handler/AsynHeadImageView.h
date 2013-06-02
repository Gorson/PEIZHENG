//
//  AsynImageView.h
//  TicketChina
//
//  Created by liu jiada on 09-12-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageDownloader.h"

/*
 图片异步加载控件，继承自UIImageView
 */
@interface AsynHeadImageView : UIImageView {
	
}

@property (nonatomic, retain) ImageDownloader *imageDownloader;    // 图片加载对象
@property (nonatomic, copy) NSString *imageUrl;    // 图片链接

- (void)stopDownload;
@end


