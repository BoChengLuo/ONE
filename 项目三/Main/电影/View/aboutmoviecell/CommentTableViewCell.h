//
//  CommentTableViewCell.h
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property(strong,nonatomic) UIImageView *imageview;
@property(strong,nonatomic) UILabel *auter;
@property(strong,nonatomic) UILabel *datatime;
@property(strong,nonatomic) UIImageView *listenbut;
@property(strong,nonatomic) ThemeLabel *listen;
@property(strong,nonatomic) UILabel *score;
@property(strong,nonatomic) ThemeLabel *list;

@end
