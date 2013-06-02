//
//  JARightViewController+sinaMethod.h
//  培正梦飞翔
//
//  Created by Air on 13-3-31.
//
//

#import "JARightViewController.h"
#import "SinaWeiboRequest.h"

@interface JARightViewController (sinaMethod)<SinaWeiboRequestDelegate>

- (SinaWeibo *)sinaweibo;
@end
