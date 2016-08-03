//
//  GCDSemaphore.h
//  GCD
//
//  Created by WangQiao on 16/8/2.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

/**
 dispatch_semaphore 是GCD用来同步的一种方式,与他相关的三个函数 分别是:dispatch_semaphore_create，dispatch_semaphore_signal，dispatch_semaphore_wait。
 *
 封装后就是: GCDSemaphore 信号量,它的相关的函数有: 创建 (init)   信号 (signal)  等待(wait)
 
 *
 （1）dispatch_semaphore_create的声明为： dispatch_semaphore_t  dispatch_semaphore_create(long value);
     传入的是参数是一个long, 输出一个dispatch_semaphore_t类型且值为value的信号量。
     需要注意的是,这里传入的参数value 必须 >= 0 ,否则dispatch_semaphore_create会返回NULL。
 *
 （2）dispatch_semaphore_signal的声明为：long dispatch_semaphore_signal(dispatch_semaphore_t dsema) 
     这个函数会使传入的信号量dsema的值加1；
 *
 (3) dispatch_semaphore_wait的声明为：long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout)；
     这个函数会使传入的信号量dsema的值减1；
     这wait的作用是: 如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；
                   如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，不能直接传入整形或float型数）;
                   如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。
                   如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句.
 *
 (4) dispatch_semaphore_signal的返回值为long类型，当返回值为0时表示当前并没有线程等待其处理的信号量，其处理的信号量的值加1即可。当返回值不为0时，表示其当前有（一个或多个）线程等待其处理的信号量，并且该函数唤醒了一个等待的线程（当线程有优先级时，唤醒优先级最高的线程；否则随机唤醒）。
 
    dispatch_semaphore_wait的返回值也为long型。当其返回0时表示在timeout之前，该函数所处的线程被成功唤醒。当其返回不为0时，表示timeout发生。
 *
 (5)在设置timeout时，比较有用的两个宏：DISPATCH_TIME_NOW 和 DISPATCH_TIME_FOREVER。
 　　DISPATCH_TIME_NOW　　    表示当前；
 　　DISPATCH_TIME_FOREVER　　表示遥远的未来；
 *
 (6) dispatch_time的声明如下: dispatch_time_t dispatch_time(dispatch_time_t when, int64_t delta)；
 　　其参数when需传入一个dispatch_time_t类型的变量，和一个delta值。表示when加delta时间就是timeout的时间。
 　　例如：dispatch_time_t  t = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000);表示当前时间向后延时一秒为timeout的时间。

 */


#import <Foundation/Foundation.h>

@interface GCDSemaphore : NSObject

@property (strong, readonly, nonatomic) dispatch_semaphore_t dispatchSemaphore;

#pragma 初始化
- (instancetype)init;
- (instancetype)initWithValue:(long)value;

#pragma mark - 用法
- (BOOL)signal;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
