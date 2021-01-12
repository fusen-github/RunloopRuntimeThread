//
//  FSThreadTimer.h
//  FSOcApp
//
//  Created by 付森 on 2021/1/12.
//  子线程timer

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSThreadTimer : NSObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong, readonly) id userInfo;

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

- (void)fire;

- (void)invalidate;

- (BOOL)isValid;

@end

NS_ASSUME_NONNULL_END
