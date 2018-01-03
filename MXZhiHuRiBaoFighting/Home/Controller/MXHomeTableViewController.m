//
//  MXHomeTableViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXHomeTableViewController.h"
#import <AFNetworking.h>
#import "MXHeaderView.h"
#import "UIImage+MXColor.h"
#import "MXStroy.h"
#import "MXTopStory.h"
#import "MXStoriesData.h"
#import <MJExtension.h>
#import "MXStoryTableViewCell.h"
#import <MJRefresh.h>
#import "NSString+MXDate.h"
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
#import "MXThemeCollectionViewController.h"

@interface MXHomeTableViewController ()
@property (nonatomic, weak)AFHTTPSessionManager *manager;
@property (nonatomic, strong)MXHeaderView *headerView;
@property (nonatomic, strong)NSMutableArray *storiesDataArray;
@property (nonatomic, strong)NSString *farthestdate;
@end
static NSString *const cellID = @"MXStoryTableViewCell";
@implementation MXHomeTableViewController
- (NSMutableArray *)storiesDataArray {
    if (!_storiesDataArray) {
        NSMutableArray *storiesDataArray = [NSMutableArray array];
        _storiesDataArray = storiesDataArray;
    }
    return _storiesDataArray;
}

- (MXHeaderView *)headerView {
    if (!_headerView) {
        MXHeaderView *headerView = [[MXHeaderView alloc]init];
        [self.tableView addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIColor *color = [UIColor colorWithRed:35/255.0 green:145/255.0 blue:208/255.0 alpha:0];
    UIImage *backgroundImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self loadLastestData];
    [self setHeaderInsert];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXStoryTableViewCell" bundle:0] forCellReuseIdentifier:cellID];
    [self setUpRefresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
}

- (void)setUpRefresh {
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self loadLastestData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setUpNavigationBar {
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"首  页";
    MMDrawerBarButtonItem *leftBarButtonItem = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)setHeaderInsert {
    CGFloat headHeight = 200 + 44 + 20;
    CGRect headFrame = CGRectMake(0, -headHeight, kScreenWidth, headHeight);
    self.headerView.frame = headFrame;
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
}

#pragma loadData
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
}


- (void)loadLastestData {
    [self.manager GET:@"https://news-at.zhihu.com/api/4/news/latest" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MXStoriesData *storydata = [MXStoriesData mj_objectWithKeyValues:responseObject];
        [self.storiesDataArray removeAllObjects];
        [self.storiesDataArray addObject:storydata];
        self.headerView.topStories = storydata.top_stories;
        self.farthestdate = storydata.date;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadMoreData {
    [self.manager GET:[NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@",self.farthestdate] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MXStoriesData *storydata = [MXStoriesData mj_objectWithKeyValues:responseObject];
        [self.storiesDataArray addObject:storydata];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    NSDate *date = [self.farthestdate stringToDate];
    NSDate *formerDate = [NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:date];
    NSString *formerDateString = [NSString dateToString:formerDate];
    self.farthestdate = formerDateString;
}

#pragma TabelView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storiesDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MXStoriesData *storiesData = self.storiesDataArray[section];
    return storiesData.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXStoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    MXStoriesData *storiesData = self.storiesDataArray[indexPath.section];
    cell.story = storiesData.stories[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:35/255.0 green:145/255.0 blue:208/255.0 alpha:1.0];
    
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.textColor = [UIColor whiteColor];
    MXStoriesData *storiesData = self.storiesDataArray[section];
    NSString *dateString = storiesData.date;
    NSString *date = [NSString stringToDateString:dateString];
    headerLabel.text = date;
    
    [headerLabel sizeToFit];
    headerLabel.mx_centerY = 14;
    headerLabel.mx_centerX = kScreenWidth * 0.5;
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = kScreenBounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    MXThemeCollectionViewController *collectionViewController = [[MXThemeCollectionViewController alloc]initWithCollectionViewLayout:layout];
    MXStoriesData *storiesData = self.storiesDataArray[indexPath.section];
    collectionViewController.storiesData = storiesData;
    collectionViewController.rowNumber = storiesData.stories.count;
    collectionViewController.currentPage = indexPath.row;
    [self.navigationController pushViewController:collectionViewController animated:YES];
}

#pragma scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = (scrollView.contentOffset.y + 264) / 264;
    if (alpha <= 0) alpha = 0;
    UIColor *color = [UIColor colorWithRed:35/255.0 green:145/255.0 blue:208/255.0 alpha:alpha];
    UIImage *backgroundImage = [UIImage imageWithColor:color];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}
@end
