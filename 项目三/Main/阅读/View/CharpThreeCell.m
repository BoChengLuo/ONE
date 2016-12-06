//
//  CharpThreeCell.m
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "CharpThreeCell.h"

@implementation CharpThreeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 20)];
        _list.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_list];
        //        作者
        _auther = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_list.frame) + 5, 0, 15)];
        _auther.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_auther];
        //    右边label
        _rightlabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth - 55, 5, 40, 20)];
        _rightlabel.text = @"短篇";
        _rightlabel.textAlignment = NSTextAlignmentCenter;
        _rightlabel.textColor = [UIColor cyanColor];
        _rightlabel.layer.borderColor = [UIColor cyanColor].CGColor;
        _rightlabel.layer.borderWidth = 1.0f;
        _rightlabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_rightlabel];
        //        正文
        _text = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_auther.frame) + 5, 0, 0)];
        CGRect frame = _text.frame;
        _text.font = [UIFont systemFontOfSize:15];
        _text.numberOfLines = 0;
        CGRect rect = [_text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        _text.frame = frame;
        [self.contentView addSubview:_text];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
