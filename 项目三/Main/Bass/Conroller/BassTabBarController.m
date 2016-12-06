//
//  BassTabBarController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BassTabBarController.h"

@interface BassTabBarController ()
{
    ThemtView * _bgview;
    UIButton * _button;
    NSMutableArray * buttoarray;
}

@end

@implementation BassTabBarController
-(instancetype)init{
    self = [super init];
    if (self) {
        NSArray *controllers = @[
                                 @"Home",
                                 @"Read",
                                 @"Music",
                                 @"Movie",
                                 @"More",
                                 ];
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *string in controllers) {
            UIStoryboard *storyboad = [UIStoryboard storyboardWithName:string bundle:[NSBundle mainBundle]];
            UIViewController *naviegation = [storyboad instantiateInitialViewController];
            [array addObject:naviegation];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titlecolorAction:) name:kThemeChangedNotificationName object:nil];
        self.viewControllers = array;
    }
    [self creatControllers];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    for (UIView * tablebarbut in self.tabBar.subviews) {
        Class buttonclass = NSClassFromString(@"UITabBarButton");
        if ([tablebarbut isKindOfClass:buttonclass]) {
            [tablebarbut removeFromSuperview];
        }
    }
}
-(void)creatControllers{
    buttoarray = [NSMutableArray array];
    NSArray * imagArray = @[@"group_btn_all_on@2x",@"timeline_item_pic_icon@2x",@"group_btn_music_on@2x",@"group_btn_video_on_title@2x",@"group_btn_all_on_title@2x"];
    NSArray * titleArray = @[@"首页",@"阅读",@"音乐",@"电影",@"更多"];
    CGFloat buttonWiht = KscreenWidth/5;
    for (int i = 0; i < 5; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = button;
        button.frame = CGRectMake(i * buttonWiht, 0, buttonWiht, 49);
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(buttonWiht/2, -buttonWiht/2, 5, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(-15, buttonWiht/8, 0,0);
        [button setImage:[UIImage imageNamed:imagArray[i]] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        [self.tabBar addSubview:button];
        button.tag = 400 + i;
        [button addTarget:self action:@selector(tabarBattonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttoarray addObject:button];
    }
    _bgview = [[ThemtView alloc]initWithFrame:CGRectMake(0, -7, KscreenWidth, 56)];
    [self.tabBar insertSubview:_bgview atIndex:0];

}
-(void)titlecolorAction:(NSNotification *)text{
    NSInteger noti = [text.userInfo[@"textone"] integerValue];
    if (noti == 1) {
        for (_button in buttoarray) {
            
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }else if (noti == 0){
        for (_button in buttoarray) {
            
            [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
}
-(void)tabarBattonAction:(UIButton *)sender{
    NSInteger tag = sender.tag - 400;
    if (tag >= 0 && tag < self.viewControllers.count) {
        self.selectedIndex = tag;
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
