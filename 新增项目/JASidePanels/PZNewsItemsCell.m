//
//  PZNewsItemsCell.m
//  培正梦飞翔
//
//  Created by Air on 13-6-18.
//
//

#import "PZNewsItemsCell.h"

@implementation PZNewsItemsCell
@synthesize headImageView;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 40.0f, 40.0f)];
        //        imageView.layer.shouldRasterize = YES;
        //        imageView.layer.cornerRadius = 2.0;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb1.jpg"]];
        imageView.layer.masksToBounds = YES;
        self.headImageView = imageView;
        [self addSubview:headImageView];
        [imageView release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55.0f, 10.0f, 100.0f, 40.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:18.0f];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        self.titleLabel = label;
        [self addSubview:titleLabel];
        [label release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    self.headImageView = nil;
    self.titleLabel = nil;
    
    [super dealloc];
}
@end
