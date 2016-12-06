//
//  TextTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

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
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageview.frame) + 30, 0, 40)];
        _list.font = [UIFont systemFontOfSize:20];
        _list.textColor = [UIColor blackColor];
        [self.contentView addSubview:_list];
        //        正文
        _text = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_list.frame) + 20, KscreenWidth,KscreenHeight)];
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
