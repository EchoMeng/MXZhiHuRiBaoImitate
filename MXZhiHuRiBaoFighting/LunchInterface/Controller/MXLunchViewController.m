//
//  MXLunchViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLunchViewController.h"
#import <AFHTTPSessionManager.h>
#import "MXMainViewController.h"
#import <UIImageView+WebCache.h>
#import <MMDrawerController.h>

@interface MXLunchViewController ()
@property (nonatomic, strong) UIImageView *lunchImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation MXLunchViewController
- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [[UIView alloc]init];
        contentView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 150);
        contentView.backgroundColor = [UIColor whiteColor];
        _contentView = contentView;
    }
    return _contentView;
}

- (UIImageView *)lunchImageView {
    if (!_lunchImageView) {
        UIImageView *lunchImageView = [[UIImageView alloc]init];
        lunchImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 150);
        lunchImageView.backgroundColor = [UIColor whiteColor];
        _lunchImageView = lunchImageView;
    }
    return _lunchImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        UIImageView *logoImageView = [[UIImageView alloc]init];
        logoImageView.frame = self.view.frame;
        logoImageView.image = [UIImage imageNamed:@"Default"];
        _logoImageView = logoImageView;
    }
    return _logoImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.lunchImageView];
    self.contentView.clipsToBounds = YES;
    [self updateLunchImage];
}

- (void)jumpToMainView {
    MXMainViewController *mainViewController = [[MXMainViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainViewController;
}

- (void)updateLunchImage {
    [self.lunchImageView sd_setImageWithURL:[NSURL URLWithString:@"https://pic3.zhimg.com/v2-5af460972557190bd4306ad66f360d4a.jpg"]];
    [UIView animateWithDuration:3.0 animations:^{
        self.lunchImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [self jumpToMainView];
    }];
}


@end
