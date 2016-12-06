//
//  TextTableViewCell.h
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell
@property(strong,nonatomic) UIWebView *text;
@property(strong,nonatomic) UIImageView *imageview;
@property(strong,nonatomic) UILabel *auter;
@property(strong,nonatomic) UILabel *datatime;
@property(strong,nonatomic) UILabel *list;
@end
