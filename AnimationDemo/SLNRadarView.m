//
//  SLNRadarView.m
//  AnimationDemo
//
//  Created by 乔冬 on 2018/3/20.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "SLNRadarView.h"
//    struct CATransform3D
//    {
//        CGFloat m11(sx缩放), m12（y切变）, m13（旋转）, m14;
//        CGFloat m21（x切变）, m22(sy缩放), m23, m24;
//        CGFloat m31(旋转), m32, m33, m34（sz透明效果，要操作的这个对象要有旋转的角度，否则没有效果，正/负都有意义）;
//        CGFloat m41（tx平移）, m42（ty平移）, m43（tz平移）, m44;
//    };
@interface SLNRadarView()
{
    CAShapeLayer *_pulseLayer;
    CAReplicatorLayer * _replicatorLayer;
    CAAnimationGroup *_groupAnima;
}
@end
@implementation SLNRadarView

-(instancetype)init{
    if (self = [super init]) {
//            [self setUpView];
//        [self setFrame:self.frame];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setUpView];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
            [self setUpView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpView];
}
- (void)setUpView{
    //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
    //1.CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
    
    _pulseLayer = [CAShapeLayer layer];
    _pulseLayer.frame = self.layer.bounds;
    //创建椭圆路径
    _pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:_pulseLayer.bounds].CGPath;
    //填充色
    _pulseLayer.fillColor = [UIColor redColor].CGColor;
    //设置描边色
    _pulseLayer.strokeColor = [UIColor greenColor].CGColor;
    //设置不透明度
    _pulseLayer.opacity = 0.0;
    
    //2.创建可复制layer
    
    _replicatorLayer = [CAReplicatorLayer layer];
    _replicatorLayer.frame = self.layer.bounds;
    //创建副本的数量,包括源对象。
    _replicatorLayer.instanceCount = 4;
    //复制副本之间的延迟
    _replicatorLayer.instanceDelay = 1;
    [_replicatorLayer addSublayer:_pulseLayer];
    [self.layer addSublayer:_replicatorLayer];
    
    
    //3.添加动画
    //1)、动画类型：设置不透明度
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    //2）、创建缩放动画
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    //正常缩放
    //    sz：整体比例变换时，也就是m11（sx）== m22（sy）时，若m33（sz）>1，图形整体缩小，若0<1，图形整体放大，若m33（sz）<0，发生关于原点的对称等比变换。
    //    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    //    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)];
    //3）动画组
    _groupAnima  = [CAAnimationGroup animation];
    _groupAnima.animations = @[opacityAnima, scaleAnima];
    _groupAnima.duration = 4.0;
    _groupAnima.repeatCount = HUGE;
    _groupAnima.autoreverses = NO;
}
- (void)startRadar{
        [_pulseLayer addAnimation:_groupAnima forKey:@"groupAnimation"];
}
- (void)closeRadar{
      [_pulseLayer removeAnimationForKey:@"groupAnimation"];
}



@end
