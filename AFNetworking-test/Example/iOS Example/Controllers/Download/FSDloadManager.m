//
//  FSDloadManager.m
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import "FSDloadManager.h"
#import "FSDloadOperation.h"


@interface FSDloadManager ()<FSDloadOperationDelegate>

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) NSMutableArray *opArray;

@end

@implementation FSDloadManager

+ (instancetype)shareManager
{
    static FSDloadManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSDloadManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.queue = [[NSOperationQueue alloc] init];
        
        self.queue.name = @"FSDloadManager_queue";
        
        self.queue.maxConcurrentOperationCount = 3;
        
        self.opArray = [NSMutableArray array];
    }
    return self;
}

- (void)resumeDload:(FSDloadModel *)model
{
    FSDloadOperation *op = [[FSDloadOperation alloc] initWithModel:model];
    
    op.delegate = self;
    
    [self.queue addOperation:op];
    
    [self.opArray addObject:op];
}

- (void)cancleDload:(FSDloadModel *)model
{
    NSArray *ops = [self.queue.operations copy];
    
    for (FSDloadOperation *op in ops) {
        if ([op.model isEqual:model]) {
            [op cancel];
            
            [self.opArray removeObject:op];
        }
    }
}

#pragma mark FSDloadOperationDelegate

- (void)operationDidUpdateProgress:(FSDloadOperation *)op
{
    if ([self.delegate respondsToSelector:@selector(didUpdateModelProgress:)]) {
        [self.delegate didUpdateModelProgress:op.model];
    }
}

- (void)operationDidCompletion:(FSDloadOperation *)op
{
    
}

- (void)operationDidCancle:(FSDloadOperation *)op
{
    
}

@end
