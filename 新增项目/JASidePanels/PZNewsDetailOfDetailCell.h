//
//  PZNewsDetailOfDetailCell.h
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import <UIKit/UIKit.h>

@interface PZNewsDetailOfDetailCell : UITableViewCell

@property (nonatomic, retain) UILabel *contentLabel;      //内容
@property (nonatomic, retain) UILabel *titleLabel;        //名字
@property (nonatomic, retain) UILabel *timeLabel;         //时间
@property (nonatomic, retain) UIImageView * image;        //异步图片请求

- (void)adjusPZellFrame;
- (void)adjustCellFrame;
@end
