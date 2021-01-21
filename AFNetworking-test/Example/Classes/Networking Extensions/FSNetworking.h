//
//  FSNetworking.h
//  iOS Example
//
//  Created by 付森 on 2021/1/19.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSNetworking : AFHTTPSessionManager

- (void)downloadFileWithUrl:(NSURL *)url targetPath:(NSString *)targetPath;

@end

NS_ASSUME_NONNULL_END
