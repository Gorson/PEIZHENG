//
//  PZPCServerViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZPCServerViewController.h"
#import "PZPCRegisterViewController.h"
#import "PZPCUserLoginRequest.h"

@interface PZPCServerViewController ()
{
    UIButton *_login;
    UIButton *_register;
    UIButton *_retrPwd;
    UITextField *_accounts;
    UITextField *_pwd;
    UITextField *_enterAccountField;
    UITextField *_enterPwdField;
    UIImageView *_backgoundImage;
}

@end

@implementation PZPCServerViewController

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
    [self initWithUI];
}

/*
 * 初始化UI控件
 */
- (void)initWithUI
{
    [_backButton setHidden:YES];
    
    _register = [[UIButton alloc] init];
    [_register setFrame:CGRectMake(IPHONE_WIDTH/2.0f-45.0f, IPHONE_HEIGHT/2.0f, 90.0f, 44.0f)];
    [_register setTitle:@"注册" forState:UIControlStateNormal];
    _register.titleLabel.font=[UIFont boldSystemFontOfSize:13.0f];
    [_register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_register setBackgroundImage:[UIImage imageNamed:@"PZBackButton.png"]
                      forState:UIControlStateNormal];
    [_register addTarget:self
               action:@selector(_register:)
     forControlEvents:UIControlEventTouchUpInside];
    
    _retrPwd = [[UIButton alloc] init];
    [_retrPwd setFrame:CGRectMake(IPHONE_WIDTH/2.0f+45.0f, IPHONE_HEIGHT/2.0f, 90.0f, 44.0f)];
    [_retrPwd setTitle:@"找回密码" forState:UIControlStateNormal];
    _retrPwd.titleLabel.font=[UIFont boldSystemFontOfSize:13.0f];
    [_retrPwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_retrPwd setBackgroundImage:[UIImage imageNamed:@"PZBackButton.png"]
                        forState:UIControlStateNormal];
    [_retrPwd addTarget:self
                 action:@selector(_retrPwd:)
       forControlEvents:UIControlEventTouchUpInside];
    
    _login = [[UIButton alloc] init];
    [_login setFrame:CGRectMake(IPHONE_WIDTH/2.0f+35.0f, IPHONE_HEIGHT/2.0f+70.0f, 70.0f, 44.0f)];
    [_login setTitle:@"登陆" forState:UIControlStateNormal];
    _login.titleLabel.font=[UIFont boldSystemFontOfSize:13.0f];
    [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_login addTarget:self action:@selector(pcUserLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_login setBackgroundImage:[UIImage imageNamed:@"PZBackButton.png"]
                      forState:UIControlStateNormal];
    
    _enterAccountField = [[[UITextField alloc] init]autorelease];
    _enterAccountField.frame = CGRectMake(20, 60, 280, 40);
    _enterAccountField.borderStyle = UITextBorderStyleRoundedRect;
    _enterAccountField.placeholder = @"请输入帐号";
    _enterAccountField.textAlignment = UITextAlignmentCenter;
    _enterAccountField.delegate = self;
//    [_enterAccountField becomeFirstResponder];
    
    
    _enterPwdField = [[[UITextField alloc] init]autorelease];
    _enterPwdField.frame = CGRectMake(20, 120, 280, 40);
    _enterPwdField.borderStyle = UITextBorderStyleRoundedRect;
    _enterPwdField.placeholder = @"请输入密码";
    _enterPwdField.secureTextEntry = YES;
    _enterPwdField.textAlignment = UITextAlignmentCenter;
    _enterPwdField.delegate = self;
    
    [self.view addSubview:_enterAccountField];
    [self.view addSubview:_enterPwdField];
    [self.view addSubview:_register];
    [self.view addSubview:_login];
    [self.view addSubview:_retrPwd];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_enterAccountField resignFirstResponder];
    [_enterPwdField resignFirstResponder];
    return YES;
}

-(void)_register:(UIButton *)sender
{
    PZPCRegisterViewController *_pzPCServerController = [[[PZPCRegisterViewController alloc] init] autorelease];
    [self presentModalViewController:_pzPCServerController animated:YES];
}

- (void)pcUserLogin:(UIButton *)sender
{
    PZPCUserLoginRequest * loginRequest = [[PZPCUserLoginRequest alloc]init];
    loginRequest.username = _enterAccountField.text;
    loginRequest.password = _enterPwdField.text;
    loginRequest.pcServerViewController = self;
    [loginRequest PCUserLoginRequest];
}

@end
