//
//  ViewController.h
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/21/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosaicView.h"
#import "MosaicViewDelegateProtocol.h"

@interface PZMainViewController : UIViewController <MosaicViewDelegateProtocol>{
    __weak IBOutlet MosaicView *mosaicView;
    UIImageView *snapshotBeforeRotation;
    UIImageView *snapshotAfterRotation;
    NSMutableArray * _newsItemArray;                                            // 资讯新闻数组
}
@property (nonatomic,copy) NSMutableArray * newsItemArray;                      // 资讯新闻数组

@end
