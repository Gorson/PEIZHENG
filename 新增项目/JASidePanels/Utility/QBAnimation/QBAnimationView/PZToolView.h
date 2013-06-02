//
//  PZToolView.h
//  IpiaoSNS
//
//  Created by liujiada on 13-1-7.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 底部Tool，用来在“想看”、“喜欢”、“评论”、“购买”之间进行切换
 */

@interface PZToolView : UIView <UITextFieldDelegate>
{
    UIImageView * _backImage;
}

@property (nonatomic, retain) UIButton *firstButton;    // 梦飞翔主页按钮
@property (nonatomic, retain) UIButton *secondButton;   // 今日培正按钮
@property (nonatomic, retain) UIButton *thirdButton;    // 社团风采按钮
@property (nonatomic, retain) UIButton *fourButton;     // 更多精彩按钮
@property (nonatomic, retain) UIImageView * backImage;
@end
