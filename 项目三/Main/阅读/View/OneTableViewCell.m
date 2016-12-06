//
//  OneTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/8.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "OneTableViewCell.h"

@implementation OneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        头像
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imageview.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imageview];
        //        作者
        _auter = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, 17, 0, 15)];
        _auter.font = [UIFont systemFontOfSize:15];
        _auter.textColor = [UIColor cyanColor];
        _auter.text = @"作者";
        [_auter sizeToFit];
        [self.contentView addSubview:_auter];
        //        日期
        _datatime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, CGRectGetMaxY(_auter.frame), 0, 30)];
        _datatime.numberOfLines = 0;
        _datatime.font = [UIFont systemFontOfSize:15];
        _datatime.textColor = [UIColor lightGrayColor];
        _datatime.text = @"滞销书作者，不知名编剧";
        [_datatime sizeToFit];
        [self.contentView addSubview:_datatime];
        _weiboname = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, CGRectGetMaxY(_datatime.frame), 0, 15)];
        _datatime.font = [UIFont systemFontOfSize:15];
        _datatime.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_weiboname];
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
