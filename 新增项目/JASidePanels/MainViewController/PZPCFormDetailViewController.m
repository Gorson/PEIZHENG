//
//  PZPCFormDetailViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-25.
//
//

#import "PZPCFormDetailViewController.h"
#import "PZPCFormInfomation.h"
#import "PZDetailOfFormData.h"
#import "PZFormView.h"

@interface PZPCFormDetailViewController ()
{
    PZFormView *_formView;
}
@end

@implementation PZPCFormDetailViewController
@synthesize oid = _oid;
- (id)init
{
    self = [super init];
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
}

- (void)initWithControl
{
    _headerLabel.text = @"报单详情";
    _formView = [[PZFormView alloc]initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, IPHONE_HEIGHT - 44.0f)];
//    [_formView setBackgroundColor:REDColor];
    [self.view addSubview:_formView];
}

- (void)initWithData
{
    PZPCFormInfomation *pcFormInfomation = [[PZPCFormInfomation alloc]init];
    pcFormInfomation.oid = _oid;
    pcFormInfomation.pcFormDetailViewController = self;
    [pcFormInfomation PCFormInfomation];
}

- (void)refreshViewControl:(PZDetailOfFormData *)detailOfFormData
{
    if (_formView) {
        _formView.userNameAndComputerType.text = [NSString stringWithFormat:@"用户名字：%@   电脑类型：%@",detailOfFormData.uname,detailOfFormData.computertype];
        _formView.userAreaAndDorm.text = [NSString stringWithFormat:@"用户所在区域：%@   用户所在宿舍：%@",detailOfFormData.area,detailOfFormData.dorm];
        _formView.bookTimeAndPhone.text = [NSString stringWithFormat:@"用户预约时间：%@   用户电话号码：%@",detailOfFormData.booktime,detailOfFormData.phone];
        _formView.oidAndFormType.text = [NSString stringWithFormat:@"报单编号：%@   报单类型：%@",detailOfFormData.listid,detailOfFormData.type];
        _formView.formStateAndTime.text = [NSString stringWithFormat:@"报单状态：%@   报单时间：%@",detailOfFormData.state,detailOfFormData.time];
    }
}
@end
