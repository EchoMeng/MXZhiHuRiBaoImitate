//
//  MXLeftHeaderView.m
//  MXZhiHuRiBaoFighting
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLeftHeaderView.h"
#import "UIImage+MXColor.h"


@interface MXLeftHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end
@implementation MXLeftHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *headerImage = [UIImage circleImageWithOriginImage:[UIImage imageNamed:@"Comment_Avatar"]];
    [self.loginButton setImage:[headerImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

- (IBAction)loginBtnClick:(id)sender {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"loginButtonClick" object:nil];
    
}






@end
