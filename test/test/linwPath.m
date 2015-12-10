//
//  linwPath.m
//  test
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "linwPath.h"

@implementation linwPath


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 20, 20);
    CGContextAddLineToPoint(ctx, 100, 200);
    CGContextSetLineWidth(ctx, 50);
    CGContextStrokePath(ctx);

}


@end
