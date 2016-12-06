//
//  ListMusicViewController.m
//  项目三
//
//  Created by wxhl on 16/11/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ListMusicViewController.h"
#import "ListTextViewController.h"

@interface ListMusicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *datarray;
    NSInteger index;
}

@end

@implementation ListMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self achieveDate];
    self.title = @"往期列表";
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableview.separatorColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"本月";
    }else{
    cell.textLabel.text = datarray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTextViewController *contr = [[ListTextViewController alloc]init];
    contr.hidesBottomBarWhenPushed = YES;
    contr.array = [datarray copy];
    contr.index = indexPath.row;
    contr.title = datarray[indexPath.row];
    [self.navigationController pushViewController:contr animated:YES];
}
#pragma mark------------nsdate
-(void)achieveDate{
    datarray = [NSMutableArray array];
    NSDate * date = [NSDate date];
    NSDateFormatter * dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"MM"];
    NSInteger x = [[dateformat stringFromDate:date]integerValue];
    NSLog(@"%ld",x);
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc]init];
    for (int i = 0; i < x; i++) {
        [adcomps setYear:0];
        [adcomps setMonth:-i];
        [adcomps setDay:0];
        NSDate *newdate = [calender dateByAddingComponents:adcomps toDate:date options:0];
        [dateformat setDateFormat:@"MMM.yyyy"];
        NSString *befordate = [dateformat stringFromDate:newdate];
        [datarray addObject:befordate];
    }
    [_tableview reloadData];

    
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
