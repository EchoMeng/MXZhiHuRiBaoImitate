//
//  MXThemeCollectionViewController.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXStroy.h"
#import "MXStoriesData.h"


@interface MXThemeCollectionViewController : UICollectionViewController
@property (nonatomic, strong)MXStoriesData *storiesData;
@property (nonatomic, assign)NSInteger rowNumber;
@property (nonatomic, assign)NSInteger currentPage;

@end
