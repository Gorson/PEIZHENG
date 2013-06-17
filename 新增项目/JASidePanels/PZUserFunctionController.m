//
//  PZUserFunctionController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZUserFunctionController.h"
#import "PZPCServerViewController.h"
#import "PZUserInfo.h"

@interface PZUserFunctionController ()

@end

@implementation PZUserFunctionController

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
    _headerLabel.text = @"我是管理员";
    _confirmButton.hidden = NO;
    [_confirmButton setTitle:@"注销" forState:UIControlStateNormal];
    [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_confirmButton setTintColor:[UIColor whiteColor]];
}

- (void)onConfirm:(UIButton *)sender
{
    [PZUserInfo deleteOneFromStorage:[[PZUserInfo loadDataInDatabase]objectAtIndex:0]];
    PZPCServerViewController * pcServerViewController = [[PZPCServerViewController alloc]init];
    [self presentModalViewController:pcServerViewController animated:YES];
    [self.view setHidden:YES];
}
@end
