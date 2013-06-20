//
//  PZMainViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-6-19.
//
//

#import "PZNavigationViewController.h"

@interface PZMainViewController : PZNavigationViewController
{
    NSMutableArray *_comboBoxDatasource;
}
@property (nonatomic,retain)NSMutableArray *comboBoxDatasource;
@property (nonatomic,copy)NSString *catId;
- (void)comboBoxAppear;
- (void)sendRequest:(NSString *)catid;
- (void)newsTopOfView;
@end
