//
//  NSString+MXDate.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MXDate)
+ (NSString *)stringToDateString:(NSString *)dateString;
- (NSDate *)stringToDate;
+ (NSString *)dateToString:(NSDate *)date;
@end
