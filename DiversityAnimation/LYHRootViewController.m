//
//  LYHRootViewController.m
//  DiversityAnimation
//
//  Created by Charles Leo on 14-8-25.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LYHRootViewController.h"
#import "AnimationViewController.h"
@interface LYHRootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSArray * mArrayData;
@property (strong,nonatomic) UITableView * mTableView;
@end

@implementation LYHRootViewController
@synthesize mArrayData;
@synthesize mTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.mTableView = tableView;
    [self.view addSubview:self.mTableView];
    NSArray * array = @[@"基本动画:CABasicAnimation",@"多步动画:CAKeyframeAnimation",@"沿路径的动画:CAKeyframeAnimation",@"时间函数:CAMediaTimingFunction",@"动画组",@"抖动动画"];
    self.mArrayData = array;
    self.title = @"动画例子";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mArrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"IS";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    NSString * title = [self.mArrayData objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    AnimationViewController * animationView = [[AnimationViewController alloc]init];
    animationView.mAnimationType = cell.textLabel.text;
    [self.navigationController pushViewController:animationView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
