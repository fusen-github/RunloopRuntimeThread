//
//  FSDloadOperation.m
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import "FSDloadOperation.h"
#import "FSDloadModel.h"
#import "FSDownloader.h"


@interface FSDloadOperation ()

@property (nonatomic, strong) FSDloadModel *model;

@property (nonatomic, strong) FSDownloader *obj;

@property (nonatomic, assign) BOOL runFlag;

@end

@implementation FSDloadOperation

- (instancetype)initWithModel:(FSDloadModel *)model
{
    if (self = [super init]) {
        
        self.model = model;
    }
    return self;
}

- (void)main
{
    if (self.isCancelled || self.isFinished) {
        return;
    }
    
    FSDloadModel *model = self.model;
    
//    NSString *urlString = [model.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
//
//    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *urlString = model.urlString;
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
//    NSURL *url = [NSURL URLWithString:@"https://dldir1.qq.com/qqfile/QQforMac/QQ_6.7.3.dmg"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    __weak typeof(self) weakSelf = self;
    
    FSDownloader *obj = [FSDownloader downloaderURL:url targetPath:model.targetPath progressBlock:^(float progress) {
        
        model.progress = progress;
        
        NSLog(@"%lf", progress);
        
        [weakSelf handleProgress:progress];
        
    } completion:^(FSDownloader * _Nonnull obj, NSError * _Nonnull error) {
        
    }];
    
    [obj resume];
    
    self.obj = obj;
    
    self.runFlag = true;
    
    NSLog(@"来了---1");
    
//    while (self.runFlag) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
    
    NSLog(@"来了---2");
}

- (void)handleProgress:(float)progress
{
    if ([self.delegate respondsToSelector:@selector(operationDidUpdateProgress:)]) {
        [self.delegate operationDidUpdateProgress:self];
    }
}

- (void)cancel
{
    
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
