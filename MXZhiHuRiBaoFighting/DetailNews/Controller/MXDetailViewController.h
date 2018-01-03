//
//  MXDetailViewController.h
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MXAlphaChangeDelegate <NSObject>
- (void)alphaDidChange:(CGFloat)alpha;
@end

@interface MXDetailViewController : UIViewController
@property (nonatomic, copy)NSString *ID;
@property(nonatomic,weak) id<MXAlphaChangeDelegate> delegate;
@end
