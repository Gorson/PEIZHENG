//
//  PZNewsDetailOfDetailCell.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-6.
//
//

#import "PZNewsDetailOfDetailCell.h"
#import "UIImageView+WebCache.h"

@implementation PZNewsDetailOfDetailCell
@synthesize titleLabel, contentLabel, timeLabel;
@synthesize image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 5.0f, 250.0f, 40.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:18.0f];
        label.textAlignment = UITextAlignmentCenter;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.titleLabel = label;
        [self addSubview:titleLabel];
        [label release];
        
        UIImageView * headImage= [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 55.0f, 280.0f, 190.0f)];
        self.image = headImage;
        
        [headImage setBackgroundColor:[UIColor clearColor]];
        headImage.alpha = 0.0f;
        [self addSubview:headImage];
        [UIView animateWithDuration:0.5 animations:^{
            headImage.alpha = 1.0f;
        }];
        [headImage release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 260.0f, 300.0f, 1100.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13.0f];
        self.contentLabel = label;
        [self addSubview:contentLabel];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 35.0f, 130.0f, 20.0f)];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)adjusPZellFrame {
    CGSize strSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font
                                        constrainedToSize:CGSizeMake(300.0f, 1100.0f)
                                            lineBreakMode:UILineBreakModeWordWrap];
    
    if(strSize.height > 50.0f) {
        self.contentLabel.frame = CGRectMake(10.0f, 260.0f, 300.0f, strSize.height);
        self.timeLabel.frame = CGRectMake(80.0f, 35.0f, 130.0f, 20.0f);
    } else {
        self.contentLabel.frame = CGRectMake(10.0f, 260.0f, 300.0f, 40.0f);
        self.timeLabel.frame = CGRectMake(80.0f, 35.0f, 130.0f, 20.0f);
    }
}

- (void)adjustCellFrame {
    CGSize strSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font
                                        constrainedToSize:CGSizeMake(300.0f, 1100.0f)
                                            lineBreakMode:UILineBreakModeWordWrap];
    
    if(strSize.height > 45.0f) {
        self.contentLabel.frame = CGRectMake(10.0f, 350.0f, 300.0f, strSize.height);
        self.timeLabel.frame = CGRectMake(70.0f, 35.0f, 130.0f, 20.0f);
    } else {
        self.contentLabel.frame = CGRectMake(10.0f, 350.0f, 300.0f, 40.0f);
        self.timeLabel.frame = CGRectMake(70.0f, 35.0f, 130.0f, 20.0f);
    }
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
    self.titleLabel = nil;
    self.contentLabel = nil;
    
    [super dealloc];
}
@end
