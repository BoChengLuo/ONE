//
//  DataViewController.h
//  项目三
//
//  Created by wxhl on 16/11/5.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BassViewController.h"

@interface DataViewController : BassViewController
@property(copy,nonatomic) NSString *conten_id;
@property(strong,nonatomic) NSArray *arry;
@property(assign,nonatomic) NSInteger index;
@property(assign,nonatomic) NSInteger choice;

@end
