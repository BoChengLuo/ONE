//
//  CommentTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

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
        //        点赞按钮
        _listenbut = [[UIImageView alloc]initWithFrame:CGRectMake(KscreenWidth - 50, 17, 20, 20)];
        _listenbut.image = [UIImage imageNamed:@"detail_button_fav@2x"];;
        [self.contentView addSubview:_listenbut];
        
        //        点赞人数lable
        _listen = [[ThemeLabel alloc]initWithFrame:CGRectMake(KscreenWidth - 30, 20, 25, 15)];
        _listen.font = [UIFont systemFontOfSize:10];
        _listen.textColor = [UIColor lightGrayColor];
        _listen.alpha = .6;
        _listen.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_listen];
//        评分
        _score = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_listenbut.frame) - 30, 17, 30, 20)];
        _score.textColor = [UIColor redColor];
        NSArray *arry = [UIFont familyNames];
        _score.font = [UIFont fontWithName:arry[11] size:15];
        [self.contentView addSubview:_score];
        //        评论
        _list = [[ThemeLabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageview.frame) + 20, 0, 25)];
        _list.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_list];
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
