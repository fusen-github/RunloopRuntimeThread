//
//  FSPermanentThread.m
//  FSOcApp
//
//  Created by 付森 on 2021/1/12.
//

#import "FSPermanentThread.h"

@interface YYYYThread : NSThread

@end

@implementation YYYYThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end

@interface FSPermanentThread ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, assign) BOOL runFlag;

@property (nonatomic, copy) void(^taskBlock)(void);

@end

@implementation FSPermanentThread

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSThread *thread = [[YYYYThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
    
    self.thread = thread;
}

- (void)threadAction
{
    NSLog(@"thread 开始");

    NSPort *port = [[NSPort alloc] init];

    [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];

    self.runFlag = YES;
    
    while (self && self.runFlag) {
        NSLog(@"while开始");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"while结束");
    }
    
    NSLog(@"thread 结束");
}

- (void)start
{
    [self.thread start];
}

- (void)stop
{
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)__stop
{
    self.runFlag = false;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)asyncExecuteTask:(void(^)(void))block
{
    if (!block) {
        return;
    }
    
    NSLog(@"线程是否正在执行:%@", self.thread.isExecuting ? @"yes" : @"no");
    
    [self performSelector:@selector(_innerExecute:) onThread:self.thread withObject:block waitUntilDone:NO];
}

- (void)syncExecuteTask:(void(^)(void))block
{
    if (!block) {
        return;
    }
    
    NSLog(@"线程是否正在执行:%@", self.thread.isExecuting ? @"yes" : @"no");
    
    [self performSelector:@selector(_innerExecute:) onThread:self.thread withObject:block waitUntilDone:YES];
}

- (void)_innerExecute:(void(^)(void))block
{
    block();
}

@end
