//
//  MosaivView.m
//  MosaicUI
//
//  Created by Ezequiel Becerra on 11/26/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "MosaicView.h"
#import "MosaicData.h"
#import "MosaicDataView.h"

#import "AOScrollerView.h"



#define kModuleSizeInPoints_iPhone 80
#define kModuleSizeInPoints_iPad 128
#define kMaxScrollPages_iPhone 4
#define kMaxScrollPages_iPad 4
@interface MosaicView()<UIScrollViewDelegate,ValueClickDelegate>
{
//    SRRefreshView   *_slimeView;
    AOScrollerView *aSV;
    NSMutableArray *strArr;
}
@end

@implementation MosaicView
@synthesize datasource, delegate;
@synthesize mainDelegate = _mainDelegate;

#pragma mark - Private

- (void)setup{
    _maxElementsX = -1;
    _maxElementsY = -1;
    
    //  Add scrollview and set its position and size using autolayout constraints
    scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, IPHONE_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"iphone背景图.jpg"];
    [self addSubview:imageView];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    [self setScrollImage:nil];
//    _slimeView = [[SRRefreshView alloc] init];
//    _slimeView.delegate = self;
//    _slimeView.upInset = 44;
//    [scrollView addSubview:_slimeView];
    
    isFirstLayoutTime = YES;
}

- (void)setScrollImage:(NSMutableArray *)imageDetailArr
{
    //设置图片url数组
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"http://www.peizheng.cn/uploadfile/ztzl/uploadfile/201305/20130513125513127.jpg",@"http://www.peizheng.cn/uploadfile/ztzl/uploadfile/201304/20130430121043141.jpg",@"http://www.peizheng.cn/uploadfile/ztzl/uploadfile/201304/20130428010043631.jpg",@"http://www.peizheng.cn/uploadfile/ztzl/uploadfile/201304/20130426124355410.jpg",@"http://www.peizheng.cn/uploadfile/ztzl/uploadfile/201304/20130428021119354.jpg", nil];
    //设置标题数组
    strArr = [[NSMutableArray alloc]initWithObjects:@"入驻大学生创意创新创业园",@"中网动漫公益大赛",@"第四届社团文化节",@"第四届社团文化节",@"第五届宿舍文化节", nil];
    
    // 初始化自定义ScrollView类对象
    aSV = [[AOScrollerView alloc]initWithNameArr:arr titleArr:strArr height:200];
    //设置委托
    aSV.vDelegate=self;
}

- (BOOL)doesModuleWithCGSize:(CGSize)aSize fitsInCoord:(CGPoint)aPoint{
    BOOL retVal = YES;
    
    NSInteger xOffset = 0;
    NSInteger yOffset = 0;
    
    while (retVal && yOffset < aSize.height){
        xOffset = 0;
        
        while (retVal && xOffset < aSize.width){
            NSInteger xIndex = aPoint.x + xOffset;
            NSInteger yIndex = aPoint.y + yOffset;
            
            //  Check if the coords are valid in the bidimensional array
            if (xIndex < [self maxElementsX] && yIndex < [self maxElementsY]){
                
                id anObject = [elements objectAtColumn:xIndex andRow:yIndex];
                if (anObject != nil){
                    retVal = NO;
                }
                
                xOffset++;
            }else{
                retVal = NO;
            }
        }
        
        yOffset++;
    }
    
    return retVal;
}

- (void)setModule:(MosaicData *)aModule withCGSize:(CGSize)aSize withCoord:(CGPoint)aPoint{
    NSInteger xOffset = 0;
    NSInteger yOffset = 0;
    
    while (yOffset < aSize.height){
        xOffset = 0;
        
        while (xOffset < aSize.width){
            NSInteger xIndex = aPoint.x + xOffset;
            NSInteger yIndex = aPoint.y + yOffset;
            
            [elements setObject:aModule atColumn:xIndex andRow:yIndex];
            
            xOffset++;
        }
        
        yOffset++;
    }
}

- (NSArray *)coordArrayForCGSize:(CGSize)aSize{
    NSArray *retVal = nil;
    BOOL hasFound = NO;
    
    NSInteger i=0;
    NSInteger j=0;
    
    while (j < [self maxElementsY] && !hasFound){
        
        i = 0;
        
        while (i < [self maxElementsX] && !hasFound){
            
            BOOL fitsInCoord = [self doesModuleWithCGSize:aSize fitsInCoord:CGPointMake(i, j)];
            if (fitsInCoord){
                hasFound = YES;
                
                NSNumber *xIndex = [NSNumber numberWithInteger:i];
                NSNumber *yIndex = [NSNumber numberWithInteger:j];
                retVal = @[xIndex, yIndex];
            }
            
            i++;
        }
        
        j++;
    }
    
    return retVal;
}

- (CGSize)sizeForModuleSize:(NSUInteger)aSize{
    CGSize retVal = CGSizeZero;
    
    switch (aSize) {
            
        case 0:
            retVal = CGSizeMake(4, 4);
            break;
        case 1:
            retVal = CGSizeMake(2, 2);
            break;
        case 2:
            retVal = CGSizeMake(2, 1);
            break;
        case 3:
            retVal = CGSizeMake(1, 1);
            break;
        case 4:
            retVal = CGSizeMake(4, 2);
            break;
        case 5:
            retVal = CGSizeMake(2, 3);
            break;
            
        default:
            break;
    }
    
    return retVal;
}

- (NSInteger)moduleSizeInPoints{
    NSInteger retVal = kModuleSizeInPoints_iPhone;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        retVal = kModuleSizeInPoints_iPad;
    }
    
    return retVal;
}

- (NSInteger)maxElementsX{
    NSInteger retVal = _maxElementsX;
    
    if (retVal == -1){
        retVal = self.frame.size.width / [self moduleSizeInPoints];
    }
    
    return retVal;
}

- (NSInteger)maxElementsY{
    NSInteger retVal = _maxElementsY;
    
    if (retVal == -1){
        retVal = self.frame.size.height / [self moduleSizeInPoints] * [self maxScrollPages];
    }
    
    return retVal;
}

- (NSInteger)maxScrollPages{
    NSInteger retVal = kMaxScrollPages_iPhone;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        retVal = kMaxScrollPages_iPad;
    }
    return retVal;
}

- (void)setupLayoutWithMosaicElements:(NSArray *)mosaicElements{
    NSInteger yOffset = 0;
    
    _maxElementsX = -1;
    _maxElementsY = -1;
    
    NSInteger scrollHeight = 0;
    
    scrollView.frame = [self bounds];
    
    for (UIView *subView in scrollView.subviews){
        [subView removeFromSuperview];
    }
    
    // Initial setup for the view
    NSUInteger maxElementsX = [self maxElementsX];
    NSUInteger maxElementsY = [self maxElementsY];
    elements = [[TwoDimentionalArray alloc] initWithColumns:maxElementsX andRows:maxElementsY];    
    
    CGPoint modulePoint = CGPointZero;
    
    MosaicDataView *lastModuleView = nil;
    
    //  Set modules in scrollView
    for (MosaicData *aModule in mosaicElements){        
        CGSize aSize = [self sizeForModuleSize:aModule.size];
        NSArray *coordArray = [self coordArrayForCGSize:aSize];
        
        if (coordArray){
            NSInteger xIndex = [coordArray[0] integerValue];
            NSInteger yIndex = [coordArray[1] integerValue];
            
            modulePoint = CGPointMake(xIndex, yIndex);
            
            [self setModule:aModule withCGSize:aSize withCoord:modulePoint];
            
            CGRect mosaicModuleRect = CGRectMake(xIndex * [self moduleSizeInPoints],
                                                 yIndex * [self moduleSizeInPoints] + yOffset,
                                                 aSize.width * [self moduleSizeInPoints],
                                                 aSize.height * [self moduleSizeInPoints]);
                        
            lastModuleView = [[MosaicDataView alloc] initWithFrame:mosaicModuleRect];
            lastModuleView.module = aModule;
            lastModuleView.delegate = self.delegate;
            lastModuleView.mosaicView = self;
            
            if ([aModule.catid isEqualToString:@"1000"])
            {
//                lastModuleView.mosaicView = Nil;
                [lastModuleView.titleLabel setHidden:YES];
                [lastModuleView addSubview:aSV];
                [scrollView addSubview:lastModuleView];
            }else
            {
                [lastModuleView.titleLabel setHidden:NO];
                [scrollView addSubview:lastModuleView];
            }
            
            scrollHeight = MAX(scrollHeight+20.0f, lastModuleView.frame.origin.y + lastModuleView.frame.size.height);
        }
    }
    
    //  Setup content size
    CGSize contentSize = CGSizeMake(scrollView.frame.size.width,scrollHeight);
    scrollView.contentSize = contentSize;    
}

#pragma mark - Public

- (id)init{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews{
    NSArray *mosaicElements = [self.datasource mosaicElements];
    [self setupLayoutWithMosaicElements:mosaicElements];
    [super layoutSubviews];
}

//#pragma mark - scrollView delegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [_slimeView scrollViewDidScroll];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [_slimeView scrollViewDidEndDraging];
//}
//
//#pragma mark - slimeRefresh delegate
//
//- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
//{
//    [_slimeView performSelector:@selector(endRefresh)
//                     withObject:nil afterDelay:3
//                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
//}

#pragma AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
    
    [_mainDelegate clickButtonWithNewsId:[NSString stringWithFormat:@"%d",vid] withTitle:[strArr objectAtIndex:39-vid]];
}
@end
