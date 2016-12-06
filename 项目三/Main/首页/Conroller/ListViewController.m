//
//  ListViewController.m
//  项目三
//
//  Created by wxhl on 16/10/29.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ListViewController.h"
#import "PhotoViewController.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_arry;
    UITableView *_tabelview;
}

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"往期列表";
    [self achieveDate];
    [self creatTableview];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(ButtonAction)];
    self.navigationItem.leftBarButtonItem = item;
//    UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"返回"];
// Do any additional setup after loading the view.
}
-(void)ButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTableview{
    _tabelview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tabelview];
    //    tabelview.sectionHeaderHeight = 0;
    [_tabelview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tabelview.dataSource = self;
    _tabelview.delegate = self;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor cyanColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"本月";
    }else{
    cell.textLabel.text = _arry[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoViewController *photo = [[PhotoViewController alloc]init];
    photo.selected = indexPath.row;
    photo.arry = [_arry copy];
    photo.title = _arry[indexPath.row];
    photo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photo animated:YES];
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
                [_tabelview reloadData];
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
