//
//  UIView+MXFrame.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MXFrame)

@property CGRect mx_frame;
@property CGFloat mx_x;
@property CGFloat mx_y;
@property CGFloat mx_width;
@property CGFloat mx_height;
@property CGPoint mx_center;
@property CGFloat mx_centerX;
@property CGFloat mx_centerY;
+ (instancetype)viewFormNib;
@end
