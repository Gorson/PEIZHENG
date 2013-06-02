//
//  HttpRequest.h
//  OAuthTest
//
//  Created by yazhou jiang on 12/8/10.
//  Copyright 2010 Wistronits. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 网络请求类
 */

typedef enum{
	HTTPPOST = 1,    // POST请求
	HTTPGET    // GET请求
}HttpMode;    // 请求模式

@protocol HttpRequestDelegate;    // 请求协议

@interface HttpRequest : NSObject {
    
@private
	NSString *_urlString;    // http地址
	NSString *_bodyString;    // body体
    NSURLConnection *_connection;    // 连接对象
	NSMutableData *_mutableData;    // 服务器数据
    
	id<HttpRequestDelegate> _httpRequestDelegate;    // 代理对象
	NSInteger _requestID;    // 请求ID，用来区分各种请求
    
    BOOL _isFinishedLoading;    // 是否加载完成
}

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *bodyString;
@property (nonatomic, assign) id<HttpRequestDelegate> httpRequestDelegate;
@property (nonatomic, assign) NSInteger requestID;

- (id)initWithHttpRequest:(id<HttpRequestDelegate>)delegate
                      URL:(NSString *)url
                     Body:(NSString *)body
                RequestID:(NSInteger)ID;    // 初始化方法
- (void)sendHttpRequest:(HttpMode)httpMode;    // 发送请求
- (void)cancelHttpRequest;    // 取消http请求

@end


/*
 Http请求协议
 */
@protocol HttpRequestDelegate<NSObject>

@optional
- (void)didFinishedLoadData:(NSMutableData *)data Request:(HttpRequest *)httpRequest;    // 数据加载成功
- (void)didFailedLoadData:(NSError *)error Request:(HttpRequest *)httpRequest;    // 数据加载出错

@end

