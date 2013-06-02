//
//  QBArrowRefreshControl.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/11/22.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "QBArrowRefreshControl.h"

@interface QBArrowRefreshControl ()

@property (nonatomic, retain) UIImageView *arrowImageView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *timeLabel;

@property (nonatomic, readonly) NSString *lastUpdateFormattedString;

@end

@implementation QBArrowRefreshControl

- (id)init
{
    self = [super init];
    
    if(self) {
        self.frame = CGRectMake(0, 0, 320, 60);
        self.threshold = -60;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.lastUpdate = nil;
        
        // 矢印画像
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 50, 50)];
        arrowImageView.image = [UIImage imageNamed:@"arrow.png"];
        
        [self addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
        [arrowImageView release];
        
        // インジケータ
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicatorView.frame = CGRectMake(35, 20, 20, 20);
        
        [self addSubview:activityIndicatorView];
        self.activityIndicatorView = activityIndicatorView;
        [activityIndicatorView release];
        
        // タイトルラベル
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 7, 193, 21)];
        titleLabel.text = @"下拉更新..";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel release];
        
        // 更新時間
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 193, 21)];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"lastUpdateTime"] != NULL) {
            timeLabel.text = [NSString stringWithFormat:@"最后更新时间: %@",[userDefaults objectForKey:@"lastUpdateTime"]];
        }
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        timeLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        [timeLabel release];
    }
    
    return self;
}

- (void)dealloc
{
    [_arrowImageView release];
    [_activityIndicatorView release];
    [_titleLabel release];
    [_timeLabel release];
    
    [_lastUpdate release];
    
    [super dealloc];
}

- (void)setState:(QBRefreshControlState)state
{
    [super setState:state];
    
    switch(state) {
        case QBRefreshControlStateHidden:
        {
            self.activityIndicatorView.hidden = YES;
            [self.activityIndicatorView stopAnimating];
            
            self.arrowImageView.hidden = NO;
        }
            break;
        case QBRefreshControlStatePullingDown:
        {
            self.titleLabel.text = @"下拉更新..";
            
            // 矢印を回転させる
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        case QBRefreshControlStateOveredThreshold:
        {
            self.titleLabel.text = @"释放刷新..";
            
            // 矢印を回転させる
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case QBRefreshControlStateStopping:
        {
            self.activityIndicatorView.hidden = NO;
            [self.activityIndicatorView startAnimating];
            
            self.titleLabel.text = @"加载中..";
            
            self.arrowImageView.hidden = YES;
        }
            break;
    }
}

- (void)endRefreshing
{
    [super endRefreshing];
    
    self.lastUpdate = [NSDate date];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.lastUpdateFormattedString forKey:@"lastUpdateTime"];
    self.timeLabel.text = [NSString stringWithFormat:@"最后更新时间: %@", self.lastUpdateFormattedString];
    
    // 矢印を回転させる
    self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
}


#pragma mark - Additions

- (NSString *)lastUpdateFormattedString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *formattedString = [dateFormatter stringFromDate:self.lastUpdate];
    
    [dateFormatter release];
    
    return formattedString;
}

@end
