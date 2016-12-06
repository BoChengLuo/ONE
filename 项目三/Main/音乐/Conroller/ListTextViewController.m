//
//  ListTextViewController.m
//  项目三
//
//  Created by wxhl on 16/11/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ListTextViewController.h"
#import "MusicTextViewController.h"
#import "MusicModel.h"

@interface ListTextViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *listarray;
}

@end

@implementation ListTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self requestData];
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource =self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    MusicModel *model;
    if (listarray.count > 0) {
        model = listarray[indexPath.row];
    }
    cell.detailTextLabel.text = model.title;
    cell.textLabel.text = model.user_name;
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.imageView setImageWithURL:url];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicTextViewController *contr = [[MusicTextViewController alloc]init];
    contr.hidesBottomBarWhenPushed = YES;
    MusicModel *model = listarray[indexPath.row];
    contr.music_id = model.music_id;
    [self.navigationController pushViewController:contr animated:YES];
}
#pragma mark-----------request
-(void)requestData{
    listarray = [NSMutableArray array];
    NSString *listring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/music/bymonth/%@?version=v3.5.3&platform=ios&user_id=",self.array[self.index]];
    NSString *string = [listring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arry = responseObject[@"data"];
        for (NSDictionary *dic in arry) {
            MusicModel *model = [[MusicModel alloc]init];
            model.cover = dic[@"cover"];
            model.title = dic[@"title"];
            model.music_id = dic[@"id"];
            NSDictionary *author = dic[@"author"];
            model.user_name = author[@"user_name"];
            [listarray addObject:model];
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
