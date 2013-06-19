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
#import "PZPCUserLoginRequest.h"
#import "PZNewsListData.h"

@interface PZUserFunctionController ()
{
    NSArray *_dataArray;
    PZUserInfo *_userInfo;
    NSString *_index1;
    NSString *_index2;
    NSString *_index3;
    NSString *_index4;
    UIButton *_myForm;
    UIButton *_willForm;

}
@end

@implementation PZUserFunctionController
@synthesize _userNameAndPassword,_userRealnameAndSex,_userAreaAndRoom,_userPhoneAndEmal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    [_userNameAndPassword release];
    [_userRealnameAndSex release];
    [_userAreaAndRoom release];
    [_userPhoneAndEmal release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithControl];
    _userInfo = [[PZUserInfo loadDataInDatabase] objectAtIndex:0];
    _index1 = [[NSString alloc] initWithFormat:@" %@    %@",_userInfo.uid,_userInfo.uname];
    _userNameAndPassword.text = _index1;
    _index2 = [[NSString alloc] initWithFormat:@" %@    %@",_userInfo.realname,_userInfo.sex];
    _userRealnameAndSex.text = _index2;
    _index3 = [[NSString alloc] initWithFormat:@" %@    %@",_userInfo.area,_userInfo.dorm];
    _userAreaAndRoom.text = _index3;
    _index4 = [[NSString alloc] initWithFormat:@" %@    %@",_userInfo.phone,_userInfo.email];
    _userPhoneAndEmal.text = _index4;
    
}

//初始化UI
- (void)initWithControl
{
    [_headerLabel setText:@"我是用户"];
    [_backButton setHidden:YES];
    [_confirmButton setHidden:NO];
    [_confirmButton setTitle:@"注销" forState:UIControlStateNormal];
    [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_confirmButton setTintColor:[UIColor whiteColor]];
    
    NSInteger i = 0;
    for (i=0; i<4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:18.0f];
        label.textAlignment = UITextAlignmentCenter;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self._userNameAndPassword = label;

    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    label.textAlignment = UITextAlignmentCenter;
    label.lineBreakMode = UILineBreakModeMiddleTruncation;
    label.textColor = [UIColor blackColor];
    self._userNameAndPassword = label;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 30)];
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont boldSystemFontOfSize:18.0f];
    label2.textAlignment = UITextAlignmentCenter;
    label2.lineBreakMode = UILineBreakModeMiddleTruncation;
    label2.textColor = [UIColor blackColor];
    self._userRealnameAndSex = label2;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 30)];
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont boldSystemFontOfSize:18.0f];
    label3.textAlignment = UITextAlignmentCenter;
    label3.lineBreakMode = UILineBreakModeMiddleTruncation;
    label3.textColor = [UIColor blackColor];
    self._userAreaAndRoom = label3;
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 320, 30)];
    label4.backgroundColor = [UIColor clearColor];
    label4.font = [UIFont boldSystemFontOfSize:18.0f];
    label4.textAlignment = UITextAlignmentCenter;
    label4.lineBreakMode = UILineBreakModeMiddleTruncation;
    label4.textColor = [UIColor blackColor];
    self._userPhoneAndEmal = label4;

    [self.view addSubview:_userNameAndPassword];
    [self.view addSubview:_userRealnameAndSex];
    [self.view addSubview:_userAreaAndRoom];
    [self.view addSubview:_userPhoneAndEmal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
