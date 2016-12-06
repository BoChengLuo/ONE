//
//  PhotoViewController.m
//  项目三
//
//  Created by wxhl on 16/10/30.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "HomContentViewController.h"
#import "HomeModel.h"

@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_datarry;
    UICollectionView *_collection;
    NSInteger _number;
}

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    [self creatCollectionview];
    // Do any additional setup after loading the view.
}
-(void)creatCollectionview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.backgroundColor = [UIColor clearColor];
    [_collection registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
    //    NSLog(@"%lf",layout.minimumLineSpacing);
    [self.view addSubview:_collection];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _number;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    HomeModel *model = _datarry[indexPath.item];
    cell.backgroundColor = [UIColor clearColor];
    cell.textlable.text = model.hp_content;
    NSURL *url = [NSURL URLWithString:model.hp_img_original_url];
    [cell.imageview setImageWithURL:url];
    cell.countlable.text = model.hp_title;
    NSString *string = model.hp_makettime;
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateformat dateFromString:string];
    [dateformat setDateFormat:@"dd MMM.yyyy"];
    NSString *time = [dateformat stringFromDate:date];
    cell.timelable.text = time;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((KscreenWidth - 10)/2 , (KscreenWidth - 10)/2);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomContentViewController *home = [[HomContentViewController alloc]init];
    home.number = indexPath.item;
    home.arry = [_datarry copy];
    home.title = @"ONE";
    home.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:home animated:YES];
}
#pragma mark---------requestData
-(void)requestData{
    NSString *urlstring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/hp/bymonth/%@?version=v3.5.3&platform=ios&user_id=",self.arry[_selected]];
    NSString *string = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"Status" : @"Complete"};
    [manager GET:string parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _datarry = [NSMutableArray array];
        NSArray *arry = responseObject[@"data"];
        _number = arry.count;
        for (NSDictionary *dic in arry) {
            HomeModel *model = [[HomeModel alloc]init];
            model.hp_img_original_url = dic[@"hp_img_original_url"];
            model.hp_title = dic[@"hp_title"];
            model.hp_makettime = dic[@"hp_makettime"];
            model.hp_content = dic[@"hp_content"];
            model.praisenum = dic[@"praisenum"];
            [_datarry addObject:model];
        }
        [_collection reloadData];        
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
