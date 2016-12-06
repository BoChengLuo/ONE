//
//  MusicOneTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/8.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MusicOneTableViewCell.h"

@implementation MusicOneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, -35, KscreenWidth, KscreenHeight/2 - 50)];
        _webview.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_webview];
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, -35, KscreenWidth, KscreenHeight/2 - 50)];
        _view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_view];
        _acwebview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _acwebview.frame = CGRectMake(0, 0, 100, 100);
        _acwebview.center = _view.center;
        [_view addSubview:_acwebview];
        //        标题
        _list = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_webview.frame), KscreenWidth - 10, 0)];
//        CGRect frame1 = list.frame;
        _list.numberOfLines = 0;
        _list.font = [UIFont systemFontOfSize:20];
        _list.textColor = [UIColor blackColor];
        [self.contentView addSubview:_list];
//        //        作者
        _auter = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_webview.frame) + 72, 0, 12)];
        _auter.font = [UIFont systemFontOfSize:12];
        _auter.textColor = [UIColor cyanColor];
        [self.contentView addSubview:_auter];
        //        正文
        _text = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_auter.frame) + 10, KscreenWidth - 20, 0)];
        _text.font = [UIFont systemFontOfSize:18];
        _text.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_text];
        //        编辑
        _editor = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 0, 12)];
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
