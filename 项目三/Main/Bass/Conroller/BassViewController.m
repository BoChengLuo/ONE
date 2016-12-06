//
//  BassViewController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BassViewController.h"

@interface BassViewController ()

@end

@implementation BassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bgAction:) name:kThemeChangedNotificationName object:nil];
    // Do any additional setup after loading the view.
}
-(void)bgAction:(NSNotification *)text{
    NSInteger I = [text.userInfo[@"textone"] integerValue];
    if (I == 0) {
        
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (I == 1){
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
