//
//  MXLoginViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLoginViewController.h"
#import "UIImage+MXColor.h"

@interface MXLoginViewController ()

@end

@implementation MXLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIColor *color = [UIColor colorWithRed:35/255.0 green:145/255.0 blue:208/255.0 alpha:1];
    UIImage *backgroundImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavgationBar];
}

- (void)setUpNavgationBar {
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"登  录";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setImage:[UIImage imageNamed:@"Browser_Icon1_Back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"Browser_Icon1_Back_Highlight"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backNavItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavItem;
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
