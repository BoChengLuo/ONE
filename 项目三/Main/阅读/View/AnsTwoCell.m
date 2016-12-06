//
//  AnsTwoCell.m
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AnsTwoCell.h"

@implementation AnsTwoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 40)];
        _list.font = [UIFont systemFontOfSize:20];
        _list.textColor = [UIColor blackColor];
        _list.numberOfLines = 0;
        [self.contentView addSubview:_list];

        //        日期
        _datatime = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/4 * 3, 15, 0, 12)];
        _datatime.font = [UIFont systemFontOfSize:12];
        _datatime.textColor = [UIColor lightGrayColor];
        _datatime.alpha = .7;
        [self.contentView addSubview:_datatime];
        //        正文
        _text = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_list.frame) + 20, 0, 0)];
        CGRect frame = _text.frame;
        _text.font = [UIFont systemFontOfSize:18];
        CGRect rect = [_text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        _text.frame = frame;
        [self.contentView addSubview:_text];
        //        编辑
        _editor = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_list.frame) + 40 + rect.size.height, 0, 12)];
        _editor.font = [UIFont systemFontOfSize:12];
        _editor.textColor = [UIColor lightGrayColor];
        _editor.alpha = .7;
        [self.contentView addSubview:_editor];

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
