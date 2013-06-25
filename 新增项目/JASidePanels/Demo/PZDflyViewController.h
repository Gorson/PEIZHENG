//
//  PZDflyViewController.h
//  培正梦飞翔
//
//  Created by Air on 13-6-22.
//
//

#import "PZNavigationViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "AOWaterView.h"

@interface PZDflyViewController : PZNavigationViewController<EGORefreshTableDelegate,UIScrollViewDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;

    NSMutableArray *_dflyItemArray;
    NSString *_catid;
    CustomActivityIndicatorView * _loadingView;     // 中部的菊花
}
@property (nonatomic, retain) NSMutableArray *dflyItemArray;
@property (nonatomic, copy) NSString *catid;
@property(nonatomic,strong)AOWaterView *aoView;
@property (nonatomic, retain) CustomActivityIndicatorView * loadingView;
@property (nonatomic, retain) EGORefreshTableFooterView *refreshFooterView;


-(void)testFinishedLoadData;
-(void)testEndLoadData;
@end
