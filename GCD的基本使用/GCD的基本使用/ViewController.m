//
//  ViewController.m
//  GCD的基本使用
//
//  Created by ZKJ on 2016/11/7.
//  Copyright © 2016年 ZKJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self asyncMain];
}

/**
 * 同步函数 + 并发队列：不会开启新的线程
 */
- (void)syncConCurrent
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3---%@", [NSThread currentThread]);
    });
}

/**
 * 异步函数 + 并发队列：可以同时开启多条线程
 */
- (void)asyncConCurrent
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"1 - %d - %@", i, [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"2 - %d - %@", i, [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"3 - %d - %@", i, [NSThread currentThread]);
        }
    });
}

/**
 * 同步函数 + 串行队列：不会开启新的线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务
 */
- (void)syncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("com.nbcb.mobilebank", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
}

/**
 * 异步函数 + 串行队列：会开启新的线程，但是任务是串行的，执行完一个任务，再执行下一个任务
 */
- (void)asyncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("com.nbcb.mobilebank", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
}

/**
 * 同步函数 + 主队列：
 */
- (void)syncMain
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
}

/**
 * 异步函数 + 主队列：只在主线程中执行任务
 */
- (void)asyncMain
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
}

@end
