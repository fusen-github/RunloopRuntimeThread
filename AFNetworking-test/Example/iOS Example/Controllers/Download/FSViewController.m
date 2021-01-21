//
//  FSViewController.m
//  iOS Example
//
//  Created by 付森 on 2021/1/20.
//

#import "FSViewController.h"
#import "FSDloadModel.h"
#import "FSDloadCell.h"
#import "FSDloadManager.h"

@interface FSViewController ()<UITableViewDelegate, UITableViewDataSource, FSDloadManagerDelegate>

@property (nonatomic, strong) NSArray *models;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *direction = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSMutableArray *datas = [NSMutableArray array];
    
    for (int i = 0; i < 50; i++) {
        
        FSDloadModel *model = [[FSDloadModel alloc] init];
        
        model.title = [NSString stringWithFormat:@"FS-%2d", i];
        
        model.urlString = @"https://dldir1.qq.com/qqfile/QQforMac/QQ_6.7.3.dmg";
        
        NSString *fileName = [NSString stringWithFormat:@"QQ_%02d.dmg", i];
        
        model.targetPath = [direction stringByAppendingPathComponent:fileName];
        
        [datas addObject:model];
    }
    
    self.models = datas;
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.frame = self.view.bounds;
    
    [self.view addSubview:tableView];
    
    [FSDloadManager shareManager].delegate = self;
    
    /*
     /Users/NavInfo/Library/Developer/CoreSimulator/Devices/3DD909D0-2D6D-41E1-BD13-F3291E56D564/data/Containers/Data/Application/DEF45694-D909-4251-ADF1-60A80AEB9298
     */
    NSLog(@"home=%@", NSHomeDirectory());
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kCellId = @"FSViewControllerCell";
    
    FSDloadCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        
        cell = [[FSDloadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellId];
    }
    
    cell.model = [self.models objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.models objectAtIndex:indexPath.row];
    
    [[FSDloadManager shareManager] resumeDload:model];
}

#pragma mark FSDloadManagerDelegate

- (void)didUpdateModelProgress:(FSDloadModel *)model
{
    if (![[NSThread currentThread] isMainThread]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSInteger row = [self.models indexOfObject:model];
            
            NSLog(@"index = %ld", index);
            
//            [self.tableView reloadData];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];

            FSDloadCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

            [cell updateProgress:model.progress];
        });
    }
    else
    {
        NSInteger index = [self.models indexOfObject:model];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
        
        FSDloadCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        [cell updateProgress:model.progress];
        
        NSLog(@"是main");
    }
    
    
}


@end
