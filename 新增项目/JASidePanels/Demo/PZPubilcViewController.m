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

#import "IMTWebView.h"
#import "ChromeProgressBar.h"

@interface PZComViewController ()<IMTWebViewProgressDelegate>

{
    IMTWebView  *webView;
    ChromeProgressBar *chromeBar;
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

- (void)initWithData
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"wav"];
//    NSURL* sample = [[NSURL alloc]initWithString:@"sample.wav"];
//	AudioServicesCreateSystemSoundID(CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID);
}
- (void)initWithUI
{
    webView = [[IMTWebView alloc]init];
    webView.frame = CGRectMake(0, 0, 320, 480);
//    webView.scrollView.bounces = NO;
//    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.progressDelegate = self;
    [self.view addSubview:webView];
    [self loadRequest];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [button setShowsTouchWhenHighlighted:YES];
    [button setBackgroundImage:[UIImage imageNamed:@"backToMain.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = button;
    [self.view addSubview:self.backBtn];
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
    ;
}

- (void)loadRequest {
    if (chromeBar) {
        UIView* subview = (UIView*)chromeBar;
        [subview removeFromSuperview];
    }
    
//    chromeBar = [[ChromeProgressBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 4.0f)];
//    
//    [self.view addSubview:chromeBar];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://fabuduan.com/pzsd"]]]];
}
@end
