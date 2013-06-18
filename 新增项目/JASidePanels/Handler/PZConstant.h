//
//  PZConstant.h
//
//  Created by liu jiada on 11/15/11.
//  Copyright (c) 2011 Wistronits. All rights reserved.
//

#ifndef TicketChina_TCConstant_h
#define TicketChina_TCConstant_h
#define CampusAgent          @"45"         // 校园探报
#define PeiZhengToday        @"77"         // 培正今日
#define CommunitysStyle      @"102"        // 社团风采
#define StudentOrganizations @"101"        // 学生组织
#define RedPavilion          @"169"        // 红人馆
#define DFlyVisual           @"51"         // D-Fly 视觉  
#define SurroundingPeiZheng  @"223"        // 培正周边
#define PictureOfAtivitys    @"252"        // 图片墙
#define PCSchool             @"246"        // PC学堂


#define debug         1    // 是否输出服务器返回的信息
#define BKColor       [UIColor colorWithRed:62.0f / 255.0f green:58.0f / 255.0f blue:57.0f / 255.0f alpha:1.0f]    // 字体颜色
#define REDColor       [UIColor colorWithRed:231.0f / 255.0f green:51.0f / 255.0f blue:110.0f / 255.0f alpha:1.0f]    // 价格颜色
#define SeparateColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"separateline.png"]]    // 分隔线颜色
#define SetApp PZAppDelegate *app = (PZAppDelegate *)[[UIApplication sharedApplication] delegate];

//判断设备是否IPHONE5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

//设置颜色
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设置颜色与透明度
#define HEXCOLORAL(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]]

//DEBUG 打印
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#ifndef SAFE_RELEASE
#define SAFE_RELEASE(x) { if (x) [x release]; x = nil; }
#endif

/**将下面注释取消，并定义自己的app key，app secret以及授权跳转地址uri
 此demo即可编译运行**/

#define kAppKey             @"1864636678"
#define kAppSecret          @"acdf0ccac7ca104b8bb234811e2f85b0"
#define kAppRedirectURI     @"http://sns.ipiao.com/Home/Public/oauthCallback/o/sina"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

#endif
