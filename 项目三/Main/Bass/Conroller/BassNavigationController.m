//
//  BassNavigationController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BassNavigationController.h"

@interface BassNavigationController ()
{
    ThemtView *view;
}
@end

@implementation BassNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bgviewAction:) name:kThemeChangedNotificationName object:nil];
    // Do any additional setup after loading the view.
}
-(void)bgviewAction:(NSNotification *)text{
    NSInteger noti = [text.userInfo[@"textone"] integerValue];
    if (noti == 1) {
        [self.navigationBar setBackgroundColor:[UIColor lightGrayColor]];
    }else if (noti == 0){
        [self.navigationBar setBackgroundColor:[UIColor whiteColor]];
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
