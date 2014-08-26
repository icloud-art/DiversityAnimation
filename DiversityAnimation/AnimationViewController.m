//
//  AnimationViewController.m
//  DiversityAnimation
//
//  Created by Charles Leo on 14-8-25.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController
@synthesize mAnimationType;
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
	self.view.backgroundColor = [UIColor blackColor];
    if ([self.mAnimationType isEqualToString:@"基本动画:CABasicAnimation"]) {
        [self initBasicAnimation];
    }
    else if([self.mAnimationType isEqualToString:@"多步动画:CAKeyframeAnimation"])
    {
        [self initDuoBuAnimation];
    }
    else if([self.mAnimationType isEqualToString:@"沿路径的动画:CAKeyframeAnimation"])
    {
        [self initRouteAnimation];
    }
    else if([self.mAnimationType isEqualToString:@"时间函数:CAMediaTimingFunction"])
    {
        [self initTimeFunction];
    }
    else if([self.mAnimationType isEqualToString:@"动画组"])
    {
        [self initAnimationGroup];
    }
    else
    {
        [self initShakeAnimation];
    }
}
//基本动画
- (void)initBasicAnimation
{
    UIImageView * ball = [[UIImageView alloc]initWithFrame:CGRectMake(40, 300, 30, 30)];
    ball.image = [UIImage imageNamed:@"ball"];
    [self.view addSubview:ball];
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @40;
    animation.toValue = @280;
    animation.duration = 1;
    animation.repeatDuration = 3;
    //animation.fillMode = kCAFillModeForwards;//将动画停留在最终状态
    animation.removedOnCompletion = NO;//防止动画被自动移除
    [ball.layer addAnimation:animation forKey:@"basic"];
    //ball.layer.position = CGPointMake(40, 350);
}
//多步动画
- (void)initDuoBuAnimation
{
    //抖动控件
    UIImageView * shakeBall = [[UIImageView alloc]initWithFrame:CGRectMake(160, 310, 30, 30)];
    shakeBall.image = [UIImage imageNamed:@"ball"];
    [self.view addSubview:shakeBall];
    //抖动动画
    CAKeyframeAnimation * shakeAnimation = [CAKeyframeAnimation animation];
    shakeAnimation.keyPath = @"position.x";
    shakeAnimation.values = @[@0,@10,@-10,@10,@0];
    shakeAnimation.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
    shakeAnimation.duration = 0.4;
    shakeAnimation.additive = YES;
    [shakeBall.layer addAnimation:shakeAnimation forKey:@"shake"];

}
//沿路径动画
- (void)initRouteAnimation
{
    //背景图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 329, 720/2)];
    imageView.image = [UIImage imageNamed:@"beijing.jpg"];
    [self.view addSubview:imageView];
    //环绕的球
    UIImageView * roundBall = [[UIImageView alloc]initWithFrame:CGRectMake(150, 220, 20, 20)];
    roundBall.image = [UIImage imageNamed:@"ball"];
    [self.view addSubview:roundBall];
    
    CGRect boundingRect = CGRectMake(-150, -150, 300, 300);
    CAKeyframeAnimation * orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    [roundBall.layer addAnimation:orbit forKey:@"orbit"];
}
//时间函数
- (void)initTimeFunction
{
    
    //抖动控件
    UIImageView * shakeBall = [[UIImageView alloc]initWithFrame:CGRectMake(160, 310, 30, 30)];
    shakeBall.image = [UIImage imageNamed:@"ball"];
    [self.view addSubview:shakeBall];
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @40;
    animation.toValue = @280;
    animation.duration = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :0 :0.9 :0.7];
    [shakeBall.layer addAnimation:animation forKey:@"basic"];
    shakeBall.layer.position = CGPointMake(150, 300);
}
//动画组
- (void)initAnimationGroup
{
    CABasicAnimation * zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation * rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[@0,@0.14,@0];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    CAKeyframeAnimation * position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[[NSValue valueWithCGPoint:CGPointZero],[NSValue valueWithCGPoint:CGPointMake(110, -20)],[NSValue valueWithCGPoint:CGPointZero]];
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    position.additive = YES;
    position.duration = 1.2;
    CAAnimationGroup * group = [[CAAnimationGroup alloc]init];
    group.animations = @[zPosition,rotation,position];
    group.duration = 1.2;
    group.beginTime = 0.5;
}
//抖动动画
- (void)initShakeAnimation
{
    //抖动控件
    UIImageView * shakeBall = [[UIImageView alloc]initWithFrame:CGRectMake(160, 310, 30, 30)];
    shakeBall.image = [UIImage imageNamed:@"ball"];
    [self.view addSubview:shakeBall];
    //抖动动画
    CAKeyframeAnimation * shakeAnimation = [CAKeyframeAnimation animation];
    shakeAnimation.keyPath = @"position.x";
    shakeAnimation.values = @[@0,@10,@-10,@10,@0];
    shakeAnimation.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
    shakeAnimation.duration = 0.4;
    shakeAnimation.additive = YES;
    [shakeBall.layer addAnimation:shakeAnimation forKey:@"shake"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
