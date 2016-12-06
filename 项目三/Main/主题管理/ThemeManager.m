//
//  ThemeManager.m
//  项目三
//
//  Created by wxhl on 16/12/5.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager
-(void)notificationoff{
    NSDictionary * dic = @{@"textone":@"1"};
    NSNotification * notifacat = [NSNotification notificationWithName:kThemeChangedNotificationName object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notifacat];
}
-(void)notificationturn{
    NSDictionary * dic = @{@"textone":@"0"};
    NSNotification * notifacat = [NSNotification notificationWithName:kThemeChangedNotificationName object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notifacat];
}

@end
