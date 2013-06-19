//
//  PZMainView.m
//  培正梦飞翔
//
//  Created by Air on 13-6-19.
//
//

#import "PZMainView.h"

@implementation PZMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * backgoundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baiduMainview.png"]];
        backgoundImage.frame = frame;
        self.backgoundView = backgoundImage;
        [backgoundImage release];
        [self addSubview:self.backgoundView];
        
        UIButton * itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15.0f, 110.0f, 60.0f, 30.0f)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1000;
        [itemButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [itemButton setTitle:@"今日培正" forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        itemButton.backgroundColor = [UIColor clearColor];
        self.itemOneButton = itemButton;
        [self addSubview: self.itemOneButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(90.0f, 110.0f, 60.0f, 30.0f)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1001;
        [itemButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [itemButton setTitle:@"校园探报" forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        itemButton.backgroundColor = [UIColor clearColor];
        self.itemTwoButton = itemButton;
        [self addSubview: self.itemTwoButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(170.0f, 110.0f, 60.0f, 30.0f)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1002;
        [itemButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [itemButton setTitle:@"学生组织" forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        itemButton.backgroundColor = [UIColor clearColor];
        self.itemThreeButton = itemButton;
        [self addSubview: self.itemThreeButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(247.0f, 110.0f, 60.0f, 30.0f)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1003;
        [itemButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [itemButton setTitle:@"社团风采" forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        itemButton.backgroundColor = [UIColor clearColor];
        self.itemFourButton = itemButton;
        [self addSubview: self.itemFourButton];
        [itemButton release];
    }
    return self;
}

- (void)dealloc {
    self.backgoundView = nil;
    self.itemOneButton = nil;
    self.itemTwoButton = nil;
    self.itemThreeButton = nil;
    self.itemFourButton = nil;
    [super dealloc];
}

@end
