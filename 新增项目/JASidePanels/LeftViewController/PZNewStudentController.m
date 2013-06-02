//
//  PZNewStudentController.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import "PZNewStudentController.h"
#import "RecipeSegmentControl.h"

@interface PZNewStudentController ()

@end

@implementation PZNewStudentController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initWithUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - init method
- (void)initWithUI
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_pattern_wood.png"]] autorelease]];
    [self.view addSubview:[[[RecipeSegmentControl alloc] init]autorelease]];
}

- (void)backButtonPress
{
    [self dismissModalViewControllerAnimated:YES];
}
@end