//
//  PZUserFunctionController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import "PZUserFunctionController.h"
#import "PZPCServerViewController.h"
#import "PZAllWebFormViewController.h"
#import "PZPCUserLoginRequest.h"
#import "PZNewsListData.h"
#import "PZSendMyFormListController.h"

@interface PZUserFunctionController ()
{
    NSArray *_dataArray;
    PZUserInfo *_userInfo;
    UIButton * loginButton;
}
@property (nonatomic ,retain) UIButton *myDataDetaButton;
@property (nonatomic ,retain) UIButton *myForm;
@property (nonatomic ,retain) UIButton *formOfOperation;
@property (nonatomic, retain) UILabel *_userNameAndPassword;
@property (nonatomic, retain) UILabel *_userRealnameAndSex;
@property (nonatomic, retain) UILabel *_userAreaAndRoom;
@property (nonatomic, retain) UILabel *_userPhoneAndEmal;
@end

@implementation PZUserFunctionController
@synthesize _userNameAndPassword,_userRealnameAndSex,_userAreaAndRoom,_userPhoneAndEmal;
@synthesize myDataDetaButton,myForm,formOfOperation;

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
    [self initWithData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

//初始化UI
- (void)initWithControl
{
    if ([[PZUserInfo loadDataInDatabase]count])
    {
        [_confirmButton setHidden:NO];
        [_confirmButton setTitle:@"注销" forState:UIControlStateNormal];
        [loginButton removeFromSuperview];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 40.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self._userNameAndPassword = label;
        [self.view addSubview:_userNameAndPassword];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 70.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self._userRealnameAndSex = label;
        [self.view addSubview:_userRealnameAndSex];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 100.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self._userAreaAndRoom = label;
        [self.view addSubview:_userAreaAndRoom];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 130.0f, 320.0f, 30.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textAlignment = UITextAlignmentLeft;
        label.lineBreakMode = UILineBreakModeMiddleTruncation;
        label.textColor = [UIColor blackColor];
        self._userPhoneAndEmal = label;
        [self.view addSubview:_userPhoneAndEmal];
        [label release];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 170.0f, 300.0f, 40.0f)];
        [button setBackgroundColor:[UIColor blueColor]];
        [button addTarget:self action:@selector(changeMyData:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"修改资料" forState:UIControlStateNormal];
        self.myDataDetaButton = button;
        [self.view addSubview:myDataDetaButton];
        [button release];
        
        button = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 220.0f, 300.0f, 40.0f)];
        [button setBackgroundColor:[UIColor greenColor]];
        [button addTarget:self action:@selector(myFormList:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"我的报修单" forState:UIControlStateNormal];
        self.myForm = button;
        [self.view addSubview:myForm];
        [button release];
        
        button = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 270.0f, 300.0f, 40.0f)];
        [button setBackgroundColor:[UIColor redColor]];
        
        /*
         从数据库表中获取一条数据
         */
        PZUserInfo *userInfo = [[PZUserInfo loadDataInDatabase] objectAtIndex:0];
        if ([userInfo.identity isEqualToString:@"0"]) {
            [button addTarget:self action:@selector(mySendFormList:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"发送报修单" forState:UIControlStateNormal];
        }
        else if ([userInfo.identity isEqualToString:@"1"])
        {
            [button addTarget:self action:@selector(acceptFormList:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"网上报修单" forState:UIControlStateNormal];
        }
        else
        {
            DLog(@"其他人员.");
        }
        self.formOfOperation = button;
        [self.view addSubview:formOfOperation];
        [button release];
    }
    else
    {
        [_headerLabel setText:@"赶快登陆吧"];
        [_confirmButton setHidden:YES];
        [_userNameAndPassword removeFromSuperview];
        [_userRealnameAndSex removeFromSuperview];
        [_userAreaAndRoom removeFromSuperview];
        [_userPhoneAndEmal removeFromSuperview];
        [myDataDetaButton removeFromSuperview];
        [myForm removeFromSuperview];
        [formOfOperation removeFromSuperview];

        loginButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 250, 200, 50)];
        loginButton.showsTouchWhenHighlighted = YES;
        loginButton.backgroundColor = BKColor;
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginViewAppear:) forControlEvents:UIControlEventTouchUpInside];
        loginButton.tag = 1001;
        [self.view addSubview:loginButton];
        [loginButton release];
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_backButton setHidden:YES];
}

- (void)initWithData
{
    if ([[PZUserInfo loadDataInDatabase] count] > 0) {
        _userInfo = [[PZUserInfo loadDataInDatabase] objectAtIndex:0];
        if ([_userInfo.identity isEqualToString:@"0"]) {
            [_headerLabel setText:@"我是用户"];
        }
        else
        {
            [_headerLabel setText:@"我是管理员"];
        }
        NSString *index = [NSString stringWithFormat:@"用户号码:%8@    用户姓名:%8@",_userInfo.uid,_userInfo.uname];
        _userNameAndPassword.text = index;
        index = [NSString stringWithFormat:@"真实姓名:%8@    用户性别:%8@",_userInfo.realname,_userInfo.sex];
        _userRealnameAndSex.text = index;
        index = [NSString stringWithFormat:@"所住区域:%8@    所住宿舍:%8@",_userInfo.area,_userInfo.dorm];
        _userAreaAndRoom.text = index;
        index = [NSString stringWithFormat:@"手机号码:%8@    用户邮箱:%8@",_userInfo.phone,_userInfo.email];
        _userPhoneAndEmal.text = index;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onConfirm:(UIButton *)sender
{
    [self deleteObjectInDatabaseAndcompletion:^{
        PZPCServerViewController * pcServerViewController = [[PZPCServerViewController alloc]init];
        UINavigationController *ServerViewNav = [[UINavigationController alloc] initWithRootViewController:pcServerViewController];
        pcServerViewController.userFunctionController = self;
        [self initWithControl];
        [self initWithData];
        [self presentModalViewController:ServerViewNav animated:YES];
    }];
}


- (void) deleteObjectInDatabaseAndcompletion:(void (^)(void))completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([[PZUserInfo loadDataInDatabase]objectAtIndex:0]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [PZUserInfo deleteOneFromStorage:[[PZUserInfo loadDataInDatabase]objectAtIndex:0]];
            });
            dispatch_async(dispatch_get_main_queue(), completion);
        }
        else {
            DLog(@"删除不成功");
        }
    });
}


-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)loginViewAppear:(UIButton *)sender
{
    PZPCServerViewController * pcServerViewController = [[PZPCServerViewController alloc]init];
    UINavigationController *ServerViewNav = [[UINavigationController alloc] initWithRootViewController:pcServerViewController];
    pcServerViewController.userFunctionController = self;
    [self presentModalViewController:ServerViewNav animated:YES];
}

-(void)refleshData
{
    [self initWithControl];
    [self initWithData];
}

#pragma mark -
#pragma mark - userManagerOperation

// 修改资料用户操作，无论管理员或普通用户均可修改
- (void)changeMyData:(UIButton *)sender
{
    DLog(@"修改资料用户操作");
}

// 查询我的单子处理情况详情，管理员或用户均有,但内容不相同
- (void)myFormList:(UIButton *)sender
{
    DLog(@"查询我的单子处理情况详情");
}

// 用户编辑及发送保修单操作
- (void)mySendFormList:(UIButton *)sender
{
    DLog(@"用户编辑及发送保修单操作");
    PZSendMyFormListController *sendMyFormListCotroller = [[PZSendMyFormListController alloc]init];
    [self.navigationController pushViewController:sendMyFormListCotroller animated:YES];
}

// 管理员接单操作
- (void)acceptFormList:(UIButton *)sender
{
    DLog(@"管理员接单操作");
    PZAllWebFormViewController *allWebFormViewController = [[PZAllWebFormViewController alloc]init];
    [self.navigationController pushViewController:allWebFormViewController animated:YES];
}
@end
