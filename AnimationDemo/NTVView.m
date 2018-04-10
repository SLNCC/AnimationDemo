//
//  NTVView.m
//  AnimationDemo
//
//  Created by 乔冬 on 2018/3/20.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVView.h"
#define  k_ScreenWidth [ UIScreen mainScreen].bounds.size.width
@implementation NTVView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
           [self drawtriangle];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawtriangle];
}

//绘制一个三角形
-(void)drawtriangle{
    //绘制一条完整路径  首先创建路径对象,接着按绘制顺序添加关键点,最后调用[path closePath]方法闭合路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(40, self.frame.size.height - 40)];
    [path addLineToPoint:CGPointMake(k_ScreenWidth- 40, self.frame.size.height - 40)];
    [path addLineToPoint:CGPointMake(k_ScreenWidth/2, 40)];

    
    /*设置填充颜色   创建一个颜色对象之后,需要调用颜色的set方法设置上下文环境,接着调用路径的fill方法使用上下文环境中的颜色来填充
     Tip: 这个fill方法很有意思
     如果第一次设置上下文环境为红色,那么调用fill的则会为该路径内填充红色
     但是第二次设置上下文环境为绿色时,调用fill方法并不是说将路径内的红色替换掉,而是在红色的上方填充一次绿色
     */
    UIColor *redColor = [UIColor redColor];
    [redColor set];
    [path fill];
    
    //设置线条属性  各种格式我会贴出来给大家看,方便对比
    path.lineCapStyle = kCGLineJoinRound;  //线段端点格式
//    path.lineJoinStyle = kCGLineJoinRound; //线段接头格式
    path.lineWidth = 8;
    
    //设置路径颜色  原理和设置填充颜色一样,这不过是调用[path stroke]方法来设置路径额颜色 设置线宽为8
    UIColor *blackColor = [UIColor blueColor];
    [blackColor set];
    [path stroke];
    UIColor *greenColor = [UIColor greenColor];
    [greenColor set];
    [path fill];
    
    [path closePath];
}
@end
