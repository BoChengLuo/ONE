//
//  MoreCell.m
//  项目三
//
//  Created by wxhl on 16/12/5.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MoreCell.h"

@implementation MoreCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cachelable = [[ThemeLabel alloc]initWithFrame:CGRectMake(KscreenWidth/4 * 3, 5, 100, 50)];
        [self.contentView addSubview:_cachelable];
        _swich = [[UISwitch alloc]initWithFrame:CGRectMake(KscreenWidth - 70, 10, 70, 50)];
        [self.contentView addSubview:_swich];
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
