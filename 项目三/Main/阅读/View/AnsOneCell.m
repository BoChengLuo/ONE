//
//  AnsOneCell.m
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AnsOneCell.h"

@implementation AnsOneCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KscreenWidth, 60)];
        _list.font = [UIFont systemFontOfSize:18];
        _list.textColor = [UIColor blackColor];
        [self.contentView addSubview:_list];
        //        正文
        _text = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_list.frame) + 20, 0, 0)];
        CGRect frame = _text.frame;
        _text.font = [UIFont systemFontOfSize:18];
        _text.numberOfLines = 0;
        CGRect rect = [_text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
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
