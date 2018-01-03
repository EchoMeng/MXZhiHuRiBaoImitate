//
//  UIBarButtonItem+MXButton.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MXButton)
+ (UIBarButtonItem *_Nullable)itemWithImage:(NSString *_Nullable)image highImage:(NSString *_Nullable)highImage text:(NSString *_Nullable)text addTarget:(nullable id)target action:(SEL _Nullable )action;
@end
