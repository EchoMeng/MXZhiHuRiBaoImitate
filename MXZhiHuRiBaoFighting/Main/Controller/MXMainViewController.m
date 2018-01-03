//
//  MXMainViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXMainViewController.h"
#import "MXHomeTableViewController.h"
#import "MXLeftViewController.h"
#import "MXNavigationViewController.h"

@interface MXMainViewController ()

@end

@implementation MXMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    MXHomeTableViewController *homeViewController = [[MXHomeTableViewController alloc]init];
    MXNavigationViewController *navigationController = [[MXNavigationViewController alloc]initWithRootViewController:homeViewController];
    self.centerViewController = navigationController;
    
    MXLeftViewController *leftViewController = [[MXLeftViewController alloc]init];
    self.leftDrawerViewController = leftViewController;
    self.maximumLeftDrawerWidth = 250;
    self.showsShadow = NO;
    self.shouldStretchDrawer = NO;
}

@end
