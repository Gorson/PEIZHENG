//
//  MessView.h
//  AOWaterView
//
//  Created by akria.king on 13-4-10.
//  Copyright (c) 2013年 akria.king. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PZDflyData.h"

@protocol imageDelegate <NSObject>

-(void)click:(PZDflyData *)data;

@end

@interface MessView : UIView
@property(nonatomic,strong)PZDflyData *dataInfo;
@property(nonatomic,strong)id<imageDelegate> idelegate;

-(id)initWithData:(PZDflyData *)data yPoint:(float) y;

-(void)click;
@end
