//
//  CustomActivityIndicatorView.m
//  TicketChina
//
//  Created by Apple on 12-3-14.
//  Copyright (c) 2012年 Wistronits. All rights reserved.
//

#import "CustomActivityIndicatorView.h"

@implementation CustomActivityIndicatorView

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    self = [super init];
    if(self) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView setFrame:CGRectMake(10.0f, 10.0f, 25.0f, 25.0f)];
        
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(36.0f, 12.0f, 20.0f, 20.0f)];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        _loadingLabel.textColor = [UIColor whiteColor];
        _loadingLabel.font = [UIFont systemFontOfSize:15.0f];
//        _loadingLabel.text = @"加载中，请稍候...";
        
        self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = YES;
		self.layer.cornerRadius = 10.0;
    }
    
    return self;
}


- (void)startAnimating {
    [self addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
    [self addSubview:_loadingLabel];
}


- (void)stopAnimating {
    [_activityIndicatorView removeFromSuperview];
    [_loadingLabel removeFromSuperview];
    [_activityIndicatorView stopAnimating];
}


- (void)dealloc {
    [_activityIndicatorView release];
    [_loadingLabel release];
    
    [super dealloc];
}

@end
