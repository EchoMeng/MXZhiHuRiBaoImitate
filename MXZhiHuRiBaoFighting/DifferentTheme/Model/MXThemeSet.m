//
//  MXThemeSet.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXThemeSet.h"
#import "MXStroy.h"
#import <MJExtension.h>

@implementation MXThemeSet
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"stories" : [MXStroy class]
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"description"
             };
}

@end
