//
//  HomeViewController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomeViewController.h"
#import "ListViewController.h"
#import "HomeHeardview.h"
#import "HomeToolview.h"
#import "HomeModel.h"
#import "HomeCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    UIView *_view;
    UICollectionView *_collection;
    NSInteger number;
    NSMutableArray *_arry;
    UIView *_bgview;
    UIActivityIndicatorView *_actiview1;
    CGFloat height;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestData];
    [self creatCollectionview];
}
#pragma mark----------collectionview--------------
-(void)creatCollectionview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collection registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell"];
    _collection.pagingEnabled = YES;
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.scrollEnabled = YES;
    _collection.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collection ];
    _bgview = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgview];
    _actiview1 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actiview1.frame = CGRectMake(0, 0, 100, 100);
    _actiview1.center = _bgview.center;
    [_bgview addSubview:_actiview1];
    [_actiview1 startAnimating];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return number;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    HomeModel *model = _arry[indexPath.row];
    cell.heardview.countlable.text = model.hp_title;
    [cell.heardview.countlable sizeToFit];

//    编号
    cell.heardview.countlable.text = model.hp_title;
    [cell.heardview.countlable sizeToFit];
//    内容
    cell.heardview.textlable.numberOfLines = 0;
    cell.heardview.textlable.text = model.hp_content;
    CGRect rect2 = [cell.heardview.textlable.text boundingRectWithSize:CGSizeMake(KscreenWidth - 30 , 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    cell.heardview.height = rect2.size.height;
    CGRect frame1 = cell.heardview.textlable.frame;
    frame1.size.width = rect2.size.width;
    frame1.size.height = rect2.size.height;
    cell.heardview.textlable.frame = frame1;
    cell.heardview.backgroundColor = [UIColor clearColor];
    [cell.heardview.textlable sizeToFit];

//    内容视图
    CGRect frame = cell.heardview.view.frame;
    frame.size.height = 290 + rect2.size.height;
    cell.heardview.view.frame = frame;
    height = frame.size.height;
    if (height > (KscreenHeight - 44 - 64 - 90 )) {
        cell.view.hidden = NO;
        cell.tooleview.hidden = YES;
    }
//    头视图
    CGRect frame5 = cell.heardview.frame;
    frame5.size.height = cell.heardview.view.frame.size.height + 30;
    cell.tableview.sectionHeaderHeight = cell.heardview.view.frame.size.height + 64;
    cell.heardview.frame = frame5;
//    时间
    cell.heardview.timelable.alpha = .6;
    cell.heardview.timelable.textAlignment = NSTextAlignmentRight;
    cell.heardview.timelable.font = [UIFont systemFontOfSize:12];
    cell.heardview.timelable.text = model.hp_makettime;
    [cell.heardview.timelable sizeToFit];
    CGRect rect3 = [cell.heardview.timelable.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    CGRect frame4 = cell.heardview.timelable.frame;
    frame4.size.width = rect3.size.width;
    //    NSLog(@"%f",rect3.size.height);
    frame4.size.height = rect3.size.height;
    frame4.origin.x = cell.heardview.view.bounds.size.width - rect3.size.width;
    frame4.origin.y = CGRectGetMaxY(frame1);
    cell.heardview.timelable.frame = frame4;
//    作者
    cell.heardview.auterlable.text = model.hp_author;
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:12]
                          };

    CGRect rect1 = [cell.heardview.auterlable.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGRect frame2 = cell.heardview.auterlable.frame;
    frame2.size.width = rect1.size.width;
    frame2.origin.x = cell.heardview.view.bounds.size.width - rect1.size.width;
    //    frame2.size.width = rect.size.width;
    //    NSLog(@"%f",rect.size.width);
    cell.heardview.auterlable.frame = frame2;
//
//    加载图片视图
    NSURL *url = [NSURL URLWithString:model.hp_img_original_url];
    [cell.heardview.iamgevew setImageWithURL:url];
    cell.tooleview.actionlabel.text = [NSString stringWithFormat:@"%@",model.praisenum];
    [cell.tooleview.actionlabel sizeToFit];
    CGRect rect = [cell.tooleview.actionlabel.text boundingRectWithSize:CGSizeMake(200, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    CGRect frame3 = cell.tooleview.actionlabel.frame;
    frame3.origin.x = KscreenWidth - 40 - 15 - rect.size.width - 15;
    frame3.origin.y = 48;
    cell.tooleview.actionlabel.frame = frame3;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(KscreenWidth, KscreenHeight - 117);
    return size;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat x = scrollView.contentOffset.x;
    
    if (y > 0) {
//        _tooleview.hidden = NO;
//        _view.hidden = YES;
        
    }else{
//        _view.hidden = NO;
//        _tooleview.hidden = YES;
    }
    CGFloat w = x -  KscreenWidth * (number - 1);
    if (w > 20) {
        ListViewController *view = [[ListViewController alloc]init];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}
#pragma mark-------request
-(void)requestData{
    NSString *urlstring = @"http://v3.wufazhuce.com:8000/api/hp/more/0?version=v3.5.3&platform=ios&user_id= ";
    NSString *str = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    NSDictionary *parmae = @{@"Status" : @"Complete" };
    [manage GET:str parameters:parmae progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arry = responseObject[@"data"];
        //        NSLog(@"%@",responseObject);
        number = arry.count;
        _arry = [NSMutableArray array];
        for (NSDictionary * dic in arry) {
            //            NSLog(@"%@",dic);
            HomeModel *model = [[HomeModel alloc]init];
            model.hp_img_original_url = dic[@"hp_img_original_url"];
            model.hp_title = dic[@"hp_title"];
            model.hp_author = dic[@"hp_author"];
            model.hp_content = dic[@"hp_content"];
            model.hp_makettime = dic[@"hp_makettime"];
            model.praisenum = dic[@"praisenum"];
            [_arry addObject:model];
        }
        [_collection reloadData];
        _bgview.hidden = YES;
        [_actiview1 stopAnimating];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _bgview.hidden = NO;
        [_actiview1 stopAnimating];
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
