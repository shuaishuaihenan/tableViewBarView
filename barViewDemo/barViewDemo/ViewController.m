//
//  ViewController.m
//  barViewDemo
//
//  Created by yunxiang on 2017/8/31.
//  Copyright © 2017年 yunxiang. All rights reserved.
//

#import "ViewController.h"
#import "YXRunStaticBarTableViewCell.h"

#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width

#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HFrame(X,Y,W,H) CGRectMake((X),(Y),(W),(H))
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat CellWidth;
    NSInteger CellNumber;
    NSInteger currentCell;
}
@property (nonatomic,strong) UIView * barChartView;//柱状图
@property (nonatomic,strong) UITableView *scrollTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self.view addSubview:self.barChartView];
    [self createTriangleView];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initData
{
    CellNumber = 7;
    CellWidth = DEVICE_WIDTH;
    currentCell = 0;
}
#pragma mark - View
- (void)createTriangleView
{
    UIView* triangleView = [[UIView alloc]initWithFrame:CGRectMake(0, _barChartView.bottom - 14, 15, 15)];
    triangleView.centerX = self.view.centerX;
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(7.5, 1.4)];
    [path addLineToPoint:CGPointMake(0, 15)];
    [path addLineToPoint:CGPointMake(15, 15)];
    [path closePath];
    
    CAShapeLayer * triangleLayer = [CAShapeLayer layer];
    triangleLayer.fillColor = [UIColor whiteColor].CGColor;
    triangleLayer.path = path.CGPath;
    [triangleView.layer addSublayer:triangleLayer];
    [self.view addSubview:triangleView];
}
- (UIView *)barChartView
{
    if (!_barChartView) {
        _barChartView = [UIView new];
        CGFloat viewH = 230;
        _barChartView.frame = ({
            CGRect frame;
            frame = HFrame(0, 64, DEVICE_WIDTH, viewH);
            frame;
        });
        _barChartView.backgroundColor = [UIColor blackColor];
        UITableView *scrollTableView = [UITableView new];
        scrollTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        scrollTableView.frame = CGRectMake(0, 8, DEVICE_WIDTH, _barChartView.height - 8 - 15);
        scrollTableView.contentInset = UIEdgeInsetsMake(CellWidth/CellNumber * (CellNumber-1)/2, 0, CellWidth/CellNumber * (CellNumber-1)/2, 0);
        scrollTableView.delegate = self;
        scrollTableView.dataSource = self;
        scrollTableView.rowHeight = CellWidth/CellNumber;
        scrollTableView.showsVerticalScrollIndicator = NO;
        scrollTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        scrollTableView.backgroundColor = [UIColor blackColor];
        //        scrollTableView.bounces = NO;
        
        _scrollTableView = scrollTableView;
        [_barChartView addSubview:_scrollTableView];
    }
    return _barChartView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == _scrollTableView) {
        return 1;
    }else{
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _scrollTableView) {
        return 14;
    }else{
        if (section == 0) {
            return 1;
        }else{
            return 2;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    YXRunStaticBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YXRunStaticBarCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YXRunStaticBarTableViewCell" owner:nil options:0]lastObject];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    
    
    if (indexPath.row == currentCell) {
        cell.barView.backgroundColor = [UIColor redColor];
    }else{
        cell.barView.backgroundColor = [UIColor colorWithRed:72 green:72 blue:84 alpha:1];
    }
    
    [cell resetFrameWithValue:arc4random()%1000 maxValue:1000];
    
    return cell;
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CellWidth/CellNumber);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - ScrollViewDelegate

- (CGPoint)nearestContentOffsetForOffset:(CGPoint)offset
{
    CGFloat pageSize = CellWidth/CellNumber;
    NSInteger page = round(offset.y / pageSize);
    CGFloat targetY = pageSize * page;
    return CGPointMake(offset.x,targetY);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint point = [self nearestContentOffsetForOffset:*targetContentOffset];
    targetContentOffset->x = point.x;
    targetContentOffset->y = point.y;
}
//- (BOOL)s
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat temp = offsetY / (CellWidth/CellNumber);
        
        NSInteger tempNum = [self getRoundValueWithFloat:temp roundingMode:NSRoundPlain scale:0];
        NSLog(@"offsetY:%f   temp:%f   tempNum:%ld",offsetY,temp,tempNum);
        
        currentCell = tempNum + (CellNumber-1)/2;
        [self.scrollTableView reloadData];
    }
}
//四舍五入
- (CGFloat)getRoundValueWithFloat:(CGFloat)value roundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale
{
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc]initWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber * outNum = [[[NSDecimalNumber alloc]initWithFloat:value] decimalNumberByRoundingAccordingToBehavior:handler];
    return [outNum floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
