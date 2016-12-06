//
//  MusicZeroTableViewCell.h
//  项目三
//
//  Created by wxhl on 16/11/8.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicZeroTableViewCell : UITableViewCell
@property(assign,nonatomic)CGFloat cellheight;
@property(strong,nonatomic) UIImageView *imageview;
@property(strong,nonatomic) UIView *view ;
@property(strong,nonatomic) UIImageView *heardview;
@property(strong,nonatomic) UILabel *auter;
@property(strong,nonatomic) UILabel *abaut;
@property(strong,nonatomic) UILabel *datatime;
@property (strong,nonatomic) UILabel *list;
@property (strong,nonatomic) UILabel *muslable;
@property(strong,nonatomic) ThemeButton *text;
@property(strong,nonatomic) ThemeButton *lyrics;
@property(strong,nonatomic) ThemeButton *mation;

@end
