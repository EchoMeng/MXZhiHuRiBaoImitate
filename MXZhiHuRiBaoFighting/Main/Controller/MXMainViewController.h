//
//  MXMainViewController.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>

@interface MXMainViewController : MMDrawerController
@property (nonatomic, assign, getter=isNeedSwipShowMenu)BOOL needSwipShowMenu;
@end
