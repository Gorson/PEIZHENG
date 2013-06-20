//
//  PZPCRegisterViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZPCRegisterViewController.h"
#import "PZPCServerViewController.h"
#import "PZPCRegisterDataRequest.h"
#import "userRegist.h"

@interface PZPCRegisterViewController ()
{
    UITextField *_textField;
    UIButton *_goBack;
    UIButton *_Enter;
    UIImageView *_backgoundImage;
    userRegist * user;
    NSArray * itemArray;
}
@end

@implementation PZPCRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithData];
    [self initWithUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 初始化UI
 */
-(void)initWithUI
{
    NSInteger i = 1;
    for (i = 1; i<9; i++) {
        _textField = [[[UITextField alloc] init] autorelease];
        _textField.tag = i;
        _textField.frame = CGRectMake(20, 10 + 40*i, 280, 40);
        _textField.borderStyle = UITextBorderStyleRoundedRect;
//        _textField.placeholder = @"";
        _textField.textAlignment = UITextAlignmentCenter;
        _textField.placeholder = [itemArray objectAtIndex:i-1];
        _textField.delegate = self;
        [self.view addSubview:_textField];

     }
    
    _goBack = [[UIButton alloc] init];
    [_goBack setFrame:CGRectMake(IPHONE_WIDTH/2.0f+45.0f, IPHONE_HEIGHT/2.0f, 90.0f, 44.0f)];
    [_goBack setTitle:@"返回" forState:UIControlStateNormal];
    _goBack.titleLabel.font=[UIFont boldSystemFontOfSize:13.0f];
    [_goBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_goBack setBackgroundImage:[UIImage imageNamed:@"PZBackButton.png"]
                      forState:UIControlStateNormal];
    [_goBack addTarget:self
               action:@selector(_goBack:)
     forControlEvents:UIControlEventTouchUpInside];
    
    _Enter = [[UIButton alloc] init];
    [_Enter setFrame:CGRectMake(IPHONE_WIDTH/2.0f+35.0f, IPHONE_HEIGHT/2.0f+70.0f, 70.0f, 44.0f)];
    [_Enter setTitle:@"确定" forState:UIControlStateNormal];
    _Enter.titleLabel.font=[UIFont boldSystemFontOfSize:13.0f];
    [_Enter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_Enter setBackgroundImage:[UIImage imageNamed:@"PZBackButton.png"]
                      forState:UIControlStateNormal];
    [_Enter addTarget:self
               action:@selector(_Enter:)
     forControlEvents:UIControlEventTouchUpInside];
        
    [self.view addSubview:_backgoundImage];
//    [self.view addSubview:_goBack];
//    [self.view addSubview:_Enter];
}

- (void)initWithData
{
    user = [[userRegist alloc]init];
    itemArray = [[NSArray alloc]initWithObjects:@"用户名",@"密码",@"真实名",@"性别",@"区域",@"宿舍号",@"联系电话",@"联系邮箱", nil];
}

-(void)_Enter:(UIButton *)sender
{
    NSString *textField;
    if (_textField.tag) {
        textField= _textField.text;
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

/*
 * UITextFiled代理方法，当用户输入信息时，需要抬高键盘
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
     PZPCRegisterDataRequest *pcRegisterDataRequest = [[PZPCRegisterDataRequest alloc]init];
    pcRegisterDataRequest.user = user;
    [pcRegisterDataRequest PCRegisterDataRequest];
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
    switch (textField.tag) {
        case 1:
            user.uname = textField.text;
            break;
        case 2:
            user.upwd = textField.text;
            break;
        case 3:
            user.realname = textField.text;
            break;
        case 4:
            user.sex = textField.text;
            break;
        case 5:
            user.area = textField.text;
            break;
        case 6:
            user.roomnumber = textField.text;
            break;
        case 7:
            user.phone = textField.text;
            break;
        case 8:
            user.email = textField.text;
            break;
            
        default:
            break;
    }
}


- (void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    int movementDistance;
    switch (textField.tag) {
        case 1:
            movementDistance = 0; // 根据需要调整上升高度
            break;
        case 2:
            movementDistance = 0; // 根据需要调整上升高度
            break;
        case 3:
            movementDistance = 0; // 根据需要调整上升高度
            break;
        case 4:
            movementDistance = 50; // 根据需要调整上升高度
            break;
        case 5:
            movementDistance = 100; // 根据需要调整上升高度
            break;
        case 6:
            movementDistance = 150; // 根据需要调整上升高度
            break;
        case 7:
            movementDistance = 200; // 根据需要调整上升高度
            break;
        case 8:
            movementDistance = 250; // 根据需要调整上升高度
            break;
            
        default:
            break;
    }
    
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//-(void)_goBack:(UIButton *)sender
//{
//    PZPCServerViewController *_pzPCServerController = [[PZPCServerViewController alloc] init];
//    [self presentModalViewController:_pzPCServerController animated:YES];
//}

@end
