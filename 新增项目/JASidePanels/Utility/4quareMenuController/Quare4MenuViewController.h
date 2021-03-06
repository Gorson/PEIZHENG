//
//  4quareMenuViewController.h
//  4quareMenu
//
//  Created by chen daozhao on 13-3-18.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>

#define RECTPRINTSTR @" Rect(X:%.2f Y:%.2f Width:%.2f height:%.2f) "
#define RECTSTRUCT(rect) rect.origin.x,rect.origin.y,rect.size.width,rect.size.height
#define RECTLOG(rect,info, ...) NSLog(@"%@:%d:" info RECTPRINTSTR,[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__LINE__,##__VA_ARGS__,RECTSTRUCT(rect))

#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0*M_PI)

#define CENTERPOINT_OFFSET_X (0.0f)
#define CENTERPOINT_OFFSET_Y (0.0f)

#define DEFAUTROTATION (-50.0f)

#define BUTTON_IMAGE_OF_CENTER @""

#define BUTTON_IMAGE_OF_TOPLEFT     @""
#define BUTTON_IMAGE_OF_TOPRIGHT    @""
#define BUTTON_IMAGE_OF_BOTTOMLEFT  @""
#define BUTTON_IMAGE_OF_BOTTOMRIGHT @""

#define BUTTON_IMAGE_OF_TOPLEFT_H     @""
#define BUTTON_IMAGE_OF_TOPRIGHT_H    @""
#define BUTTON_IMAGE_OF_BOTTOMLEFT_H  @""
#define BUTTON_IMAGE_OF_BOTTOMRIGHT_H @""

@interface Quare4MenuViewController : UIViewController{

//    CGFloat rotation;
}

@property (nonatomic,strong) UIViewController *topLeftController;
@property (nonatomic,strong) UIViewController *topRightController;
@property (nonatomic,strong) UIViewController *bottomLeftController;
@property (nonatomic,strong) UIViewController *bottomRightController;
@property (nonatomic,strong) UIViewController *currentController;
@property (nonatomic,strong) UIView *layerView;

@property (nonatomic,strong) UIButton *topLeftBtn;
@property (nonatomic,strong) UIButton *topRightBtn;
@property (nonatomic,strong) UIButton *bottomLeftBtn;
@property (nonatomic,strong) UIButton *bottomRightBtn;



- (id)initWithTopLeft:(UIViewController *)tl TopRight:(UIViewController *)tr bottomLeft:(UIViewController *)bl bottomRight:(UIViewController *)br;

@end
