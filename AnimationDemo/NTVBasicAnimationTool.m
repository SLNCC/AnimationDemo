//
//  NTVBasicAnimationTool.m
//  AnimationDemo
//
//  Created by 乔冬 on 2018/4/10.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVBasicAnimationTool.h"

@implementation NTVBasicAnimationTool

+ (CABasicAnimation *)opacityForeverAnimation:(float)time{
    //必须写opacity才行。
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}





@end
