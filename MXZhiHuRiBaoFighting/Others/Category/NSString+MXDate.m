//
//  NSString+MXDate.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NSString+MXDate.h"

@implementation NSString (MXDate)
+ (NSString *)stringToDateString:(NSString *)dateString {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:[NSString stringWithFormat:@"yyyyMMdd"]];
    NSDate *date = [inputFormatter dateFromString:dateString];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    return [outputFormatter stringFromDate:date];
}

- (NSDate *)stringToDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:[NSString stringWithFormat:@"yyyyMMdd"]];
    NSDate *date = [formatter dateFromString:self];
    return date;
}

+ (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [formatter stringFromDate:date];
}
@end
