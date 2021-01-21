//
//  FSDloadOperation.h
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FSDloadOperation;
@protocol FSDloadOperationDelegate <NSObject>

@optional
- (void)operationDidUpdateProgress:(FSDloadOperation *)op;

- (void)operationDidCompletion:(FSDloadOperation *)op;

- (void)operationDidCancle:(FSDloadOperation *)op;

@end

@class FSDloadModel;
@interface FSDloadOperation : NSOperation

@property (nonatomic, strong, readonly) FSDloadModel *model;

@property (nonatomic, weak) id<FSDloadOperationDelegate> delegate;

- (instancetype)initWithModel:(FSDloadModel *)model;

@end

NS_ASSUME_NONNULL_END
