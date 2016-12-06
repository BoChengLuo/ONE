//
//  HomeToolview.m
//  项目三
//
//  Created by wxhl on 16/11/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomeToolview.h"

@implementation HomeToolview
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //    图书标记
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 35, 40, 40)];
        imageview.image = [UIImage imageNamed:@"more_icon_draft@2x"];
        [self addSubview:imageview];
        //    左边标记
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+5, 48, 0, 0)];
        [self addSubview:label];
        label.alpha = .6;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"小记";
        [label sizeToFit];

        //    右边标记
        _actionlabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:_actionlabel];
        _actionlabel.alpha = .6;
        _actionlabel.font = [UIFont systemFontOfSize:12];
        _actionlabel.textAlignment = NSTextAlignmentCenter;
//        _actionlabel.text = @"307729";
        [_actionlabel sizeToFit];
        CGRect rect = [_actionlabel.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
        CGRect frame = _actionlabel.frame;
        frame.origin.x = KscreenWidth - 40 - 15 - rect.size.width - 15;
        frame.origin.y = 48;
        _actionlabel.frame = frame;
        //    爱心标记
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_actionlabel.frame) - 40 - 10 - 40, 35, 40, 40)];
        image.image = [UIImage imageNamed:@"detail_button_fav@2x"];
        [self addSubview:image];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
