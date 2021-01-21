//
//  FSDloadCell.m
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import "FSDloadCell.h"
#import "FSDloadModel.h"


@implementation FSDloadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        
        self.textLabel.textColor = [UIColor darkTextColor];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setModel:(FSDloadModel *)model
{
    _model = model;
    
    self.textLabel.text = model.title;
    
    self.detailTextLabel.text = [NSString stringWithFormat:@"进度:%.2f%%", model.progress * 100];
    
    
}

- (void)updateProgress:(float)progress
{
    self.detailTextLabel.text = [NSString stringWithFormat:@"进度:%.2f%%", progress * 100];
}

@end
