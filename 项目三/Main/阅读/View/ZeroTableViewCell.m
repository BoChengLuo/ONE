//
//  ZeroTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/8.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ZeroTableViewCell.h"

@implementation ZeroTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        头像
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imageview.layer.cornerRadius = 25;
        _imageview.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imageview];
        //        作者
        _auter = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, 17, 0, 12)];
        _auter.font = [UIFont systemFontOfSize:12];
        _auter.textColor = [UIColor cyanColor];
        [self.contentView addSubview:_auter];
        //        日期
        _datatime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, CGRectGetMaxY(_auter.frame), 0, 12)];
        _datatime.font = [UIFont systemFontOfSize:12];
        _datatime.textColor = [UIColor lightGrayColor];
        _datatime.alpha = .7;
        [self.contentView addSubview:_datatime];
        //        收听按钮
        _listenbut = [UIButton buttonWithType:UIButtonTypeCustom];
        _listenbut.frame = CGRectMake(KscreenWidth - 55, 17, 20, 20);
        _listenbut.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_listenbut];
        
        //        收听lable
        _listen = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth - 30, 20, 20, 10)];
        _listen.font = [UIFont systemFontOfSize:8];
        _listen.textColor = [UIColor lightGrayColor];
        _listen.alpha = .6;
        _listen.text = @"收听";
        [_listen sizeToFit];
        _listen.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_listen];
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageview.frame) + 30, 0, 40)];
        _list.font = [UIFont systemFontOfSize:20];
        _list.textColor = [UIColor blackColor];
        [self.contentView addSubview:_list];
        //        正文
        _text = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_list.frame) + 20, 0, 0)];
//        CGRect frame = _text.frame;
        _text.font = [UIFont systemFontOfSize:18];
        CGRect rect = [_text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
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
