//
//  FSGCDTimer.m
//  FSOcApp
//
//  Created by 付森 on 2021/1/14.
//

#import "FSGCDTimer.h"

@interface FSGCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation FSGCDTimer

- (instancetype)init
{
    if (self = [super init]) {
        
        dispatch_queue_t queue = dispatch_get_main_queue();
        
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        dispatch_source_set_event_handler(timer, ^{
            
            NSLog(@"%@", [NSThread currentThread]);
        });
        
        dispatch_source_set_cancel_handler(timer, ^{
            NSLog(@"timer cancel");
        });
        
        dispatch_resume(timer);
        
        self.timer = timer;
    }
    return self;
}

- (void)stopTimer
{
    dispatch_source_cancel(self.timer);
}

@end
