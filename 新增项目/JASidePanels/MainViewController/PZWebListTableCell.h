//
//  PZCommunicationTableCell.h
//  TickePZhina
//
//  Created by liu jiada on 11/15/11.
//  Copyright (c) 2011 Wistronits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface PZWebListTableCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headImageView; //头像
@property (nonatomic, retain) UILabel *titleLabel;        //报单名字
@property (nonatomic, retain) UILabel *contentLabel;      //报单内容
@property (nonatomic, retain) UILabel *stateLabel;        //报单状态
@property (nonatomic, retain) UILabel *timeLabel;         //报单时间
@property (nonatomic, retain) UIImageView *separateLineImageView;
@property (nonatomic, retain) UIButton * acceptBtn;       //接单按钮
@property (nonatomic,retain) UIImageView * image;   //异步图片请求

- (void)adjusPZellFrame;

@end
