//
//  FSPermanentThread.h
//  FSOcApp
//
//  Created by 付森 on 2021/1/12.
//  常驻线程

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPermanentThread : NSObject

- (void)start;

- (void)stop;

- (void)asyncExecuteTask:(void(^)(void))block;

- (void)syncExecuteTask:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
