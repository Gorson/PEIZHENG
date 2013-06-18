//
//  PZEngineerFunctionController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZEngineerFunctionController.h"
#import "PZPCServerViewController.h"
#import "PZUserInfo.h"

@interface PZEngineerFunctionController ()

@end

@implementation PZEngineerFunctionController

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
    [_headerLabel setText:@"我是管理员"];
    [_backButton setHidden:YES];
    [_confirmButton setHidden:NO];
    [_confirmButton setTitle:@"注销" forState:UIControlStateNormal];
    [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_confirmButton setTintColor:[UIColor whiteColor]];
}

- (void)onConfirm:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [PZUserInfo deleteOneFromStorage:[[PZUserInfo loadDataInDatabase]objectAtIndex:0]];
    }];
}

/*
 添加手势
 */
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    DLog(@"什么都不做");
}
@end
