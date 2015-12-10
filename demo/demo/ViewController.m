//
//  ViewController.m
//  demo
//
//  Created by qingyun on 15/12/10.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *systemIV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *demoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    demoImageView.image = [UIImage imageNamed:@"big"];
    demoImageView.contentMode = UIViewContentModeScaleAspectFit;
    _systemIV = demoImageView;
    [self.view addSubview:_systemIV];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _systemIV.center = location;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
