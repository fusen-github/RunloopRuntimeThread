//
//  FSNetworking.m
//  iOS Example
//
//  Created by 付森 on 2021/1/19.
//

#import "FSNetworking.h"

@interface FSNetworking ()

//@property (nonatomic, strong) NSFileHandle *fileHandle;

@property (nonatomic, copy) NSString *targetPath;

//@property (nonatomic, assign) unsigned long long downloadedSize;

@end

@implementation FSNetworking

- (void)downloadFileWithUrl:(NSURL *)url targetPath:(NSString *)targetPath
{
//    NSURL *url = [NSURL URLWithString:@"https://dldir1.qq.com/qqfile/QQforMac/QQ_6.7.3.dmg"];
    
    _targetPath = targetPath;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:targetPath]) {
        [manager createFileAtPath:targetPath contents:nil attributes:nil];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    unsigned long long size = [self fileSizeAtPath:targetPath];
    
    if (size > 0) {
        
        NSString *range = [NSString stringWithFormat:@"bytes=%llu-", size];
        
        [request setValue:range forHTTPHeaderField:@"Range"];
    }
    
    NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
        double totalUnitCount = (downloadProgress.totalUnitCount + size) * 1.0;
        
        double completedUnitCount = (downloadProgress.completedUnitCount + size) * 1.0;
        
        double value = completedUnitCount / totalUnitCount;
        
        NSLog(@"value = %lf", value);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    
    __weak typeof(self) weakself = self;
    
    [self setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * session, NSURLSessionDataTask *dataTask, NSURLResponse *response) {
        
        NSLog(@"");
        
        return NSURLSessionResponseAllow;
    }];
    
    [self setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
        
        [weakself dowloadSession:session dataTask:dataTask receiveData:data];
    }];
    
    [dataTask resume];
}

/*
 value = 0.352228
 value = 0.352415
 value = 0.352602
 
 value = 0.743302
 */

- (void)dowloadSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask receiveData:(NSData *)data
{
    NSHTTPURLResponse *response = (id)dataTask.response;
    
//    NSLog(@"%@", response);
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:_targetPath];

    [fileHandle seekToEndOfFile];
    
    [fileHandle writeData:data];
    
    [fileHandle closeFile];
    
    NSLog(@"写数据,%@", [NSThread currentThread]);
}

- (unsigned long long)fileSizeAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) {
        return 0;
    }
    
    NSError *error = nil;
    
    NSDictionary *attribute = [manager attributesOfItemAtPath:path error:&error];
    
    unsigned long long size = 0;
    
    if (attribute && !error) {
        size = attribute.fileSize;
    }
    
    return size;
}

@end
