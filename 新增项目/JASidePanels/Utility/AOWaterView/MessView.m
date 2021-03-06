//
//  MessView.m
//  AOWaterView
//
//  Created by akria.king on 13-4-10.
//  Copyright (c) 2013年 akria.king. All rights reserved.
//

#import "MessView.h"
#import "UrlImageButton.h"
#define WIDTH 320/2
@implementation MessView
@synthesize idelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithData:(PZDflyData *)data yPoint:(float) y{
    float imgW=[data.width floatValue];//图片原宽度
    float imgH=[data.height floatValue];//图片原高度
    float sImgW = WIDTH-4;//缩略图宽带
    float sImgH = sImgW*imgH/imgW;//缩略图高度
    self = [super initWithFrame:CGRectMake(0, y, WIDTH, sImgH+4)];
    if (self) {
        UrlImageButton *imageBtn = [[UrlImageButton alloc]initWithFrame:CGRectMake(2,2, sImgW, sImgH)];//初始化url图片按钮控件
        if (data.imgurl!= NULL) {
            if ([data.imgurl hasPrefix:@"http"])
            {
                [imageBtn setImageFromUrl:YES withUrl:data.imgurl];//设置图片

            }
            else if([data.imgurl hasPrefix:@"uploadfile"])
            {
                [imageBtn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.peizheng.cn/%@",data.imgurl]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"Default.png"]] ];//设置图片

            }
            else if([data.imgurl hasPrefix:@"/Article"])
            {
                [imageBtn setImageFromUrl:YES withUrl:[NSString stringWithFormat:@"http://www.peizheng.cn%@",data.imgurl]];//设置图片
            }
            else
            {
                //获取一个随机整数范围在：[0,100)包括0，不包括100
                int x = arc4random() % 20;
                
                [imageBtn setImageFromUrl:YES withUrl:[NSString stringWithFormat:@"tb%d.jpg",x+1]];//设置图片地质

                
            }
        }
        else
        {
            //获取一个随机整数范围在：[0,100)包括0，不包括100
            int x = arc4random() % 20;
            
            [imageBtn setImageFromUrl:YES withUrl:[NSString stringWithFormat:@"tb%d.jpg",x+1]];//设置图片地质
        }
        
     
        [imageBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageBtn];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2, self.frame.size.height-22, WIDTH-4, 20)];
        label.backgroundColor = [UIColor blackColor];
        label.alpha=0.8;
        label.text=data.title;
        label.textColor =[UIColor whiteColor];
        [self addSubview:label];
       
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)click{
    [self.idelegate click:self.dataInfo];
}
@end
