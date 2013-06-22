//
//  PZDflyViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import "PZDflyViewController.h"

@interface PZDflyViewController ()

@end

@implementation PZDflyViewController
@synthesize dflyItemArray = _dflyItemArray;
@synthesize catid = _catid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithData];
    [self initWithControl];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithControl
{
    [_backButton setHidden:YES];
    [_headerImageView setHidden:YES];
}

- (void)initWithData
{

}
@end
