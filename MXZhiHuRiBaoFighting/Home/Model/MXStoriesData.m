//
//  MXStoriesData.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStoriesData.h"
#import <MJExtension.h>
#import "MXStroy.h"
#import "MXTopStory.h"

@implementation MXStoriesData
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"stories" : [MXStroy class],
             @"top_stories" :[MXTopStory class]
             };
}
@end
