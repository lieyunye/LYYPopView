//
//  ViewController.m
//  LYYPopView
//
//  Created by lieyunye on 2017/2/17.
//  Copyright © 2017年 lieyunye. All rights reserved.
//

#import "ViewController.h"
#import "LYYPopView.h"

@interface ViewController ()
@property (nonatomic, strong) LYYPopView *popView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.popView = [[LYYPopView alloc] init];
    self.popView.backgroundColor = [UIColor blackColor];
    self.popView.popViewDirectionType = LYYPopViewDirectionTypeRight;
    self.popView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:self.popView];

    
    
    self.popView = [[LYYPopView alloc] init];
    self.popView.backgroundColor = [UIColor blackColor];
    self.popView.popViewDirectionType = LYYPopViewDirectionTypeleft;
    [self.view addSubview:self.popView];
    self.popView.frame = CGRectMake(220, 100, 100, 100);
    
    self.popView = [[LYYPopView alloc] init];
    self.popView.backgroundColor = [UIColor blackColor];
    self.popView.popViewDirectionType = LYYPopViewDirectionTypeUp;
    [self.view addSubview:self.popView];
    self.popView.frame = CGRectMake(100, 220, 100, 100);
    
    self.popView = [[LYYPopView alloc] init];
    self.popView.backgroundColor = [UIColor blackColor];
    self.popView.popViewDirectionType = LYYPopViewDirectionTypeDown;
    self.popView.frame = CGRectMake(220, 220, 100, 100);
    [self.view addSubview:self.popView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

- (IBAction)clickAction:(id)sender {
    if ([self.popView isShowing]) {
        [self.popView hideWithAnimated:YES completion:nil];
    }else {
        [self.popView showWithAnimated:YES completion:^(BOOL finished) {
            
        }];
    }
   
}
@end
