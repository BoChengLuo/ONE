//
//  PhotoCell.m
//  项目三
//
//  Created by wxhl on 16/11/24.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, (KscreenWidth - 10)/2 - 5, (KscreenWidth - 10)/2 -40)];
        _imageview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageview];
        _countlable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageview.frame) - 13, _imageview.frame.size.width/2 - 5, 13)];
        _countlable.text = @"vol.1425";
        _countlable.font = [UIFont systemFontOfSize:13];
        _countlable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_countlable];
        _timelable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_countlable.frame), CGRectGetMaxY(_imageview.frame) - 13, _imageview.frame.size.width/2, 13)];
        _timelable.text = @"2016/11/24/7";
        _timelable.font = [UIFont systemFontOfSize:13];
        _timelable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timelable];
        _textlable = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(_imageview.frame), _imageview.frame.size.width - 6, self.contentView.bounds.size.height - _imageview.frame.size.height)];
        _textlable.font = [UIFont systemFontOfSize:15];
        _textlable.numberOfLines = 0;
//        _textlable.text = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
        [self.contentView addSubview:_textlable];
        
    }
    return self;
}

@end
