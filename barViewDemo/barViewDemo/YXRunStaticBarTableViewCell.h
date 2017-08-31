//
//  YXRunStaticBarTableViewCell.h
//  fitness
//
//  Created by yunxiang on 2017/8/30.
//  Copyright © 2017年 YunXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DRCorner.h"
@interface YXRunStaticBarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *BGVIew;

@property (weak, nonatomic) IBOutlet UIView *barView;

- (void)resetFrameWithValue:(CGFloat)value maxValue:(CGFloat)maxValue;

@end
