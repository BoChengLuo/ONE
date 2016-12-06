//
//  HomeCell.h
//  项目三
//
//  Created by wxhl on 16/11/26.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeHeardview;
@class HomeToolview;

@interface HomeCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) UITableView *tableview;
@property(strong,nonatomic) UIView *view;
@property(strong,nonatomic) HomeHeardview *heardview;
@property(strong,nonatomic) HomeToolview *tooleview;

@end
