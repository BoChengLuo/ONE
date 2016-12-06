//
//  HeardTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HeardTableViewCell.h"

@implementation HeardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imagview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
        [self.contentView addSubview:_imagview];
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
