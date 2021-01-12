//
//  FSThreadTimer.m
//  FSOcApp
//
//  Created by 付森 on 2021/1/12.
//

#import "FSThreadTimer.h"

@interface XXXInnerThread : NSThread

@end

@implementation XXXInnerThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end

@interface FSThreadTimer ()

@property (nonatomic, strong) NSTimer *innerTimer;

@property (nonatomic, strong) NSThread *innerThread;

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL aSelector;

@property (nonatomic, assign) BOOL runFlag;

@end

@implementation FSThreadTimer

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    FSThreadTimer *obj = [[FSThreadTimer alloc] init];
    
    NSThread *innerThread = [[XXXInnerThread alloc] initWithTarget:obj selector:@selector(subThreadAction) object:nil];
    
    obj.innerThread = innerThread;
    
    // 方案一
//    NSTimer *innerTimer = [NSTimer timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    
    // 方案二
    obj.target = aTarget;
    obj.aSelector = aSelector;
    obj->_userInfo = userInfo;
    NSTimer *innerTimer = [NSTimer timerWithTimeInterval:ti target:obj selector:@selector(innerTimerAction) userInfo:userInfo repeats:yesOrNo];

    obj.innerTimer = innerTimer;
    
    return obj;
    
}

- (void)innerTimerAction
{
    [self.target performSelector:self.aSelector onThread:self.innerThread withObject:self waitUntilDone:YES];
}

- (void)fire
{
    [self.innerThread start];
}

- (void)subThreadAction
{
    NSLog(@"subThreadAction begin");
    
    [[NSRunLoop currentRunLoop] addTimer:self.innerTimer forMode:NSDefaultRunLoopMode];
    
    [self.innerTimer fire];
    
    self.runFlag = YES;
    
    while (self && self.runFlag) {
        NSLog(@"while开始");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"while结束");
    }
        
    NSLog(@"subThreadAction end");
}

- (void)invalidate
{
    [self performSelector:@selector(__invalidate) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)__invalidate
{
    self.runFlag = NO;
    
    [self.innerTimer invalidate];
}

- (BOOL)isValid
{
    return [self.innerTimer isValid];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
