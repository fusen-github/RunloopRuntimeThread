//
//  FSDownloader.h
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSDownloader : NSObject

@property (nonatomic, strong, readonly) NSURL *url;

@property (nonatomic, copy, readonly) NSString *targetPath;

+ (instancetype)downloaderURL:(NSURL *)url
                   targetPath:(NSString *)path
                progressBlock:(void(^)(float progress))progressBlock
                   completion:(void(^)(FSDownloader *obj, NSError *error))completion;

- (void)resume;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
