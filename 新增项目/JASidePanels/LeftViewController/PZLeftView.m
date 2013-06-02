//
//  PZLeftView.m
//  培正梦飞翔
//
//  Created by Air on 13-4-3.
//
//

#import "PZLeftView.h"

@implementation PZLeftView

- (id)initWithFrame:(CGRect)frame target:(UIViewController*)target action:(SEL)act
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * backgoundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftModel.png"]];
        backgoundImage.frame = frame;
        self.backgoundView = backgoundImage;
        [backgoundImage release];
        [self addSubview:self.backgoundView];
        
        UIButton * itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, 50, 50)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1000;
        self.itemOneButton = itemButton;
        [self addSubview: self.itemOneButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 88, 50, 50)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1001;
        self.itemTwoButton = itemButton;
        [self addSubview: self.itemTwoButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 165, 50, 50)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1002;
        self.itemThreeButton = itemButton;
        [self addSubview: self.itemThreeButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 240, 50, 50)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1003;
        self.itemFourButton = itemButton;
        [self addSubview: self.itemFourButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 315, 50, 50)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1004;
        self.itemFiveButton = itemButton;
        [self addSubview: self.itemFiveButton];
        [itemButton release];
        
        itemButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 395, 50, 50)];
        itemButton.showsTouchWhenHighlighted = YES;
        itemButton.tag = 1005;
        self.itemSixButton = itemButton;
        [self addSubview: self.itemSixButton];
        [itemButton release];
        
        
    }
    return self;
}

- (void)dealloc {
    self.backgoundView = nil;
    [super dealloc];
}

@end
