//
//  FSDownloader.m
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import "FSDownloader.h"
#import <AFNetworking/AFNetworking.h>


@interface FSDownloader ()

@property (nonatomic, copy) void(^progressBlock)(float progress);

@property (nonatomic, copy) void(^completion)(FSDownloader *obj, NSError *error);

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, copy) NSString *targetPath;

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation FSDownloader

+ (instancetype)downloaderURL:(NSURL *)url
                   targetPath:(NSString *)path
                progressBlock:(void(^)(float progress))progressBlock
                   completion:(void(^)(FSDownloader *obj, NSError *error))completion;
{
    FSDownloader *obj = [[FSDownloader alloc] init];
    
    obj.progressBlock = progressBlock;
    
    obj.completion = completion;
    
    obj.url = url;
    
    obj.targetPath = path;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    
    return obj;
}

- (void)resume
{
    if (self.httpManager) {
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.url];
    
    NSString *targetPath = self.targetPath;
    
    unsigned long long size = [self fileSizeAtPath:targetPath];
    
    if (size > 0) {
        
        NSString *range = [NSString stringWithFormat:@"bytes=%llu-", size];
        
        [request setValue:range forHTTPHeaderField:@"Range"];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    self.httpManager = manager;
    
    __weak typeof(self) weakSelf = self;
    
    [manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {

        NSLog(@"");

        return NSURLSessionResponseAllow;

    }];

    [manager setDataTaskDidReceiveDataBlock:^(NSURLSession *session, NSURLSessionDataTask * dataTask, NSData *data) {

        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:targetPath];

        [fileHandle seekToEndOfFile];

        [fileHandle writeData:data];

        [fileHandle closeFile];
    }];
    
    NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [manager dataTaskWithRequest:request uploadProgress:NULL downloadProgress:^(NSProgress *downloadProgress) {
            
        [weakSelf handleProgress:downloadProgress localSize:size];
        
    } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            
        if (weakSelf.completion) {
            weakSelf.completion(weakSelf, error);
        }
        
    }];
    
    [dataTask resume];
}

- (void)handleProgress:(NSProgress *)progress localSize:(unsigned long long)size
{
    double totalUnitCount = (progress.totalUnitCount + size) * 1.0;
    
    double completedUnitCount = (progress.completedUnitCount + size) * 1.0;
    
    double value = completedUnitCount / totalUnitCount;
    
    if (self.progressBlock) {
        self.progressBlock(value);
    }
}


- (void)cancel
{
    [self.httpManager invalidateSessionCancelingTasks:YES resetSession:YES];
    
    self.httpManager = nil;
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

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
