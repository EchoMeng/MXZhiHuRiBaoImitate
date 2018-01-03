//
//  MXDetailViewController.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXDetailViewController.h"
#import <AFNetworking.h>
#import "MXDetailItem.h"

#import <MJExtension.h>
#import <UIImageView+WebCache.h>
@class  MXThemeCollectionViewController;
@interface MXDetailViewController () <UIScrollViewDelegate>
@property (nonatomic, strong)MXDetailItem *detailData;
@property (nonatomic, weak)UIImageView *headerImageView;
@property (nonatomic, weak)UILabel *titleLabel;
@property (nonatomic, weak)UIWebView *webView;
@property (nonatomic, assign)CGFloat alpha;
@end

@implementation MXDetailViewController
static CGFloat const headHeight = 188;
- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc]init];
        webView.scrollView.delegate = self;
        webView.frame = kScreenBounds;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scrollView.bounces = NO;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderView];
}

- (void)setID:(NSString *)ID {
    [self loadNewsDataWithID:ID];
}

- (void)setHeaderView {
    CGRect headFrame = CGRectMake(0, 0, kScreenWidth, headHeight);
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:headFrame];
    [self.webView.scrollView addSubview:headerImageView];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = YES;
    self.headerImageView = headerImageView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 0;
    CGFloat margin = 20;
    titleLabel.mx_x = margin;
    titleLabel.mx_y = 130;
    titleLabel.mx_width = kScreenWidth - 2 * margin;
    titleLabel.mx_height = 50;
    [headerImageView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}


#pragma data
- (void)loadNewsDataWithID:(NSString *)ID {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/%@",ID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MXDetailItem *detailData = [MXDetailItem mj_objectWithKeyValues:responseObject];
        detailData.htmlUrl = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",detailData.css[0],detailData.body];
        self.detailData = detailData;
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:detailData.image]];
        self.titleLabel.text = detailData.title;
        [self.webView loadHTMLString:self.detailData.htmlUrl baseURL:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = 1 - (self.webView.scrollView.contentOffset.y + 64) / headHeight;
    if (alpha <= 0) alpha = 0;
    self.alpha = alpha;
    if ([self.delegate respondsToSelector:@selector(alphaDidChange:)]) {
        [self.delegate alphaDidChange:self.alpha];
    }
}

@end
