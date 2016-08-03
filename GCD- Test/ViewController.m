//
//  ViewController.m
//  GCD- Test
//
//  Created by WangQiao on 16/8/2.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewController.h"
#import "GCD.h"

@interface ViewController ()

@property (nonatomic, strong) GCDTimer    *timer;
@property (nonatomic, strong) UIImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [GCDQueue excuteInGlobalQueue:^{ // 这里处理下载任务
        
        NSLog(@"下载图片");
        UIImage *image = [self imageWithStringUrl:@"http://img5.duitang.com/uploads/item/201406/19/20140619120221_WmYiV.jpeg"];
        
        [GCDQueue excuteInMainQueue:^{ //这里刷新UI
            
            NSLog(@"刷新UI前");
            UIImageView *imageView1        = [[UIImageView alloc] initWithFrame:CGRectMake(50, 60, 180, 180)];
            imageView1.contentMode         = UIViewContentModeScaleAspectFill;
            imageView1.image               = image;
            imageView1.layer.masksToBounds = YES;
            imageView1.layer.borderWidth   = 2;
            imageView1.layer.borderColor   = [UIColor redColor].CGColor;
            [self.view addSubview:imageView1];
            
             NSLog(@"刷新UI后,但他的图片下载,我延迟了");
            self.imageView2                     = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 180, 180)];
            self.imageView2.contentMode         = UIViewContentModeScaleAspectFill;
            self.imageView2.layer.borderWidth   = 2;
            self.imageView2.layer.masksToBounds = YES;
            self.imageView2.layer.borderColor   = [UIColor yellowColor].CGColor;
            [self.view addSubview:self.imageView2];
            
        }];
    }];
    
    // 添加定时器
    
    self.timer = [[GCDTimer  alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        NSLog(@"延迟加载,处理的事情");
        self.imageView2.image = [self imageWithStringUrl:@"http://img5.duitang.com/uploads/item/201406/19/20140619120221_WmYiV.jpeg"];
        
    } timeInterval:NSEC_PER_SEC * 20 delay:NSEC_PER_SEC * 20]; // 延迟20秒加载图片.每隔20秒刷新一下
    
    [self.timer start];

    
    NSLog(@"-----------------------------你可以分段操作---------------------------------------");
    
      /*
       * GCDGroup 用法: 如果想在GCDQueue中所有的任务完成后再做某种操作,在串行队列中,可以把该操作放到最后一个任务执行完后再继续,下面 NSLog 输出的循序不定,
       * 优先级的设定,也不能保证它一定是第一个或者最后一个执行,只是执行的先后概率比普通的队列大些.
       * 因为在并行队列上执行完成后,最后到main队列上执行一个操作, 保证[[GCDQueue mainQueue] notify的方法最后执行.
    */
    
//    GCDGroup *group = [GCDGroup new];
//    
//    [[GCDQueue globalQueue] execute:^{
//
//        NSLog(@"我是一号,但我不知道什么时候轮到我");
//        
//    } inGroup:group];
//    
//    [[GCDQueue globalQueue] execute:^{
//        
//        NSLog(@"我是二号,但我不知道什么时候轮到我");
//        
//    } inGroup:group];
//    
//    [[GCDQueue highPriorityGlobalQueue] execute:^{
//        
//        NSLog(@"我优先级最高,有机会,我就先执行了");
//        
//    } inGroup:group];
//    
//    [[GCDQueue lowPriorityGlobalQueue] execute:^{
//        
//        NSLog(@"我的优先级低,所以我等着他们执行完了再,但愿最后执行");
//        
//    } inGroup:group];
//    
//    [[GCDQueue backgroundPriorityGlobalQueue] execute:^{
//        
//        NSLog(@"background Priority Global Queue");
//        
//    } inGroup:group];
//
//    [[GCDQueue mainQueue] notify:^{
//        
//        NSLog(@"他们都执行完了,我通知你们一下");
//        
//    } inGroup:group];
//    
//  
//    
//    NSLog(@"--------------------------------你可以分段操作-----------------------------------------");
//    // 信号量
//    /*
//     信号(signal) 和 等待(wait) 是成对出现的
//     
//     */
//    
//    GCDSemaphore *semaphore = [GCDSemaphore new];
//    
//    [GCDQueue excuteInGlobalQueue:^{
//        
//        NSLog(@"我1先来的,我要先执行了,因为后面的人要等待");
//        [semaphore wait];
//        
//        //  要想向我一样等待,就在这里带着,do what you want to  do
//        NSLog(@"我是最后一个,我等了好一会,现在才轮到我,还好大概跟2差不多执行完");
//    }];
//    
//    [GCDQueue executeInGlobalQueue:^{
//        
//        // 在发信号之前,先执行你想做的
//        NSLog(@"我2就是等在他后面的人,等了很久,大概8秒吧,等我执行了完任务,就给你发个信号,你马上就能执行了");
//        
//        [semaphore signal];
//
//    } afterDelaySecs:8.f];
//    
    
    
    
    
}

- (UIImage *)imageWithStringUrl:(NSString *)string {
    
    NSURL   *url    = [NSURL URLWithString:string];
    NSData  *data   = [NSData dataWithContentsOfURL:url];
    UIImage *image  = [UIImage imageWithData:data];
    return image;
}

@end
