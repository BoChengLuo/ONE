//
//  DateListViewController.m
//  项目三
//
//  Created by wxhl on 16/11/5.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "DateListViewController.h"
#import "ChoiceViewController.h"

@interface DateListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSInteger number;
    NSMutableArray *_arry;
//    选择不同页面
    NSInteger choise;
    UIImageView * imageview;
}

@end

@implementation DateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self achieveDate];
    [self creatTableview];
    [self creatHeardview];
    self.title = @"往期列表";
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    choise = 1;
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
}
-(void)creatHeardview{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 50)];
    view.backgroundColor = [UIColor clearColor];
    _tableview.tableHeaderView = view;
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,KscreenWidth/3, 50)];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.image = [UIImage imageNamed:@"more_icon_feedback@2x"];
    [view addSubview:imageview];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, KscreenWidth/3, 50);
    [button1 setTitle:@"短篇" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 101;
    [view addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(KscreenWidth/3, 0, KscreenWidth/3, 50);
    [button2 setTitle:@"连载" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 102;
    [view addSubview:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(KscreenWidth/3 * 2, 0, KscreenWidth/3, 50);
    [button3 setTitle:@"问题" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 103;
    [view addSubview:button3];
    
}
-(void)buttonAction:(UIButton *)sender{
    if (sender.tag == 101) {
        number = _arry.count;
        choise = 1;
        imageview.center = sender.center;
        [_tableview reloadData];
    }else if (sender.tag == 102){
        number = 11;
        choise = 2;
        imageview.center = sender.center;
        [_tableview reloadData];
    }else if (sender.tag == 103){
        number = _arry.count;
        choise = 3;
        imageview.center = sender.center;
        [_tableview reloadData];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return number;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"本月";
    }else{
    cell.textLabel.text = _arry[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoiceViewController *contr = [[ChoiceViewController alloc]init];
    if (choise == 1) {
        contr.choice = 1;
    }else if (choise == 2){
        contr.choice = 2;
    }else{
        contr.choice = 3;
    }
    contr.arry = [_arry copy];
    contr.index = indexPath.row;
    contr.title = _arry[indexPath.row];
    contr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contr animated:YES];
}
#pragma mark------------nsdate
-(void)achieveDate{
    _arry = [NSMutableArray array];
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    for (int j = 0; j < 5; j++) {
        
        for (int i =0; i < 12; i++) {
            [adcomps setYear:-j];
            
            [adcomps setMonth:-i];
            
            [adcomps setDay:0];
            NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
            [dateFormatter setDateFormat:@"MMM.yyyy"];
            NSString *beforDate = [dateFormatter stringFromDate:newdate];
            [_arry addObject:beforDate];
            if (_arry.count == 50) {
                number = _arry.count;
                [_tableview reloadData];
                return;
            }
        }
    }
    
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
