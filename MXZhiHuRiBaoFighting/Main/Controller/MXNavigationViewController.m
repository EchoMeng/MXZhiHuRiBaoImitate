//
//  MXNavigationViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXNavigationViewController.h"

@interface MXNavigationViewController ()

@end

@implementation MXNavigationViewController
+ (void)load{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attriDic = [NSMutableDictionary dictionary];
    attriDic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    attriDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:attriDic];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}
@end
