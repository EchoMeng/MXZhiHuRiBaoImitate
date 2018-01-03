//
//  MXDifferentThemeViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXDifferentThemeViewController.h"
#import "UIImage+MXColor.h"
#import <AFNetworking.h>
#import "MXThemeSet.h"
#import <MJExtension.h>
#import "MXStroy.h"
#import "MXStoryTableViewCell.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <UIViewController+MMDrawerController.h>
#import "MXThemeCollectionViewController.h"

@interface MXDifferentThemeViewController ()
@property (nonatomic, weak)AFHTTPSessionManager *manager;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation MXDifferentThemeViewController
static NSString * const ID = @"MXStoryTableViewCell";

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *dataArray = [NSMutableArray array];
        _dataArray = dataArray;
    }
    return _dataArray;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavgationBar];   
    [self setUpRefresh];
       [self.tableView registerNib:[UINib nibWithNibName:@"MXStoryTableViewCell" bundle:0] forCellReuseIdentifier:ID];
    [self loadLastestData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
}

- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self loadLastestData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setUpNavgationBar {
    self.navigationItem.title = self.theme.name;
    UIColor *color = [UIColor colorWithRed:35/255.0 green:145/255.0 blue:208/255.0 alpha:1];
    UIImage *backgroundImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

#pragma loadData
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
}

//https://news-at.zhihu.com/api/4/theme/11
- (void)loadLastestData {
    NSString *themeURL = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/theme/%@",self.theme.ID];
    [self.manager GET:themeURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/mac/Desktop/themeArray.plist" atomically:YES];
        MXThemeSet *themeSet = [MXThemeSet mj_objectWithKeyValues:responseObject];
        [self.dataArray addObject:themeSet];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MXThemeSet *themeSet = self.dataArray[section];
    return themeSet.stories.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        MXThemeSet *themeSet = self.dataArray[0];
        UIImageView *headerImageView = [[UIImageView alloc]init];
        [headerImageView sd_setImageWithURL:themeSet.image];
        return headerImageView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 200;
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXThemeSet *themeSet = self.dataArray[indexPath.section];
    MXStroy *story = themeSet.stories[indexPath.row];
    if (story.images == nil) {
        return 80;
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXStoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    MXThemeSet *themeSet = self.dataArray[indexPath.section];
    MXStroy *story = themeSet.stories[indexPath.row];
    cell.story = story;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = kScreenBounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    MXThemeCollectionViewController *collectionViewController = [[MXThemeCollectionViewController alloc]initWithCollectionViewLayout:layout];
    MXStoriesData *storiesData = self.dataArray[indexPath.section];
    collectionViewController.storiesData = storiesData;
    collectionViewController.rowNumber = storiesData.stories.count;
    collectionViewController.currentPage = indexPath.row;
    [self.navigationController pushViewController:collectionViewController animated:YES];
    
//    MXDetailViewController *detailViewController = [[MXDetailViewController alloc]init];
//    MXThemeSet *themeSet = self.dataArray[indexPath.section];
//    MXStroy *story = themeSet.stories[indexPath.row];
//    detailViewController.ID = story.ID;
//    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
