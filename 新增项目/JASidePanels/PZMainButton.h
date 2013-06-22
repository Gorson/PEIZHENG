//
//  PZMainButton.h
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import <UIKit/UIKit.h>

@interface PZMainButton : UIButton

@property (nonatomic, retain) UILabel *contentLabel;      //内容
@property (nonatomic, retain) UILabel *titleLabel;        //名字
@property (nonatomic, retain) UILabel *timeLabel;         //时间
@property (nonatomic, retain) UIImageView * image;        //异步图片请求
@end
