//
//  MXStoryTableViewCell.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStoryTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface MXStoryTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;

@end

@implementation MXStoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setStory:(MXStroy *)story {
    [self.storyImageView sd_setImageWithURL:story.images[0]];
    self.newsTitleLabel.text = story.title;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5;
    frame.origin.y += 5;
    frame.size.width -= 10;
    frame.size.height -= 5;
    [super setFrame:frame];
}

@end
