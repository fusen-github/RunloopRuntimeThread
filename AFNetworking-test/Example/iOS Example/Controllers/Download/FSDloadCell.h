//
//  FSDloadCell.h
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FSDloadModel;
@interface FSDloadCell : UITableViewCell

@property (nonatomic, strong) FSDloadModel *model;

- (void)updateProgress:(float)progress;

@end

NS_ASSUME_NONNULL_END
