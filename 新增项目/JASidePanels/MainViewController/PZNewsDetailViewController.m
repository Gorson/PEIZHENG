//
//  PZNewsDetailViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-5-5.
//
//

#import "PZNewsDetailViewController.h"
#import "PZNewsListTableViewController.h"
#import "PZNewsDetailOfDetailCell.h"
#import "PZDetailRequest.h"
#import "PZNewsListData.h"
#import "UIImageView+WebCache.h"
#import "JASidePanelController.h"

@interface PZNewsDetailViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
}
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *notificationText;
@end

@implementation PZNewsDetailViewController
@synthesize loadingView = _loadingView;
@synthesize newsDetailData;
@synthesize newsid = _newsid;

- (void)viewDidLoad
{
    [super viewDidLoad];

}

/*
 * 初始化方法
 */
- (id)init
{
    if (self = [super init])
    {
        [self initWithControl];
        [self initWithData];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    PZNewsDetailData *detailData = [PZNewsDetailData loadADataInDatabaseWithNewsId:_newsid];
    if (detailData)
    {
        newsDetailData = detailData;
        [self loadWebView];
    }else
    {
        PZDetailRequest * detailRequest = [[PZDetailRequest alloc]init];
        detailRequest.newsDetailViewController = self;
        [detailRequest DetailRequest:_newsid];
    }
    if ([detailData.mark isEqualToString:@"YES"]) {
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"rubbish.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"PZKeepPage.png"]
                                  forState:UIControlStateNormal];
    }
}

/*
 * 初始化数据类型
 */
- (void)initWithData
{

}


/*
 * 初始化UI控件
 */
- (void)initWithControl
{
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 44, IPHONE_WIDTH, IPHONE_HEIGHT - 64);
//    webView.scrollView.bounces = NO;
//    webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    // remove shadow view when drag web view
    for (UIView *subView in [_webView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    [self.view addSubview:_webView];
//    [_confirmButton setTitle:@"保存书签" forState:UIControlStateNormal];
    
    _loadingView = [[CustomActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingView setFrame:CGRectOffset(LoadingRect, 0.0f, -22.0f)];
    [_loadingView startAnimating];
    [self.view addSubview:_loadingView];
    
}

- (void)loadWebView
{
    [_webView loadHTMLString:newsDetailData.content baseURL:NULL];
    _headerLabel.text = newsDetailData.title;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //修改服务器页面的试图宽度值
    
    NSString *autoSizeStr = [NSString stringWithFormat:@"var script = document.createElement('script');"
                             "script.type = 'text/javascript';"
                             "script.text = \"function ResizeImages() { "
                             "var myimg,oldwidth;"
                             "var maxwidth=%f;" //缩放系数
                             "for(i=0;i <document.images.length;i++){"
                             "myimg = document.images[i];"
                             "if(myimg.width > maxwidth){"
                             "oldwidth = myimg.width;"
                             "myimg.width = maxwidth;"
                             "myimg.height = myimg.height * (maxwidth/oldwidth);"
                             "}"
                             "}"
                             "}\";"
                             "document.getElementsByTagName('head')[0].appendChild(script);",IPHONE_WIDTH-30];
    [webView stringByEvaluatingJavaScriptFromString:autoSizeStr];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    [_loadingView stopAnimating];
    [_loadingView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.notificationText = @"网络连接超时...";
    self.imageName = @"PZ_Wrong.png";
    self.notify.image = [UIImage imageNamed:self.imageName];
    self.notify.text = self.notificationText;
    [self displayNotification];
}

#pragma mark -
#pragma mark UITableViewDataSource

/*
 * 表格视图section的个数，有1个section
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


/*
 * 表格视图每个section的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


/*
 返回
 */
- (void)onBack:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}


//代码

/*
 确认 保存书签
 */
-(void)onConfirm:(UIButton *)sender
{
    newsDetailData = [PZNewsDetailData loadADataInDatabaseWithNewsId:_newsid];
    if ([newsDetailData.mark isEqualToString:@"NO"] || [newsDetailData.mark isEqualToString:@""]) {
        newsDetailData.mark = @"YES";
    }
    else
    {
        newsDetailData.mark = @"NO";
    }
    [PZNewsDetailData updateDataFromDatabase:newsDetailData];

    NSArray * listDataArray = [PZNewsListData loadDataInDatabase];
    for (PZNewsListData * listData in listDataArray) {
        if (listData.newsidNum == [_newsid floatValue]) {
            if ([listData.mark isEqualToString:@"NO"] || listData.mark == NULL) {
                listData.mark = @"YES";
                self.notificationText = @"保存成功";
                self.imageName = @"PZ_True.png";
                self.notify.image = [UIImage imageNamed:self.imageName];
                self.notify.text = self.notificationText;
                [self displayNotification];
                [_confirmButton setBackgroundImage:[UIImage imageNamed:@"rubbish.png"] forState:UIControlStateNormal];
            }
            else
            {
                listData.mark = @"NO";
                self.notificationText = @"删除成功";
                self.imageName = @"PZ_True.png";
                self.notify.image = [UIImage imageNamed:self.imageName];
                self.notify.text = self.notificationText;
                [self displayNotification];
                [_confirmButton setBackgroundImage:[UIImage imageNamed:@"PZKeepPage.png"] forState:UIControlStateNormal];
            }
            [PZNewsListData updateDataFromDatabase:listData];
        }
    }
}

#pragma mark -
#pragma mark BDKNotifyHUD

- (BDKNotifyHUD *)notify {
    if (_notify != nil) return _notify;
    _notify = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:self.imageName] text:self.notificationText];
    _notify.center = CGPointMake(IPHONE_WIDTH/2, IPHONE_HEIGHT/2);
    [self.notify setHidden:YES];
    return _notify;
}


- (void)displayNotification {
    if (self.notify.isAnimating) return;
    
    [_notify makeKeyAndVisible];
    [self.notify presentWithDuration:0.6f speed:0.25f inView:nil completion:^{
        [self.notify removeFromSuperview];
        [self.notify setHidden:YES];
    }];
}
@end
