//
//  MXThemeCollectionViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXThemeCollectionViewController.h"
#import <AFNetworking.h>
#import "MXDetailItem.h"
#import <MJExtension.h>
#import "MXDetailCollectionViewCell.h"
#import "UIImage+MXColor.h"
#import "UIBarButtonItem+MXButton.h"
#import "UIImage+MXColor.h"

@interface MXThemeCollectionViewController () <MXAlphaChangeDelegate>

@end

@implementation MXThemeCollectionViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self.collectionView registerClass:[MXDetailCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentPage inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma setUpNavigationBar
- (void)setUpNavigationBar {
    UIColor *color = [UIColor colorWithRed:35/255.0 green:145/255.0 blue:208/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = YES;
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImage:@"Back_White" highImage:@"Back" text:nil addTarget:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *shareItem = [UIBarButtonItem itemWithImage:@"News_Share" highImage:@"News_Share_Highlight" text:nil addTarget:self action:@selector(share)];
    UIBarButtonItem *collectionItem = [UIBarButtonItem itemWithImage:@"News_Fav" highImage:@"News_Fav_Highlight" text:nil addTarget:self action:@selector(collection)];
    UIBarButtonItem *commentItem = [UIBarButtonItem itemWithImage:@"News_Commented" highImage:@"News_Commented_Highlight" text:nil addTarget:self action:@selector(comment)];
    UIBarButtonItem *upItem = [UIBarButtonItem itemWithImage:@"Comment_Vote" highImage:@"Comment_Voted" text:nil addTarget:self action:@selector(up)];
    self.navigationItem.rightBarButtonItems = @[shareItem, collectionItem, commentItem, upItem];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share {
    
}

- (void)comment {
    
}

- (void)up {
    
}

- (void)collection {
    
}

#pragma collectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MXDetailCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    MXStroy *story = self.storiesData.stories[indexPath.row];
    cell.detailViewController.ID = story.ID;
    cell.detailViewController.delegate = self;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rowNumber;
}

#pragma MXAlphaChangeDelegate
- (void)alphaDidChange:(CGFloat)alpha {
    self.navigationController.navigationBar.alpha = alpha;
}
@end
