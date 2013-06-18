//
//  PZCommunicationTableCell.h
//  TickePZhina
//
//  Created by liu jiada on 11/15/11.
//  Copyright (c) 2011 Wistronits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface PZNewsListTableCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headImageView; //头像
@property (nonatomic, retain) UILabel *titleLabel;        //名字
@property (nonatomic, retain) UILabel *contentLabel;      //内容
@property (nonatomic, retain) UILabel *pointsLabel;       //
@property (nonatomic, retain) UILabel *timeLabel;         //时间
@property (nonatomic, retain) UIImageView *separateLineImageView;
@property (nonatomic, retain) UIButton * inviteBtn;       //按钮
@property (nonatomic,retain) UIImageView * image;   //异步图片请求

- (void)adjusPZellFrame;

@end
