//
//  FSDloadModel.h
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSDloadModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) float progress;

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, strong) NSString *targetPath;

@end

NS_ASSUME_NONNULL_END
