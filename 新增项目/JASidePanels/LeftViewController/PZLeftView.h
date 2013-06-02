//
//  PZLeftView.h
//  培正梦飞翔
//
//  Created by Air on 13-4-3.
//
//

#import <UIKit/UIKit.h>

@interface PZLeftView : UIView
{
    
}
@property (nonatomic, retain)UIImageView * backgoundView;      // 左视图背景
@property (nonatomic, retain)UIButton * itemOneButton;         // 梦飞翔按钮
@property (nonatomic, retain)UIButton * itemTwoButton;         // 培正社区按钮
@property (nonatomic, retain)UIButton * itemThreeButton;       // 培正家园按钮
@property (nonatomic, retain)UIButton * itemFourButton;        // 培正live按钮
@property (nonatomic, retain)UIButton * itemFiveButton;        // PC服务队按钮
@property (nonatomic, retain)UIButton * itemSixButton;         // 培正地图按钮

- (id)initWithFrame:(CGRect)frame target:(UIViewController*)target action:(SEL)act;    // 初始化方法
@end
