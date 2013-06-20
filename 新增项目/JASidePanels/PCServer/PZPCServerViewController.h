//
//  PZPCServerViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-6-17.
//
//

#import <UIKit/UIKit.h>
@class PZUserFunctionController;

@interface PZPCServerViewController : PZNavigationViewController<UITextFieldDelegate>
{
    PZUserFunctionController * _userFunctionController;
}
@property (nonatomic, retain)PZUserFunctionController * userFunctionController;
@end
