//
//  HomeCell.m
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomeCell.h"
#import "HomeHeardview.h"
#import "HomeToolview.h"

@implementation HomeCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatTableview];
        [self.contentView addSubview:_tableview];
        [self creatToolview];

        [self.contentView addSubview:_tooleview];
    }
    return self;
}
#pragma mark-------------toolview--------------
-(void)creatToolview{
    _tooleview = [[HomeToolview alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_heardview.frame), KscreenWidth, 80)];
    _tooleview.backgroundColor = [UIColor clearColor];
    
}
#pragma mark------------------tableview------------------
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 108) style:UITableViewStylePlain];
    _tableview.dataSource =self;
    _tableview.delegate = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.backgroundColor = [UIColor clearColor];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cel"];
    //    头视图
    _heardview = [[HomeHeardview alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 100)];
    
    _tableview.tableHeaderView = _heardview;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cel" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_heardview.view.frame), KscreenWidth, 80)];
    _view.backgroundColor = [UIColor clearColor];
    //    图书标记
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
    imageview.image = [UIImage imageNamed:@"more_icon_draft@2x"];
    [_view addSubview:imageview];
    //    左边标记
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+5, 33, 0, 0)];
    [_view addSubview:label];
    label.alpha = .6;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"小记";
    [label sizeToFit];
    //    右边标记
    UILabel *actionlabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [_view addSubview:actionlabel];
    actionlabel.alpha = .6;
    actionlabel.font = [UIFont systemFontOfSize:12];
    actionlabel.textAlignment = NSTextAlignmentCenter;
    actionlabel.text = _tooleview.actionlabel.text;
    [actionlabel sizeToFit];
    CGRect frame = actionlabel.frame;
    frame.origin.x = KscreenWidth- 15  - 15 - 30;
    frame.origin.y = 33;
    actionlabel.frame = frame;
    //    爱心标记
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(actionlabel.frame) -40 - 10 -40, 20, 40, 40)];
    image.image = [UIImage imageNamed:@"detail_button_fav@2x"];
    [_view addSubview:image];
    [_heardview addSubview:_view];
    _view.hidden = YES;
    return _tooleview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
