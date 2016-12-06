//
//  CharpTwoCell.m
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "CharpTwoCell.h"

@implementation CharpTwoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        头像
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imageview.layer.cornerRadius = 25;
        _imageview.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imageview];
        //        作者
        _auter = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, 17, 0, 15)];
        _auter.font = [UIFont systemFontOfSize:15];
        _auter.textColor = [UIColor cyanColor];
        [self.contentView addSubview:_auter];
        //        日期
        _datatime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame) + 5, CGRectGetMaxY(_auter.frame), 0, 15)];
        _datatime.font = [UIFont systemFontOfSize:15];
        _datatime.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_datatime];
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
