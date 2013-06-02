//
//  UIImage+Additions.m
//  DiscountHands
//
//  Created by Asian Jiang on 5/20/11.
//  Copyright 2011 Wistronits. All rights reserved.
//

#import "UIImage+Additions.h"


@implementation UIImage(Additions)

- (UIImage *)constrainImage:(CGSize)size {
    UIGraphicsBeginImageContext(size); 
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];     
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();     
    UIGraphicsEndImageContext();     
	
    return  resultingImage; 
}


- (UIImage *)imageWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name 
                                                     ofType:@"png" 
                                                inDirectory:@"Themes1"];
    
    return [UIImage imageWithContentsOfFile:path];
}


- (UIImage *)scaledCopyOfSize:(CGSize)newSize {
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > newSize.width || height > newSize.height) {
        CGFloat ratio1 = width / newSize.width;
        CGFloat ratio2 = height / newSize.height;
        CGFloat ratio = MIN(ratio1, ratio2);
        bounds.size.width = width / ratio;
        bounds.size.height = height / ratio;
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


- (UIImage *)constrainCopyOfRatio:(CGFloat)ratio {
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    if(width > height) {
        CGFloat factor1 = width / height;
        if(factor1 > ratio) {
            CGFloat originx = (width - height) / 2.0f;
            CGFloat originy = 0.0f;
            CGFloat sizeWidth = height;
            CGFloat sizeheight = height;
            CGRect rect = CGRectMake(originx, originy, sizeWidth, sizeheight);
            CGImageRef subImgRef = CGImageCreateWithImageInRect(imgRef, rect);
            UIImage *resultImage = [UIImage imageWithCGImage:subImgRef scale:self.scale orientation:self.imageOrientation];
            
            return resultImage;
        }
    } else if(width < height) {
        CGFloat factor2 = height / width;
        if(factor2 > ratio) {
            CGFloat originx = 0.0f;
            CGFloat originy = (height - width) / 2.0f;
            CGFloat sizeWidth = width;
            CGFloat sizeheight = width;
            CGRect rect = CGRectMake(originx, originy, sizeWidth, sizeheight);
            CGImageRef subImgRef = CGImageCreateWithImageInRect(imgRef, rect);
            UIImage *resultImage = [UIImage imageWithCGImage:subImgRef scale:self.scale orientation:self.imageOrientation];
            
            return resultImage;
        }
    }
    
    
    return self;
}

@end
