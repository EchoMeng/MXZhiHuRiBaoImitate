//
//  MXHeaderView.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXHeaderView.h"
#import "MXTopStory.h"
#import <UIImageView+WebCache.h>

@interface MXHeaderView() <UIScrollViewDelegate>
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation MXHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        [self addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.numberOfPages = self.topStories.count;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        self.pageControl.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControl.mx_centerX = self.center.x;
    self.pageControl.mx_y = self.bounds.size.height - 10;
}

- (void)setTopStories:(NSArray *)topStories {
    NSInteger count = topStories.count;
    self.pageControl.numberOfPages = count;
    self.scrollView.contentSize = CGSizeMake(self.mx_width * count, 0);
    for (int i = 0; i < count; i++) {
        UIImageView *topStroyImageView = [[UIImageView alloc]init];
        topStroyImageView.backgroundColor = [UIColor whiteColor];
        CGFloat x = self.mx_width * i;
        topStroyImageView.frame = CGRectMake(x, 0, self.mx_width, self.mx_height);
        topStroyImageView.contentMode = UIViewContentModeScaleAspectFill;
        MXTopStory *topStory = topStories[i];
        [topStroyImageView sd_setImageWithURL:topStory.image];
        [self.scrollView addSubview:topStroyImageView];
    }
}

#pragma ScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / kScreenWidth;
    self.pageControl.currentPage = page;
}


@end
