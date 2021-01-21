//
//  FSGCDTimer.h
//  FSOcApp
//
//  Created by 付森 on 2021/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSGCDTimer : NSObject

+ (instancetype)gcdTimerWithInterval:(NSUInteger)interval delay:(NSUInteger)delay;

- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
