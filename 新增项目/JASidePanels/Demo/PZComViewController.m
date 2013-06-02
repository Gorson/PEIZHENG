/*
 Copyright (c) 2012 Jesse Andersen. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */


#import "PZComViewController.h"

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "JARightViewController.h"
#import "PZMainViewController.h"
#import "ASIDownloadCache.h"

#import "IMTWebView.h"
#import "ChromeProgressBar.h"

@interface PZComViewController ()<IMTWebViewProgressDelegate,UIWebViewDelegate>

{
    IMTWebView  *webView;
    ChromeProgressBar *chromeBar;
    CustomActivityIndicatorView *_loadingView;
}

@end

@implementation PZComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self initWithData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self webView:webView didReceiveResourceNumber:0 totalResources:0];
}

- (void)initWithData
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"wav"];
//    NSURL* sample = [[NSURL alloc]initWithString:@"sample.wav"];
//	AudioServicesCreateSystemSoundID(CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID);
}

//-(void)loadURL:(NSURL*)url
//{
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    //ASIWebPageRequest *request= [ASIWebPageRequest requestWithURL:url];
//    [request setDelegate:self];
//    //[request setUrlReplacementMode:ASIReplaceExternalResourcesWithData];
//    [request setDidFailSelector:@selector(webPageFetchFailed:)];
//    [request setDidFinishSelector:@selector(webPageFetchSucceeded:)];
//    //设置缓存
//    [request setDownloadCache:[ASIDownloadCache sharedCache]];
//    //[request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
//    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
//    [request setDownloadDestinationPath:[[ASIDownloadCache sharedCache]pathToStoreCachedResponseDataForRequest:request]];
//    [request startAsynchronous];
//}
//
//
//- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
//{
//    // Obviously you should handle the error properly...
//    NSLog(@"%@",[theRequest error]);
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"error1.html" ofType:nil inDirectory:@"WebResources/Error"];
//    NSURL  *url=[NSURL fileURLWithPath:path];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//}
//
//- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
//{
//    NSString *response = [NSString stringWithContentsOfFile:
//                          [theRequest downloadDestinationPath] encoding:[theRequest responseEncoding] error:nil];
//    // Note we're setting the baseURL to the url of the page we downloaded. This is important!
//    [webView loadHTMLString:response baseURL:[theRequest url]];
//    //[viewer loadHTMLString:response baseURL:nil];
//}

- (void)initWithUI
{
    webView = [[IMTWebView alloc]init];
    webView.frame = CGRectMake(0, 0, 320, 480);
//    webView.scrollView.bounces = NO;
//    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.progressDelegate = self;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [button setShowsTouchWhenHighlighted:YES];
    [button setBackgroundImage:[UIImage imageNamed:@"backToMain.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = button;
    [self.view addSubview:self.backBtn];
    
    _loadingView = [[CustomActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingView setFrame:LoadingRect];
    [webView sizeToFit];
    webView.contentMode = UIViewContentModeBottomLeft;
    [self loadRequest];
}

- (void)backButtonPress
{
//    UIStoryboard *stryBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.sidePanelController showLeftPanelAnimated:YES];
}

#pragma mark
#pragma mark - webViewDelegate
- (void)webView:(IMTWebView *)_webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources {
    //Set progress value
    [chromeBar setProgress:((float)resourceNumber) / ((float)totalResources) animated:NO];
    
    //Reset resource count after finished
    if (resourceNumber == totalResources) {
        _webView.resourceCount = 0;
        _webView.resourceCompletedCount = 0;
        }
}

- (void)loadRequest {
    if (chromeBar) {
        UIView* subview = (UIView*)chromeBar;
        [subview removeFromSuperview];
    }
    
    chromeBar = [[ChromeProgressBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 4.0f)];
    
    [self.view addSubview:chromeBar];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://bbs.peizheng.cn"]]]];
    
    [_loadingView startAnimating];
    [self.view setUserInteractionEnabled:NO];
    [self.view addSubview:_loadingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_loadingView stopAnimating];
    [_loadingView removeFromSuperview];
    [self.view setUserInteractionEnabled:YES];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    DLog(@"error is %@",error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    [_loadingView stopAnimating];
    [_loadingView removeFromSuperview];
    [self.view setUserInteractionEnabled:YES];
}
@end
