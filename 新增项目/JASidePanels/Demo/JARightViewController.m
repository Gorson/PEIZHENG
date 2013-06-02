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


#import "JARightViewController.h"
#import "JARightViewController+sinaMethod.h"

#import "IMTWebView.h"
#import "ChromeProgressBar.h"
#import "SinaWeibo.h"
//#import "JASidePanelController.h"

#import "UIViewController+JASidePanel.h"

@interface JARightViewController ()<IMTWebViewProgressDelegate>

{
    IMTWebView  *webView;
    ChromeProgressBar *chromeBar;
    
//    SystemSoundID                 soundID;
}

@end

@implementation JARightViewController

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
    UIImageView * backgoundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weibo.png"]];
    backgoundImage.frame = CGRectMake(0.0f, 0.0f, 320.0f, IPHONE_HEIGHT);
    [self.view addSubview:backgoundImage];
    
    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, IPHONE_HEIGHT)];
    [loginButton addTarget:self action:@selector(loginPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
//    webView = [[IMTWebView alloc]init];
//    webView.frame = CGRectMake(65, 0, 255, 480);
//    webView.scrollView.bounces = NO;
//    webView.scrollView.showsVerticalScrollIndicator = NO;
//    webView.progressDelegate = self;
//    [self.view addSubview:webView];
//    [self loadRequest];
}

- (void)loginPress:(UIButton *)sender
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logIn];
}

#pragma mark - Shake

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

#pragma mark - 摇一摇


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if (motion == UIEventSubtypeMotionShake )
	{
//        AudioServicesPlaySystemSound (soundID);
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
	}
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
    
    chromeBar = [[ChromeProgressBar alloc] initWithFrame:CGRectMake(0.0f, 50.0f, self.view.bounds.size.width, 4.0f)];
    
    [self.view addSubview:chromeBar];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://fabuduan.com/submit"]]]];
}
@end
