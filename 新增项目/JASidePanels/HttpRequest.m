//
//  HttpRequest.m
//  OAuthTest
//
//  Created by yazhou jiang on 12/8/10.
//  Copyright 2010 Wistronits. All rights reserved.
//

#import "HttpRequest.h"


@implementation HttpRequest

@synthesize urlString = _urlString;
@synthesize bodyString = _bodyString;
@synthesize httpRequestDelegate = _httpRequestDelegate;
@synthesize requestID = _requestID;

/*
 初始化方法
 */
- (id)initWithHttpRequest:(id<HttpRequestDelegate>)delegate URL:(NSString *)url Body:(NSString *)body RequestID:(NSInteger)ID {
    self = [super init];
	if(self) {
		_urlString = url;
		_bodyString = body;
        
		_httpRequestDelegate = delegate;
		_requestID = ID;
        
        _isFinishedLoading = NO;
	}
	
	return self;
}


/*
 发送请求
 */
- (void)sendHttpRequest:(HttpMode)httpMode {
    // POST请求
    if(HTTPPOST == httpMode) {
        NSURL *url = [NSURL URLWithString:_urlString];
        NSString *len = [NSString stringWithFormat:@"%d", [_bodyString length]];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        [theRequest addValue:len forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody:[_bodyString dataUsingEncoding:NSUTF8StringEncoding]];
        
        _connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if (_connection) {
            _mutableData = [[NSMutableData data] retain];
        }
        // GET请求
    } else {
        NSURL *url = [NSURL URLWithString:_urlString];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        [theRequest setHTTPMethod:@"GET"];
        _connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if (_connection) {
            _mutableData = [[NSMutableData data] retain];
        }
        else {
            NSLog(@"Connection nil");
        }
    }
}


/*
 取消请求
 */
- (void)cancelHttpRequest {
    if(_connection) {
        [_connection cancel];
        [_connection release];
        _connection = nil;
    }
    
    if(_mutableData) {
        [_mutableData release];
        _mutableData = nil;
    }
    
    _httpRequestDelegate = nil;
    _isFinishedLoading = YES;
}


/*
 http连接回调
 */
#pragma mark -
#pragma mark NSURLConnectionDelegate

/*
 开始接收数据
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_mutableData setLength:0];
}


/*
 正在接收数据
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_mutableData appendData:data];
}


/*
 请求出错
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _isFinishedLoading = YES;
    if([_httpRequestDelegate respondsToSelector:@selector(didFailedLoadData:Request:)]) {
        [_httpRequestDelegate didFailedLoadData:error Request:self];
    }
}


/*
 数据加载完成
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _isFinishedLoading = YES;
    
    // 将服务器获得的数据回调给代理对象
	if([_httpRequestDelegate respondsToSelector:@selector(didFinishedLoadData:Request:)]) {
		[_httpRequestDelegate didFinishedLoadData:_mutableData Request:self];
	}
}


/*
 内存释放
 */
- (void)dealloc {
    if(_connection) {
        [_connection cancel];
        [_connection release];
        _connection = nil;
    }
    
    if(_mutableData) {
        [_mutableData release];
        _mutableData = nil;
    }
    
    _httpRequestDelegate = nil;
    
    [super dealloc];
}

@end
