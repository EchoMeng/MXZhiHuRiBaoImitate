//
//  UIBarButtonItem+MXButton.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIBarButtonItem+MXButton.h"

@implementation UIBarButtonItem (MXButton)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage text:(NSString *)text addTarget:(nullable id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:(UIView *)button];
}
@end
