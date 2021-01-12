//
//  ViewController.m
//  FSOcApp
//
//  Created by 付森 on 2020/10/25.
// #75715D
// #515B70

#import "ViewController.h"
#import <OpenGLES/EAGL.h>
#import <Metal/Metal.h>
#import <WebKit/WebKit.h>
#import "SecondViewController.h"
#import "FSThreadTimer.h"
#import "FSPermanentThread.h"

@interface AAThread : NSThread

@end

@implementation AAThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end

@interface ViewController ()

@property (nonatomic, weak) UIView *redview;

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) FSThreadTimer *fs_timer;

@property (nonatomic, strong) FSPermanentThread *permanentThread;

@end

@implementation ViewController

- (const NSString *)name
{
    return @"";
}

/// 这是a
/// @param a 我是a
/// @param b 我是b
- (int)add:(int)a b:(NSObject *)b
{
    return 100;
}

/**
 *  dfasdffasdfasdf
 *  @param a 100
 */
- (int)add1:(int)a b:(NSObject *)b
{
    return 100;
}

// aaa
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"first";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    // Do any additional setup after loading the view.
    
//    UIView *redview = [[UIView alloc] init];
//
//    self.redview = redview;
//
//    [self.view addSubview:redview];
    
    
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    
//    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    
//    [webView loadRequest:request];
//    
//    [self.view addSubview:webView];
    
    
    
    NSLog(@"%s", __func__);
    
    FSPermanentThread *thread = [[FSPermanentThread alloc] init];
    
    self.permanentThread = thread;
    
    [self.permanentThread start];
    
}

- (void)rightAction
{
//    NSLog(@"rightAction-1");
//
//    [self performSelector:@selector(stopTimer) onThread:self.thread withObject:nil waitUntilDone:YES];
//
//    NSLog(@"rightAction-2");
    
//    [self.fs_timer invalidate];
//
//    self.fs_timer = nil;
    
    [self.permanentThread stop];
    self.permanentThread = nil;
    
}

- (void)stopTimer
{
    NSLog(@"%s, %@",__func__, [NSThread currentThread]);
    
    [self.timer timeInterval];
    
    self.timer = nil;
    
    self.thread = nil;
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    SecondViewController *controller = [[SecondViewController alloc] init];
//
//    [self.navigationController pushViewController:controller animated:YES];
    
//    if (self.thread) {
//        return;
//    }
//
//    NSThread *thread = [[AAThread alloc] initWithTarget:self selector:@selector(subThreadAction) object:nil];
//
//    self.thread = thread;
//
//    [thread start];
    
    
//    FSThreadTimer *timer = [FSThreadTimer timerWithTimeInterval:1 target:self selector:@selector(myTimerAction:) userInfo:@"XXXTest" repeats:YES];
//    
//    self.fs_timer = timer;
//    
//    [timer fire];
    
    
    
//    [self.permanentThread asyncExecuteTask:^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
    
    [self.permanentThread syncExecuteTask:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    NSLog(@"touch end");
    
}


//- (void)subThreadAction
//{
//    FSThreadTimer *timer = [FSThreadTimer timerWithTimeInterval:1 target:self selector:@selector(myTimerAction:) userInfo:@"XXXTest" repeats:YES];
//
//    [timer fire];
//}

- (void)myTimerAction:(FSThreadTimer *)obj
{
    NSLog(@"%@, %@", [NSThread currentThread], obj.userInfo);
}

//- (void)subThreadAction
//{
//    NSLog(@"subThreadAction:%@", [NSThread currentThread]);
//    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:@"aaaa" repeats:YES];
//    
//    self.timer = timer;
//    
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    
//    [timer fire];
//    
//    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    
//    NSLog(@"subThreadAction end");
//}

/*
 NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:@"aaaa" repeats:YES];
 
 [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
 
 [timer fire];
 */

- (void)timerAction:(NSTimer *)timer
{
    NSLog(@"定时器:%@, %@", timer.userInfo, [NSThread currentThread]);
}




@end
