//
//  MXDetailItem.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXDetailItem : NSObject
@property (nonatomic, copy)NSString *body;
@property (nonatomic, copy)NSString *image_source;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *share_url;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSArray *css;

@property (nonatomic, copy)NSString *htmlUrl;
@end
