//
//  PZMainView.h
//  培正梦飞翔
//
//  Created by Air on 13-6-19.
//
//

#import <UIKit/UIKit.h>

@interface PZMainView : UIView
{
    
}
@property (nonatomic, retain)UIImageView * backgoundView;      // 主界面视图背景
@property (nonatomic, retain)UIButton * itemOneButton;         // 今日培正按钮
@property (nonatomic, retain)UIButton * itemTwoButton;         // 校园探报按钮
@property (nonatomic, retain)UIButton * itemThreeButton;       // 学生组织按钮
@property (nonatomic, retain)UIButton * itemFourButton;        // 社团风采按钮

- (id)initWithFrame:(CGRect)frame;
@end
