//
//  SecondViewController.m
//  FSOcApp
//
//  Created by 付森 on 2021/1/12.
//

#import "SecondViewController.h"


@interface SecondViewController ()



@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"second";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *array = @[@"开启", @"关闭"];
    
    for (NSString *title in array) {
        
        NSInteger index = [array indexOfObject:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = index + 100;
        
        CGFloat wh = 50;
        
        CGFloat x = 100 + index * (wh + 80);
        
        btn.frame = CGRectMake(x, 100, wh, wh);
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
}

- (void)clickBtn:(UIButton *)btn
{
    if (btn.tag == 100) {
        [self startThread];
    }
    else
    {
        [self endThread];
    }
}

- (void)startThread
{
    
}

- (void)endThread
{
    
}

- (void)subThreadAction
{
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
    
    
    
}




@end
