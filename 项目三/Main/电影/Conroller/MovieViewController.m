//
//  MovieViewController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "AboutMoViewController.h"
#import "MovieModel.h"
#import "WXRefresh.h"

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *moviearray;
    UIView *_bgview;
    UIActivityIndicatorView *_actview;
}

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cretaTableview];
    [self requestdata];
    // Do any additional setup after loading the view.
}
-(void)cretaTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    _bgview = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];
    _actview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actview.frame = CGRectMake(0, 0, 100, 100);
    _actview.center = _bgview.center;
    [_bgview addSubview:_actview];
    [_actview startAnimating];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return moviearray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MovieTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MovieModel *model;
    if (moviearray.count > 0) {
        model = moviearray[indexPath.row];
    }
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.imagview setImageWithURL:url];
//    cell.imagview.backgroundColor = [UIColor greenColor];
    cell.backgroundColor = [UIColor colorWithRed:.2 * indexPath.row green:.05 * indexPath.row blue:.05 *indexPath.row alpha:1];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KscreenHeight/4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AboutMoViewController *contr = [[AboutMoViewController alloc]init];
    contr.hidesBottomBarWhenPushed = YES;
    MovieModel *modle = moviearray[indexPath.row];
    contr.conten_id = modle.conten_id;
    [self.navigationController pushViewController:contr animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---------requestData
-(void)requestdata{
    NSString *string = @"http://v3.wufazhuce.com:8000/api/movie/list/0?version=v3.5.3&platform=ios&user_id=";
    NSString *movie = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:movie parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        moviearray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            MovieModel * model = [[MovieModel alloc]init];
            model.cover = dic[@"cover"];
            model.conten_id = dic[@"id"];
            [moviearray addObject:model];
        }
        __weak MovieViewController *weakself = self;
        if (moviearray.count > 0) {
            [_tableview addPullDownRefreshBlock:^{
                [weakself requestdata];
            }];
            [_tableview addInfiniteScrollingWithActionHandler:^{
                [weakself requestMoredata];
            }];
        }
        [_tableview reloadData];
        [_tableview.pullToRefreshView stopAnimating];
        [_actview stopAnimating];
        _bgview.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _bgview.hidden = NO;
        [_actview stopAnimating];
    }];
}
-(void)requestMoredata{
    NSInteger count = moviearray.count;
    MovieModel *model = moviearray[count - 1];
    NSInteger conten_id = [model.conten_id integerValue];
    NSString *string = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/list/%ld?version=v3.5.3&platform=ios&user_id=",conten_id];
    NSString *url = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
            MovieModel * model = [[MovieModel alloc]init];
            model.cover = dic[@"cover"];
            model.conten_id = dic[@"id"];
            [moviearray addObject:model];
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [_tableview.infiniteScrollingView stopAnimating];
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
