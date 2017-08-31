//
//  UIView+DRCorner.h
//  正确圆角设置方式
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (DRCorner)

- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;

- (void)dr_topCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;

- (void)dr_bottomCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;
/**
 *  @brief             圆角化视图并对圆角部分进行描边
 *
 *  @param radius      圆角的半径
 *  @param bgColor     父视图的背景色
 *  @param borderColor 描边的颜色
 */
- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor;

- (void)removeDRCorner;

- (BOOL)hasDRCornered;

#pragma mark --- 新增加(xib文件创建的view且能获得准确的bounds时使用)

- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor corenrRect:(CGRect)bounds;

- (void)dr_topCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor corenrRect:(CGRect)bounds;

- (void)dr_bottomCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor corenrRect:(CGRect)bounds;

- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor corenrRect:(CGRect)bounds;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
//宽
- (CGFloat)width;

//高
- (CGFloat)height;

//上
- (CGFloat)top;

//下
- (CGFloat)bottom;

//左
- (CGFloat)left;

//右
- (CGFloat)right;

//设置宽
- (void)setWidth:(CGFloat)width;

//设置高
- (void)setHeight:(CGFloat)height;

//设置x
- (void)setLeft:(CGFloat)left;

//设置y
- (void)setTop:(CGFloat)top;

//设置Origin
- (void)setOrigin:(CGPoint)origin;

//设置size
- (void)setSize:(CGSize)size;

@end
