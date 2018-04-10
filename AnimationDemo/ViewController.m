//
//  ViewController.m
//  AnimationDemo
//
//  Created by 乔冬 on 2018/4/10.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "ViewController.h"
#import "NTVBasicAnimationTool.h"
#import "SLNRadarView.h"
#import "NTVView.h"
@interface ViewController ()
{
    NSTimer *_timer;
    UIImageView *_imgView;
}
@property (nonatomic,strong)      UIImageView *imgView;;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //基本动画
    [self  ntvBaseTranslation];
    //画三角形
    //    [self drawtriangle];
    //雷达动画
    [self slnRadarView];
    //闪烁
    [self slnFlashing];
}

#pragma mark -- 基本动画
- (void)ntvBaseTranslation{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(self.view.frame.size.width/2.0 - 44, 120, 44 ,44);
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(self.view.frame.size.width/2.0 - 22, 120 + 54, 44 ,44);
    view1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view1];
    //平移
    //    CATransform3D  transform3D  = CATransform3DTranslate( CATransform3DIdentity, 0.0, 0.0, 1.0);
    //    view.layer.transform = transform3D;
    //
    //    CATransform3D  transform3D1  = CATransform3DTranslate( CATransform3DIdentity, 0.0, 0.0, 2.0);
    //    view1.layer.transform = transform3D1;
    
    //缩放
    //    CATransform3D  transform3D  = CATransform3DScale( CATransform3DIdentity, 1.0, 1.0, 100.0);
    //    view.layer.transform = transform3D;
    //
    //    CATransform3D  transform3D1  = CATransform3DScale( CATransform3DIdentity, 1.0, 1.0, -0.5);
    //    view1.layer.transform = transform3D1;
    //旋转
    CATransform3D  transform3D  = CATransform3DMakeRotation(radians(60), 1.0, 1.0, 0.0);
    view.layer.transform = transform3D;
    
    CATransform3D  transform3D1  = CATransform3DRotate(CATransform3DIdentity, radians(60), 1.0, 1.0, 1.0);//    CATransform3DMakeRotation( 60*M_PI *2, 0.0, 0.0, 1.0);
    view1.layer.transform = transform3D1;
    //旋转2
    //    [view1.layer setValue:[NSNumber numberWithInt:60] forKeyPath:@"transform.rotation.z"];
    
}
double radians(float degrees) {
    return ( degrees * M_PI ) / 180.0;
}
#pragma mark -- 画三角形
-(void)drawtriangle{
    NTVView *ntvView = [[NTVView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 48)];
    //    ntvView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:ntvView];
}

#pragma mark --雷达动画
- (void)slnRadarView{
    SLNRadarView *slnRadarView = [[SLNRadarView alloc]init];
    slnRadarView.frame = CGRectMake(10, 300, self.view.frame.size.width - 20, self.view.frame.size.width - 20);
    [self .view addSubview:slnRadarView];
    [slnRadarView startRadar];
}


#pragma mark -- 闪烁
- (void)slnFlashing{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(change) userInfo:nil repeats:YES];
    self.imgView.frame = CGRectMake(40, 64, 5, 5);
    [self.view addSubview:self.imgView];
}

- (void)change{
    [_imgView removeFromSuperview];
    CGFloat width = self.view.frame.size.width;
    int widthX = (int)width;
    int heightY = (int)320;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int x = (arc4random() %(widthX - 10) ) + 10;
        int y = (arc4random() %(heightY - 64) ) + 64;
//        [UIView animateWithDuration:0.5f animations:^{
//        }];
        _imgView.frame = CGRectMake(x, y, 5, 5);
        [self.view addSubview:self.imgView];
    });
    
}



#pragma mark -- getter
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView  alloc]init];
        _imgView.layer.masksToBounds = YES;
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.frame = CGRectMake(0, 0, 5, 5);
        _imgView.layer.cornerRadius = 2.5;
        [_imgView.layer addAnimation:[NTVBasicAnimationTool opacityForeverAnimation:0.5f] forKey:nil];
    }
    return  _imgView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
