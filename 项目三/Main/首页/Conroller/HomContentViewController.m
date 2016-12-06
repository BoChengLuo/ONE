//
//  HomContentViewController.m
//  项目三
//
//  Created by wxhl on 16/11/24.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomContentViewController.h"
#import "HomeHeardview.h"
#import "HomeToolview.h"
#import "HomeModel.h"

@interface HomContentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    UIView *_view;
    HomeHeardview *_heardview;
    HomeToolview *_tooleview;
    
}

@end

@implementation HomContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self creatToolview];
    // Do any additional setup after loading the view.
}
#pragma mark-------------toolview--------------
-(void)creatToolview{
    _tooleview = [[HomeToolview alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_heardview.frame), KscreenWidth, 80)];
    _tooleview.backgroundColor = [UIColor clearColor];
    //    _tooleview.hidden = YES;
    
    
}
#pragma mark------------------tableview------------------
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource =self;
    _tableview.delegate = self;
    _tableview.showsVerticalScrollIndicator = NO;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cel"];
    [self.view addSubview:_tableview];
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
    HomeModel *model = self.arry[_number];
    //    编号
    _heardview.countlable.text = model.hp_title;
    [_heardview.countlable sizeToFit];
    //    内容
    _heardview.textlable.numberOfLines = 0;
    _heardview.textlable.text = model.hp_content;
    CGRect rect2 = [_heardview.textlable.text boundingRectWithSize:CGSizeMake(KscreenWidth - 30 , 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    _heardview.height = rect2.size.height;
    CGRect frame1 = _heardview.textlable.frame;
    frame1.size.width = rect2.size.width;
    frame1.size.height = rect2.size.height;
    _heardview.textlable.frame = frame1;
    [_heardview.textlable sizeToFit];
    //    内容视图
    CGRect frame = _heardview.view.frame;
    frame.size.height = 290 + rect2.size.height;
    _heardview.view.frame = frame;
    //    头视图
    CGRect frame5 = _heardview.frame;
    frame5.size.height = _heardview.view.frame.size.height + 30;
    _tableview.sectionHeaderHeight = _heardview.view.frame.size.height + 64;
    _heardview.frame = frame5;
    //    时间
    _heardview.timelable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_heardview.auterlable.frame) + 5 + rect2.size.height, 0, 15)];
    _heardview.timelable.textAlignment = NSTextAlignmentRight;
    [_heardview.view addSubview:_heardview.timelable];
    _heardview.timelable.alpha = .6;
    _heardview.timelable.textAlignment = NSTextAlignmentRight;
    _heardview.timelable.font = [UIFont systemFontOfSize:12];
    NSString *string = model.hp_makettime;
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateformat dateFromString:string];
    [dateformat setDateFormat:@"dd MMM.yyyy"];
    NSString *time = [dateformat stringFromDate:date];
    _heardview.timelable.text = time;
    [_heardview.timelable sizeToFit];
    CGRect rect3 = [_heardview.timelable.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    CGRect frame4 = _heardview.timelable.frame;
    frame4.size.width = rect3.size.width;
    //    NSLog(@"%f",rect3.size.height);
    frame4.size.height = rect3.size.height;
    frame4.origin.x = _heardview.view.bounds.size.width - rect3.size.width;
    _heardview.timelable.frame = frame4;
    //    作者
    _heardview.auterlable.text = model.hp_author;
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:12]
                          };
    
    CGRect rect1 = [_heardview.auterlable.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGRect frame2 = _heardview.auterlable.frame;
    frame2.size.width = rect1.size.width;
    frame2.origin.x = _heardview.view.bounds.size.width - rect1.size.width;
    //    frame2.size.width = rect.size.width;
    //    NSLog(@"%f",rect.size.width);
    _heardview.auterlable.frame = frame2;
    
    
    //    [_tableview reloadData];
    //    加载图片视图
    NSURL *url = [NSURL URLWithString:model.hp_img_original_url];
    [_heardview.iamgevew setImageWithURL:url];
    _tooleview.actionlabel.text = [NSString stringWithFormat:@"%@",model.praisenum];
    NSLog(@"%@",model.praisenum);
    [_tooleview.actionlabel sizeToFit];
    CGRect rect = [_tooleview.actionlabel.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    CGRect frame3 = _tooleview.actionlabel.frame;
    frame3.origin.x = KscreenWidth - 40 - 15 - rect.size.width - 15;
    frame3.origin.y = 48;
    _tooleview.actionlabel.frame = frame3;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_heardview.view.frame), KscreenWidth, 80)];
    _view.backgroundColor = [UIColor clearColor];
    //    图书标记
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
    imageview.backgroundColor = [UIColor greenColor];
    [_view addSubview:imageview];
    //    左边标记
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+5, 33, 0, 0)];
    [_view addSubview:label];
    label.alpha = .6;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"小记";
    [label sizeToFit];
    //    转发标记
    UIImageView *turnimage = [[UIImageView alloc]initWithFrame:CGRectMake(KscreenWidth - 40 - 15, 20, 40, 40)];
    turnimage.backgroundColor = [UIColor cyanColor];
    [_view addSubview:turnimage];
    //    右边标记
    UILabel *actionlabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [_view addSubview:actionlabel];
    actionlabel.alpha = .6;
    actionlabel.font = [UIFont systemFontOfSize:12];
    actionlabel.textAlignment = NSTextAlignmentCenter;
    actionlabel.text = _tooleview.actionlabel.text;
    [actionlabel sizeToFit];
    CGRect rect = [actionlabel.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    CGRect frame = actionlabel.frame;
    frame.origin.x = KscreenWidth - 40 - 15 - rect.size.width - 15;
    frame.origin.y = 33;
    actionlabel.frame = frame;
    //    爱心标记
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(actionlabel.frame) - 40 - 10 -40, 20, 40, 40)];
    image.backgroundColor = [UIColor cyanColor];
    [_view addSubview:image];
    [_heardview addSubview:_view];
    _view.hidden = YES;
    if (_heardview.view.frame.size.height > (KscreenHeight - 120 - 64 )) {
        _view.hidden = NO;
        _tooleview.hidden = YES;
    }
    return _tooleview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
