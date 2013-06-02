//
//  PZToolView.m
//  IpiaoSNS
//
//  Created by liujiada on 13-1-7.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//

#import "PZToolView.h"

@implementation PZToolView
@synthesize firstButton, secondButton, thirdButton, fourButton;
@synthesize backImage = _backImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景图
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 46.0f)];
        [_backImage setImage:[UIImage imageNamed:@"bottomDockModel.png"]];
        [self addSubview:_backImage];
        
        //梦飞翔主页按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0.0f, 0.0f, 80.0f, 46.0f)];
        [button setShowsTouchWhenHighlighted:YES];
        [button setTag:1000];
        self.firstButton = button;
        [self addSubview:firstButton];
        
        //今日培正按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(80.0f, 0.0f, 80.0f, 46.0f)];
        [button setShowsTouchWhenHighlighted:YES];
        [button setTag:1001];
        self.secondButton = button;
        [self addSubview:secondButton];
        
        //社团风采按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(160.0f, 0.0f, 80.0f, 46.0f)];
        [button setShowsTouchWhenHighlighted:YES];
        [button setTag:1002];
        self.thirdButton = button;
        [self addSubview:thirdButton];
        
        //更多精彩按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(240.0f, 0.0f, 80.0f, 46.0f)];
        [button setShowsTouchWhenHighlighted:YES];
        [button setTag:1003];
        self.fourButton = button;
        [self addSubview:fourButton];
        
        
        
    }
    return self;
}

- (void)dealloc {
    self.firstButton = nil;
    self.secondButton = nil;
    self.thirdButton = nil;
    self.fourButton = nil;
    
    [super dealloc];
}


@end
