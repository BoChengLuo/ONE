//
//  ReadCell.m
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ReadCell.h"

@implementation ReadCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //    右边label
        _rightlabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth - 55, 10, 40, 20)];
        _rightlabel.textAlignment = NSTextAlignmentCenter;
        _rightlabel.textColor = [UIColor cyanColor];
        _rightlabel.layer.borderColor = [UIColor cyanColor].CGColor;
        _rightlabel.layer.borderWidth = 1.0f;
        _rightlabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_rightlabel];
        //    标题
        _heading = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 0, 0)];
        [self.contentView addSubview:_heading];
        _heading.font = [UIFont systemFontOfSize:18];

        _heading.numberOfLines = 0;
        CGRect rect = [_heading.text boundingRectWithSize:CGSizeMake(CGRectGetMinX(_rightlabel.frame) - 20, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];

        //    作者
        _auther = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + rect.size.height, 0, 15)];
        _auther.font = [UIFont systemFontOfSize:13];

        [_auther sizeToFit];
        [self.contentView addSubview:_auther];
        //    内容
        _textlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30 + rect.size.height, 0, 0)];
        _textlabel.font = [UIFont systemFontOfSize:15];
        _textlabel.numberOfLines = 0;

        [self.contentView addSubview:_textlabel];
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
