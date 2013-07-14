//
//  PZSendMyFormListController.m
//  培正梦飞翔
//
//  Created by Air on 13-7-13.
//
//

#import "PZSendMyFormListController.h"
#import "PZUserFormList.h"
#import "PZUserFormListRequest.h"
#import "PZUserFunctionController.h"

@interface PZSendMyFormListController ()
{
    UITextField *_textField;
    NSArray *itemArray;
    PZUserFormList *user;
    UIImageView *_backgoundImage;
    UIButton *_Enter;
}
@end

@implementation PZSendMyFormListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithUI];
    [self initWithData];
	// Do any additional setup after loading the view.
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
    NSInteger i=1 ;
    for (i=1; i<10; i++) {
        _textField = [[[UITextField alloc] init] autorelease];
        _textField.tag = i;
        _textField.frame = CGRectMake(20, 10 + 40*i, 280, 40);
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textAlignment = UITextAlignmentCenter;
        _textField.placeholder = [itemArray objectAtIndex:i-1];
        _textField.delegate = self;
        [self.view addSubview:_textField];

    }
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

}



- (void)initWithData
{
    user = [[PZUserFormList alloc]init];
    itemArray = [[NSArray alloc]initWithObjects:@"用户编号",@"用户名",@"维修类型",@"故障描述",@"联系电话",@"宿舍号",@"电子邮箱",@"区域", @"预约时间",nil];
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
    PZUserFormListRequest *pzUserFormListRequest = [[PZUserFormListRequest alloc]init];
    pzUserFormListRequest.user = user;
    [pzUserFormListRequest PZUserFormListRequest];
    
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
            user.uid = textField.text;
            break;
        case 2:
            user.uname = textField.text;
            break;
        case 3:
            user.comtype= textField.text;
            break;
        case 4:
            user.faultdesc = textField.text;
            break;
        case 5:
            user.phone = textField.text;
            break;
        case 6:
            user.dorm = textField.text;
            break;
        case 7:
            user.email = textField.text;
            break;
        case 8:
            user.area = textField.text;
            break;
        case 9:
            user.booktime = textField.text;
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
            movementDistance = 0; // 根据需要调整上升高度
            break;
        case 5:
            movementDistance = 40; // 根据需要调整上升高度
            break;
        case 6:
            movementDistance = 80; // 根据需要调整上升高度
            break;
        case 7:
            movementDistance = 120; // 根据需要调整上升高度
            break;
        case 8:
            movementDistance = 160; // 根据需要调整上升高度
            break;
        case 9:
            movementDistance = 200; // 根据需要调整上升高度
            
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

@end
