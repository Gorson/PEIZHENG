//
//  PZUserNavigationViewController.m
//  IpiaoSNS
//
//  Created by liujiada on 12-12-28.
//  Copyright (c) 2012年 Ipiao. All rights reserved.
//

#import "PZNavigationViewController.h"

@interface PZNavigationViewController ()

@end

@implementation PZNavigationViewController

/*
 视图加载方法，控件初始化
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 44.0f)];
    [_headerImageView setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0]];
    _headerImageView.userInteractionEnabled = YES;
    [self.view addSubview:_headerImageView];
    
    _backButton = [[UIButton alloc] init];
    [_backButton setFrame:CGRectMake(0.0f, 0.0f, 70.0f, 44.0f)];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font=[UIFont boldSystemFontOfSize:13.0f];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"PZBackButton.png"]
                           forState:UIControlStateNormal];
    [_backButton addTarget:self
                    action:@selector(onBack:)
          forControlEvents:UIControlEventTouchUpInside];
    
    _confirmButton = [[UIButton alloc] init];
    [_confirmButton setFrame:CGRectMake(IPHONE_WIDTH-70.0f, 0.0f, 70.0f, 44.0f)];
//    _confirmButton.titleLabel.font=[UIFont boldSystemFontOfSize:14.0f];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton addTarget:self
                       action:@selector(onConfirm:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [_headerImageView addSubview:_confirmButton];
    [_headerImageView addSubview:_backButton];
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(72.0f, 12.0f, IPHONE_WIDTH-140.0f, 20.0f)];
    _headerLabel.backgroundColor = [UIColor clearColor];
    [_headerLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    _headerLabel.textColor = [UIColor whiteColor];
    _headerLabel.textAlignment = UITextAlignmentCenter;
    _headerLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
    [_headerImageView addSubview:_headerLabel];
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
}

#pragma mark -
#pragma mark UISwipeGestureRecognizer
/*
 添加手势时间
 */
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        DLog(@"swipe right");
        //执行程序
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissModalViewControllerAnimated:YES];
    }
    
}
-(void)onConfirm:(UIButton *)sender{
    
}


/*
 返回
 */
- (void)onBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 内存释放
 */
- (void)dealloc {
    [_headerImageView release];
    [_headerLabel release];
    
    [super dealloc];
}


@end
