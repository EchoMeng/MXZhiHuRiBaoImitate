//
//  UIView+MXFrame.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIView+MXFrame.h"

@implementation UIView (MXFrame)

- (void)setMx_frame:(CGRect)mx_frame {
    CGRect frame = mx_frame;
    self.frame = frame;
}

- (CGRect)mx_frame {
    return self.frame;
}

- (void)setMx_x:(CGFloat)mx_x {
    CGRect frame = self.frame;
    frame.origin.x = mx_x;
    self.frame = frame;
}

- (CGFloat)mx_x {
    return self.frame.origin.x;
}

- (void)setMx_y:(CGFloat)mx_y {
    CGRect frame = self.frame;
    frame.origin.y = mx_y;
    self.frame = frame;
}

- (CGFloat)mx_y {
    return self.frame.origin.y;
}

- (void)setMx_width:(CGFloat)mx_width {
    CGRect frame = self.frame;
    frame.size.width = mx_width;
    self.frame = frame;
}

- (CGFloat)mx_width {
    return self.frame.size.width;
}

- (void)setMx_height:(CGFloat)mx_height {
    CGRect frame = self.frame;
    frame.size.height = mx_height;
    self.frame = frame;
}

- (CGFloat)mx_height {
    return self.frame.size.height;
}

- (void)setMx_center:(CGPoint)mx_center {
    CGPoint center = self.center;
    center = mx_center;
    self.center = center;
}

- (CGPoint)mx_center {
    return self.center;
}

- (void)setMx_centerX:(CGFloat)mx_centerX {
    CGPoint center = self.center;
    center.x = mx_centerX;
    self.center = center;
}

- (CGFloat)mx_centerX {
    return self.center.x;
}

- (void)setMx_centerY:(CGFloat)mx_centerY {
    CGPoint center = self.center;
    center.y = mx_centerY;
    self.center = center;
}

-(CGFloat)mx_centerY {
    return self.center.y;
}

+ (instancetype)viewFormNib {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
