//
//  ViewController.m
//  AnimationDemo
//
//  Created by Zin_戦 on 15/10/22.
//  Copyright © 2015年 zhan神. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIView *testView;
}

@property (weak, nonatomic) CALayer *myLayer;
@property (assign,nonatomic) BOOL isFirst;
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *myLayer = [CALayer layer];
    [self.view.layer addSublayer:myLayer];
    self.myLayer = myLayer;
    [myLayer setBounds:CGRectMake(0, 0, 50, 80)];
    [myLayer setBackgroundColor:[UIColor redColor].CGColor];
    [myLayer setPosition:CGPointMake(160,160)];

    UIImage *image = [UIImage imageNamed:@"ex.png"];

    [myLayer setContents:(id)image.CGImage];

    [myLayer setAnchorPoint:CGPointMake(0.5, 0)];
    
    [myLayer setTransform:CATransform3DMakeRotation(-M_1_PI, 0, 0, 1)];
    [self translationBool:self.isFirst];
    self.myLayer = myLayer;

    testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    testView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:testView];
}

#pragma mark - 动画代理方法
#pragma mark 动画开始(极少用)
- (void)animationDidStart:(CAAnimation *)anim
{
    [UIView animateWithDuration:0.5 delay:1.0 usingSpringWithDamping:1 initialSpringVelocity:0.6 options:UIViewAnimationOptionAutoreverse animations:^{
        CGRect frame = testView.frame;
        frame.origin.y += 100 * 0.5;
        
        testView.frame = frame;
    } completion:^(BOOL finished) {
//        btn.hidden = YES;
    }];
    NSLog(@"开始动画");
}

#pragma mark 动画结束（通常在动画结束后，做动画的后续处理）
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //[self.myLayer setTransform:CATransform3DMakeRotation([[anim valueForKey:@"targetFloat"] floatValue], 0, 0, 1)];
    [self translationBool:self.isFirst];
}

#pragma mark CALayer的旋转
- (void)translationBool:(BOOL) isf
{
    

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    if (isf) {
        self.isFirst = NO;
        CGFloat flo = M_1_PI;
        [anim setFromValue:[NSNumber numberWithFloat:flo]];
        [anim setToValue:[NSNumber numberWithFloat:-flo]];
    }
    else
    {
        self.isFirst = YES;
        CGFloat flo = M_1_PI;
        [anim setFromValue:[NSNumber numberWithFloat:-flo]];
        [anim setToValue:[NSNumber numberWithFloat:flo]];
    }
    
    [anim setDuration:5.0f];
    
    [anim setDelegate:self];
    
    [anim setRemovedOnCompletion:NO];

    [anim setFillMode:kCAFillModeForwards];
    

    [self.myLayer addAnimation:anim forKey:@"animateLayer"];
}


@end
