//
//  ViewController.m
//  AnimationDemo
//
//  Created by 乔冬 on 2018/4/10.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "ViewController.h"
#import "NTVBasicAnimationTool.h"
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
    
    
    //闪烁
    [self slnFlashing];
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
