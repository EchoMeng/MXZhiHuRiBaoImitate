//
//  MXDetailCollectionViewCell.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXDetailCollectionViewCell.h"

@implementation MXDetailCollectionViewCell
- (MXDetailViewController *)detailViewController {
    if (!_detailViewController) {
        MXDetailViewController *detailViewController = [[MXDetailViewController alloc]init];
        _detailViewController = detailViewController;
    }
    return _detailViewController;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self.contentView addSubview:self.detailViewController.view];
    }
    return self;
}
@end
