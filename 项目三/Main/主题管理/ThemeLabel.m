//
//  ThemeLabel.m
//  项目三
//
//  Created by wxhl on 16/12/5.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(corloAction:) name:kThemeChangedNotificationName object:nil];
    }
    return self;
}
-(void)corloAction:(NSNotification *)text{
    NSInteger I = [text.userInfo[@"textone"] integerValue];
    if (I == 0) {
        self.textColor = [UIColor lightGrayColor];
    }else if (I == 1){
    self.textColor = [UIColor whiteColor];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
