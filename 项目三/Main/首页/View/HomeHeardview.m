//
//  HomeHeardview.m
//  项目三
//
//  Created by wxhl on 16/11/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomeHeardview.h"

@implementation HomeHeardview
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //    头视图
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 100)];
        //    内容视图
        _view = [[UIView alloc]initWithFrame:CGRectMake(10, 30, KscreenWidth - 20, KscreenWidth -20)];
        _view.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_view];
        _view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _view.layer.shadowOffset = CGSizeMake(0, 1);
        _view.layer.shadowOpacity = .7;
        _view.layer.shadowRadius = 2;
        //    图片视图
        _iamgevew = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, KscreenWidth- 30, 240)];
        [_view addSubview:_iamgevew];
        //    左边第一个lable
        _countlable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_iamgevew.frame), 0, 15)];
        [_view addSubview:_countlable];
        _countlable.font = [UIFont systemFontOfSize:12];
        _countlable.textAlignment = NSTextAlignmentCenter;
        _countlable.alpha = .6;
        [_countlable sizeToFit];
        //    右边第一个lable
        _auterlable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_iamgevew.frame), 0, 15)];
        [_view addSubview:_auterlable];
        _auterlable.font = [UIFont systemFontOfSize:12];
        _auterlable.textAlignment = NSTextAlignmentRight;
        _auterlable.alpha = .6;
        _auterlable.text = @"作者姓名";
        [_auterlable sizeToFit];
        NSDictionary *dic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:12]
                              };
        CGRect rect = [_auterlable.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesFontLeading attributes:dic context:nil];
        CGRect frame2 = _auterlable.frame;
        frame2.origin.x = _view.bounds.size.width - rect.size.width;
        _auterlable.frame = frame2;
        //    内容label
        _textlable = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(_auterlable.frame) + 5, 0, 0)];

        [_view addSubview:_textlable];
//        [_textlable sizeToFit];
        CGRect rect2 = [_textlable.text boundingRectWithSize:CGSizeMake(KscreenWidth - 16, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
        //    NSLog(@"%f",rect2.size.width);
        CGRect frame3 = _textlable.frame;
        frame3.size.height = rect2.size.height;
        frame3.size.width = rect2.size.width;
        _textlable.frame = frame3;
        //    时间
        _timelable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textlable.frame) + 5 + rect2.size.height, 0, 15)];
        _timelable.textAlignment = NSTextAlignmentRight;
        [_view addSubview:_timelable];
        CGRect frame = self.frame;

        frame.size.height = 40+250 + 15 + 30 +5 + 15 + 5;
        self.frame = frame;
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
