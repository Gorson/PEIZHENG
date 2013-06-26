//
//  PZFormView.m
//  培正梦飞翔
//
//  Created by Air on 13-6-26.
//
//

#import "PZFormView.h"

@implementation PZFormView
@synthesize userNameAndComputerType;
@synthesize userAreaAndDorm;
@synthesize bookTimeAndPhone;
@synthesize oidAndFormType;
@synthesize formStateAndTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.userNameAndComputerType = label;
        [self addSubview:userNameAndComputerType];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 40.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.userAreaAndDorm = label;
        [self addSubview:userAreaAndDorm];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 70.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.bookTimeAndPhone = label;
        [self addSubview:bookTimeAndPhone];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 100.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.oidAndFormType = label;
        [self addSubview:oidAndFormType];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 130.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self.formStateAndTime = label;
        [self addSubview:formStateAndTime];
        [label release];
    }
    return self;
}
@end
