//
//  ReadViewController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ReadViewController.h"
#import "DateListViewController.h"
#import "DataViewController.h"
#import "CharptesViewController.h"
#import "AnswerViewController.h"
#import "ReadModel.h"
#import "ReadCell.h"

@interface ReadViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
//    动态滑动图片
    UIView *_view;
    UIScrollView *_scrollview;
    NSMutableArray *_imagearry;
//    各种文章
    UITableView *_tableview;
    UIScrollView *_datascroll;
    NSMutableArray *_essay;
    NSMutableArray *_serial;
    NSMutableArray *_question;
    NSInteger _number;
    NSInteger index;
    CGFloat height;
    UIView *_bgview;
    UIActivityIndicatorView *_actview;

}

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view.
}
#pragma mark --------- heardscrollview--------
-(void)creatview{
    _bgview = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview];
    _actview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actview.frame = CGRectMake(0, 0, 100, 100);
    _actview.center = _bgview.center;
    [_bgview addSubview:_actview];
    [_actview startAnimating];
}
-(void)creatCollectionview{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 214)];
//    _view.backgroundColor = [UIColor redColor];
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, 150)];
    _scrollview.delegate = self;
    _scrollview.backgroundColor = [UIColor clearColor];
    _scrollview.pagingEnabled = YES;
//    [_view addSubview:_scrollview];
    for (int i =0; i <_imagearry.count; i++) {
        ReadModel *model = _imagearry[i];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(i * KscreenWidth, 0, KscreenWidth, 150)];
        view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = .7;
        view.layer.shadowRadius = 2;
        NSURL *url = [NSURL URLWithString:model.cover];
        [view setImageWithURL:url];
        [_scrollview addSubview:view];
    }
    _scrollview.contentSize = CGSizeMake((_imagearry.count)*KscreenWidth, 0);
    [self.view addSubview:_scrollview];

}

#pragma mark --------------- datascrollview-------
-(void)creatTaleView{
    _datascroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,214, KscreenWidth, KscreenHeight - 214 - 44)];
    _datascroll.delegate = self;
    _datascroll.pagingEnabled = YES;
    _datascroll.directionalLockEnabled = YES;
    for (int i = 0; i<_essay.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5 + (i * KscreenWidth), 5, KscreenWidth - 10, _datascroll.bounds.size.height)];
        view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 1);
        view.layer.shadowOpacity = .7;
        view.layer.shadowRadius = 2;
        view.backgroundColor = [UIColor whiteColor];
        _tableview = [[UITableView alloc]initWithFrame:view.bounds style:UITableViewStylePlain];
        [view addSubview:_tableview];
        _tableview.dataSource = self;
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ceel"];
        _tableview.delegate = self;
        _tableview.sectionHeaderHeight = 0;
        [_datascroll addSubview:view];
    }

    _datascroll.contentSize = CGSizeMake(_essay.count *KscreenWidth, 0);
    [self.view addSubview:_datascroll];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _datascroll) {
        DateListViewController *controller = [[DateListViewController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        CGFloat x = scrollView.contentOffset.x;
//        NSLog(@"%lf",x);
        if (x > KscreenWidth* (_essay.count -1)) {
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    if (scrollView == _scrollview) {
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    index = scrollView.contentOffset.x/KscreenWidth;
}
#pragma mark-----------------------taleview------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ceel"];
    if (!cell) {
        cell = [[ReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    //    右边label

    if (indexPath.row == 0) {
        
        cell.rightlabel.text = @"短篇";
    }else if (indexPath.row == 1){
        cell.rightlabel.text = @"连载";
    }else{
        cell.rightlabel.text = @"问答";
    }
//    [cell.contentView addSubview:_rightlabel];
    ReadModel *esay;
    ReadModel *serial;
    ReadModel *question;
    if (_number >= 0) {
      esay  = _essay[_number];
      serial  = _serial[_number];
      question  = _question[_number];
        
    }
//    标题
    CGRect frame = cell.heading.frame;
    if (indexPath.row == 0) {
        
        cell.heading.text = esay.hp_title;
    }else if (indexPath.row == 1){
        cell.heading.text = serial.title;
    }else if (indexPath.row == 2){
        cell.heading.text = question.question_title;

    }
    CGRect rect = [cell.heading.text boundingRectWithSize:CGSizeMake(CGRectGetMinX(cell.rightlabel.frame) - 20, cell.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
    frame.size.width = rect.size.width;
    frame.size.height = rect.size.height;
    cell.heading.frame = frame;
    [cell.heading sizeToFit];
    if (indexPath.row == 0) {
        cell.auther.text = esay.user_name;
    }else if (indexPath.row == 1){
        cell.auther.text = serial.user_name;
        
    }else if (indexPath.row == 2){
        cell.auther.text = question.answer_title;
    }
    CGRect auterfram = cell.auther.frame;
    auterfram.origin.y = CGRectGetMaxY(frame) +10;
    cell.auther.frame = auterfram;
    [cell.auther sizeToFit];

    CGRect textframe = cell.textlabel.frame;
    if (indexPath.row == 0) {
        cell.textlabel.text = esay.guide_word;
    }else if (indexPath.row==1){
        cell.textlabel.text = serial.excerpt;
    }else if (indexPath.row == 2){
        cell.textlabel.text = question.answer_content;
        if (_number > 0) {
            _number--;
        }

    }
    CGRect textrect = [cell.textlabel.text boundingRectWithSize:CGSizeMake(cell.bounds.size.width -10, cell.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    [cell.textlabel sizeToFit];
    textframe.size.width = textrect.size.width;
    textframe.size.height = textrect.size.height;
    textframe.origin.y = CGRectGetMaxY(frame) + 25;
    cell.textlabel.frame = textframe;
    height = 50 + rect.size.height + auterfram.size.height + textrect.size.height;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height +10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataViewController *viewcontrller = [[DataViewController alloc]init];
    viewcontrller.hidesBottomBarWhenPushed = YES;
    CharptesViewController *charptes = [[CharptesViewController alloc]init];
    charptes.hidesBottomBarWhenPushed = YES;
    AnswerViewController *answer = [[AnswerViewController alloc]init];
    answer.hidesBottomBarWhenPushed = YES;
    if (indexPath.row == 0) {
        ReadModel *model = _essay[index];
        viewcontrller.conten_id = model.content_id;
        viewcontrller.arry = [_essay copy];
        viewcontrller.index = index;
        viewcontrller.choice = 1;
        [self.navigationController pushViewController:viewcontrller animated:YES];
    }else if (indexPath.row == 1){
        ReadModel *model = _serial[index];
        charptes.conten_id = model.content_id;
        charptes.arry = [_serial copy];
        charptes.index = index;
        charptes.choice = 1;
        [self.navigationController pushViewController:charptes animated:YES];
    }else{
        ReadModel *model = _question[index];
        answer.conten_id = model.content_id;
        answer.arry = [_question copy];
        answer.index = index;
        answer.choice = 1;
        [self.navigationController pushViewController:answer animated:YES];
    }
}
#pragma mark-------request
-(void)requestData{
    NSString *urlstring = @"http://v3.wufazhuce.com:8000/api/reading/carousel?version=v3.5.3&platform=ios&user_id=";
    NSString *str = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    NSDictionary *parmae = @{@"Status" : @"Complete" };
    [manage GET:str parameters:parmae progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arry = responseObject[@"data"];
        //        NSLog(@"%@",responseObject);
//        number = arry.count;
        _imagearry = [NSMutableArray array];
        for (NSDictionary * dic in arry) {
            //            NSLog(@"%@",dic);
            ReadModel *model = [[ReadModel alloc]init];
            model.cover = dic[@"cover"];
            [_imagearry addObject:model];
        }
        [self creatCollectionview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
    }];
    NSString *urls = @"http://v3.wufazhuce.com:8000/api/reading/index?version=v3.5.3&platform=ios&user_id=";
    NSString *strri = [urls stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manage GET:strri parameters:parmae progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        NSArray *arry1 = dic[@"essay"];
        NSArray *arry2 = dic[@"serial"];
        NSArray *arry3 = dic[@"question"];
        _essay = [NSMutableArray array];
        for (NSDictionary *essay in arry1) {
            ReadModel *model = [[ReadModel alloc]init];
            model.hp_title = essay[@"hp_title"];
            model.guide_word = essay[@"guide_word"];
            NSArray *arry = essay[@"author"];
            NSDictionary *auter = arry[0];
            model.user_name = auter[@"user_name"];
            model.content_id = essay[@"content_id"];
            [_essay addObject:model];
        }
        _serial = [NSMutableArray array];
        for (NSDictionary *serial in arry2) {
            ReadModel *model = [[ReadModel alloc]init];
            model.title = serial[@"title"];
            model.excerpt = serial[@"excerpt"];
            NSDictionary *author = serial[@"author"];
            model.user_name = author[@"user_name"];
            model.content_id = serial[@"id"];
            [_serial addObject:model];
        }
        _question = [NSMutableArray array];
        for (NSDictionary *question in arry3) {
            ReadModel *model = [[ReadModel alloc]init];
            model.question_title = question[@"question_title"];
            model.answer_title = question[@"answer_title"];
            model.answer_content = question[@"answer_content"];
            model.content_id = question[@"question_id"];
            [_question addObject:model];
        }
            _number = _essay.count - 1;
            [self creatTaleView];
        _bgview.hidden = YES;
        [_actview stopAnimating];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _bgview.hidden = NO;
        [_actview stopAnimating];
    }];
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
