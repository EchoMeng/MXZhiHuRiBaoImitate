//
//  UIImage+MXColor.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIImage+MXColor.h"

@implementation UIImage (MXColor)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)circleImageWithOriginImage:(UIImage *)originImage; {
    CGRect rect = CGRectMake(0, 0, originImage.size.width, originImage.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(contextRef, rect);//Ellipse椭圆
    CGContextClip(contextRef);
    [originImage drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
