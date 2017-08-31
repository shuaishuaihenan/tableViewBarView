//
//  YXRunStaticBarTableViewCell.m
//  fitness
//
//  Created by yunxiang on 2017/8/30.
//  Copyright © 2017年 YunXiang. All rights reserved.
//

#import "YXRunStaticBarTableViewCell.h"

@interface YXRunStaticBarTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation YXRunStaticBarTableViewCell

- (void)resetFrameWithValue:(CGFloat)value maxValue:(CGFloat)maxValue
{
    self.timeLabel.text = @"12/12";
    CGRect frame;
    frame.origin.x = self.BGVIew.left;
    frame.origin.y = self.BGVIew.top;
    CGFloat temp;
    if (value != 0) {
        temp = (CGFloat)( maxValue- value )/maxValue;
    }else{
        temp = 1;
    }
    frame.size.height = self.barView.height*temp;
    frame.size.width = self.BGVIew.width;
    
    self.BGVIew.frame = frame;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
