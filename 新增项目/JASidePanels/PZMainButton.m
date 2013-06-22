//
//  PZMainButton.m
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import "PZMainButton.h"

@implementation PZMainButton
@synthesize titleLabel, contentLabel, timeLabel;
@synthesize image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * headImage= [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 45.0f, 105.0f, 80.0f)];
        self.image = headImage;
        
        [headImage setBackgroundColor:[UIColor clearColor]];
        headImage.alpha = 0.5f;
        [self addSubview:headImage];
        [UIView animateWithDuration:0.5 animations:^{
            headImage.alpha = 1.0f;
        }];
        [headImage release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 0.0f, 250.0f, 40.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:18.0f];
        label.textAlignment = UITextAlignmentCenter;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.titleLabel = label;
        [self addSubview:titleLabel];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(115.0f, 35.0f, 180.0f, 100.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14.0f];
        self.contentLabel = label;
        [self addSubview:contentLabel];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(155.0f, 135.0f, 130.0f, 20.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:11.0f];
        label.textColor = BKColor;
        label.textAlignment = UITextAlignmentRight;
        self.timeLabel = label;
        [self addSubview:timeLabel];
        [label release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
