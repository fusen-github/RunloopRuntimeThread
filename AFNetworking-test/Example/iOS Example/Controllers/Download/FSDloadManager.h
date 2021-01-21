//
//  FSDloadManager.h
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import <Foundation/Foundation.h>
#import "FSDloadModel.h"


NS_ASSUME_NONNULL_BEGIN

@protocol FSDloadManagerDelegate <NSObject>

@optional
- (void)didUpdateModelProgress:(FSDloadModel *)model;

@end

@interface FSDloadManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, weak) id<FSDloadManagerDelegate> delegate;

- (void)resumeDload:(FSDloadModel *)model;

- (void)cancleDload:(FSDloadModel *)model;


@end

NS_ASSUME_NONNULL_END
