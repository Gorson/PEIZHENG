//
//  PZCommunicationTableCell.m
//  TickePZhina
//
//  Created by liu jiada on 11/15/11.
//  Copyright (c) 2011 Wistronits. All rights reserved.
//

#import "PZNewsListTableCell.h"

@implementation PZNewsListTableCell

@synthesize headImageView;
@synthesize titleLabel, contentLabel, pointsLabel;
@synthesize timeLabel;
@synthesize separateLineImageView;
@synthesize inviteBtn;
@synthesize image;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellBackground.png"]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(190.0f, 10.0f, 120.0f, 80.0f)];
        //获取一个随机整数范围在：[0,100)包括0，不包括100
        int x = arc4random() % 20;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb%d.jpg",x+1]];
//        imageView.layer.shouldRasterize = YES;
//        imageView.layer.cornerRadius = 2.0;
        imageView.layer.masksToBounds = YES;
        self.headImageView = imageView;
        [self addSubview:headImageView];
        [imageView release];
        
        AsynHeadImageView * headImage= [[AsynHeadImageView alloc] initWithFrame:CGRectMake(190.0f, 10.0f, 120.0f, 80.0f)];
        self.image = headImage;
        //获取一个随机整数范围在：[0,100)包括0，不包括100
        int xb = arc4random() % 21;
        
        if (self.image == NULL) {
            self.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb%d.jpg",xb]];
        }
        headImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb%d.jpg",xb]];
        
        [headImage setBackgroundColor:[UIColor clearColor]];
        headImage.alpha = 0.0f;
        [self addSubview:headImage];
        [UIView animateWithDuration:0.5 animations:^{
            headImage.alpha = 1.0f;
        }];
        [headImage release];
        
        UIButton *userButton = [self buttonWithFrame:CGRectMake(245, 10, 65, 32)];
        self.inviteBtn = userButton;
        [self addSubview:inviteBtn];
       
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 175.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = BKColor;
        self.titleLabel = label;
        [self addSubview:titleLabel];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 23.0f, 180.0f, 60.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13.0f];
        self.contentLabel = label;
        [self addSubview:contentLabel];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 10.0f, 60.0f, 14.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:12.0f];
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentRight;
        self.pointsLabel = label;
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(55.0f, 75.0f, 130.0f, 20.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:10.0f];
        label.textColor = HEXCOLOR(0x898989);
        label.textAlignment = UITextAlignmentRight;
        self.timeLabel = label;
        [self addSubview:timeLabel];
        [label release];
    }
    return self;
}


- (void)adjusPZellFrame {
    CGSize strSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font 
                                        constrainedToSize:CGSizeMake(180.0f, 1000.0f)
                                            lineBreakMode:UILineBreakModeWordWrap];
    
    if(strSize.height > 50.0f) {
        self.contentLabel.frame = CGRectMake(75.0f, 23.0f, 180.0f, strSize.height);
        self.timeLabel.frame = CGRectMake(180.0f, 5.0f, 130.0f, 20.0f);
        self.separateLineImageView.frame = CGRectMake(10.0f, 10.0f + strSize.height + 20.0f, 300.0f, 11.0f);
    } else {
        self.contentLabel.frame = CGRectMake(75.0f, 23.0f, 180.0f, 40.0f);
        self.timeLabel.frame = CGRectMake(180.0f, 5.0f, 130.0f, 20.0f);
        self.separateLineImageView.frame = CGRectMake(10.0f, 80.0f, 300.0f, 11.0f);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


/*
 * 按钮样式
 */
- (UIButton *)buttonWithFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    UIImage *buttonBackgroundImage = [UIImage imageNamed:@"PZ_ModifydataBtn.png"];
    
    [button setBackgroundImage: buttonBackgroundImage forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)dealloc {
    self.headImageView = nil;
    self.titleLabel = nil;
    self.contentLabel = nil;
    self.pointsLabel = nil;
    self.separateLineImageView = nil;
    
    [super dealloc];
}

@end
