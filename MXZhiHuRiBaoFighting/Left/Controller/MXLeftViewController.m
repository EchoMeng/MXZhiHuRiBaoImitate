//
//  MXLeftViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLeftViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "MXLeftHeaderView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "MXTheme.h"
#import "MXLoginViewController.h"
#import "MXDifferentThemeViewController.h"
#import "MXMainViewController.h"
#import "MXNavigationViewController.h"

@interface MXLeftViewController ()
@property (nonatomic, copy)NSArray *titleArray;
@end

@implementation MXLeftViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self loadThemeData];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pushToLoginViewController) name:@"loginButtonClick" object:nil];
}

- (void)pushToLoginViewController {
    MXLoginViewController *loginViewController = [[MXLoginViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma data
- (void)loadThemeData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://news-at.zhihu.com/api/4/themes" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"others"];
        self.titleArray  = [MXTheme mj_objectArrayWithKeyValuesArray:array];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const ID = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首页";
        cell.imageView.image = [UIImage imageNamed:@"Dark_Menu_Icon_Home"];
    } else {
        MXTheme *theme = self.titleArray[indexPath.row - 1];
        cell.textLabel.text = theme.name;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MXLeftHeaderView *leftHeaderView = [MXLeftHeaderView viewFormNib];
    leftHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 130);
    return leftHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MXMainViewController *mainViewController = [[MXMainViewController alloc]init];
        [self.mm_drawerController setCenterViewController:mainViewController withCloseAnimation:YES completion:nil];
    } else {
        MXTheme *theme = self.titleArray[indexPath.row - 1];
        MXDifferentThemeViewController *themeViewController = [[MXDifferentThemeViewController alloc]init];
        themeViewController.theme = theme;
        MXNavigationViewController *navigationController = [[MXNavigationViewController alloc]initWithRootViewController:themeViewController];
        [self.mm_drawerController setCenterViewController:navigationController withCloseAnimation:YES completion:nil];
    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
