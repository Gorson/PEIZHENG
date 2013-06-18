//
//  CustomActivityIndicatorView.h
//  TicketChina
//
//  Created by Apple on 12-3-14.
//  Copyright (c) 2012年 Wistronits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define LoadingRect CGRectMake(140.0f, 230.0f, 45.0f, 45.0f)

@interface CustomActivityIndicatorView : UIView {
    UIActivityIndicatorView *_activityIndicatorView;
    UILabel *_loadingLabel;
}

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;
- (void)startAnimating;
- (void)stopAnimating;

@end
