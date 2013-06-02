//
//  PZMainDelegate.h
//  培正梦飞翔
//
//  Created by Air on 13-5-14.
//
//

#import <Foundation/Foundation.h>

@protocol PZMainDelegate <NSObject>

- (void)clickButtonWithNewsId:(NSString *)newsId withTitle:(NSString *)title;
@end
