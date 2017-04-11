//
//  ViewController.m
//  ballBouncesDemo
//
//  Created by zhang on 2017/4/11.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)UIImageView *ballImage;
@end

@implementation ViewController
{
    __block NSMutableArray *values;
    __block  NSMutableArray *funs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(150, 40, 150, 30)];
    [self.view addSubview:label];
    label.text=@"点击屏幕拍皮球";
    
    self.ballImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 80, 80)];
    [self.ballImage setImage:[UIImage imageNamed:@"ball"]];
    //因为使用的是position动画所以需要定义center  ball相对于view的位置 center 对应 layer的position
    self.ballImage.center = CGPointMake(100, 40);
    [self.view addSubview:self.ballImage];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self animationBall];

    [self animation];
}
-(void)animation
{
    self.ballImage.center = CGPointMake(100, 40);

    
 
    __block float ballHeight=self.view.frame.size.height-40-self.ballImage.center.y;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        values=[[NSMutableArray alloc]init];
        funs=[[NSMutableArray alloc]init];
        while (ballHeight>10) {
            ballHeight=  ballHeight/3*2;
            //一个弹跳 kCAMediaTimingFunctionEaseIn kCAMediaTimingFunctionEaseOut
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(100, self.view.frame.size.height-40)]];
            [funs addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            
            
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(100, self.view.frame.size.height-40-ballHeight)]];
            [funs addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
            
            
        }

    });
    
    
    CAKeyframeAnimation *keyAnimation=[CAKeyframeAnimation animation];
    keyAnimation.keyPath=@"position";
    keyAnimation.duration=0.35*values.count;
    keyAnimation.values=values;
    keyAnimation.timingFunctions=funs;
    self.ballImage.layer.position=CGPointMake(100, self.view.frame.size.height-40);
    [self.ballImage.layer addAnimation:keyAnimation forKey:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




































@end
