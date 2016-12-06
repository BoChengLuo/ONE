//
//  MusicZeroTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/8.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MusicZeroTableViewCell.h"

@implementation MusicZeroTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight/2)];
        _imageview.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_imageview];
        _view = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_imageview.frame) - 20, KscreenWidth - 30, 100)];
        _view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _view.layer.shadowOffset = CGSizeMake(0, 1);
        _view.layer.shadowOpacity = .7;
        _view.layer.shadowRadius = 2;
        _view.backgroundColor = [UIColor whiteColor];
        //        头像
        _heardview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _heardview.layer.cornerRadius = 25;
        _heardview.backgroundColor = [UIColor yellowColor];
        [_view addSubview:_heardview];
        //        作者
        _auter = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_heardview.frame) + 5, 17, 0, 12)];
        _auter.font = [UIFont systemFontOfSize:12];
        _auter.textColor = [UIColor cyanColor];
        _auter.text = @"作者";
        [_auter sizeToFit];
        [_view addSubview:_auter];
        //        作者介绍
        _abaut = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_heardview.frame) + 5, CGRectGetMaxY(_auter.frame), 0, 12)];
        _abaut.font = [UIFont systemFontOfSize:12];
        _abaut.textColor = [UIColor lightGrayColor];
        _abaut.alpha = .7;
        _abaut.text = @"某知名作曲家";
        [_abaut sizeToFit];
        [_view addSubview:_abaut];
//        日期
        _datatime = [[UILabel alloc]initWithFrame:CGRectMake(_view.frame.size.width/4 * 3 -5, 50,_view.bounds.size.width/4 , 0)];
        _datatime.font = [UIFont systemFontOfSize:12];
        _datatime.text = @"Nov.07.2016";
        [_datatime sizeToFit];
        [_view addSubview:_datatime];
        
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_heardview.frame) + 10, 0, 40)];
        _list.font = [UIFont systemFontOfSize:20];
        _list.textColor = [UIColor blackColor];
        _list.text = @"标题";
        [_list sizeToFit];
        [_view addSubview:_list];
        [self.contentView addSubview:_view];
//        音乐故事lable
        _muslable = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_view.frame) + 25, 0, 0)];
        _muslable.font = [UIFont systemFontOfSize:15];
        _muslable.textColor = [UIColor grayColor];
        _muslable.text = @"音乐故事";
        [_muslable sizeToFit];
        [self.contentView addSubview:_muslable];
//        button
        _text = [ThemeButton buttonWithType:UIButtonTypeCustom];
        _text.frame = CGRectMake(KscreenWidth - 135, CGRectGetMaxY(_view.frame) + 20, 40, 30);
        [_text setTitle:@"故事" forState:UIControlStateNormal];
        [_text setBackgroundColor:[UIColor cyanColor]];
        [self.contentView addSubview:_text];
        _lyrics = [ThemeButton buttonWithType:UIButtonTypeCustom];
        [_lyrics setTitle:@"歌词" forState:UIControlStateNormal];
        _lyrics.frame = CGRectMake(KscreenWidth - 90, CGRectGetMaxY(_view.frame) + 20, 40, 30);
        [_lyrics setBackgroundColor:[UIColor cyanColor]];
        [self.contentView addSubview:_lyrics];
        _mation = [ThemeButton buttonWithType:UIButtonTypeCustom];
        [_mation setTitle:@"介绍" forState:UIControlStateNormal];
        _mation.frame = CGRectMake(KscreenWidth - 45, CGRectGetMaxY(_view.frame) + 20, 40, 30);
        [_mation setBackgroundColor:[UIColor cyanColor]];
        [self.contentView addSubview:_mation];
        
    }
    return self;
}
-(CGFloat)cellheight{
    return KscreenHeight/2 + 180;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
