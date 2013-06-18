//
//  PZUserNavigationViewController.h
//  IpiaoSNS
//
//  Created by liujiada on 12-12-28.
//  Copyright (c) 2012年 Ipiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

/*
 为了简化部分控件的初始化，将某些控件剥离出来，写了一个共用的好友类
 */
@interface PZNavigationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>{
    UIImageView *_headerImageView;    // 视图顶部的图片
    UILabel *_headerLabel;            // 标题
    UIButton *_backButton;            // 返回按钮
    UIButton *_confirmButton;         // 确认按钮

}

-(void)onConfirm:(UIButton *)sender;    //需要被子类重载的方法
- (void)onBack:(UIButton *)sender;      //可以被子类重载的方法
@end
