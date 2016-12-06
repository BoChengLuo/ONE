//
//  AboutMoViewController.m
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AboutMoViewController.h"
#import "HeardTableViewCell.h"
#import "TextTableViewCell.h"
#import "ImagineTableViewCell.h"
#import "CommentTableViewCell.h"
#import "MovieModel.h"

@interface AboutMoViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *vedioarray;
    NSMutableArray *textarray;
    NSMutableArray *comentarry;
    UIWebView *webview;
    CGFloat _height;
    CGFloat _height1;
    NSInteger choice;
    ThemeButton *button1;
    ThemeButton *button2;
    ThemeButton *button3;
    UILabel *_lable;
    NSArray *keyword;
    UIScrollView *scrolview;
    UILabel *_lable1;
    UIView *_bgview;
    UIActivityIndicatorView *_actview;
}

@end

@implementation AboutMoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self requestData];
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableview];
    _bgview =[[UIView alloc]initWithFrame:self.view.bounds];
    _bgview.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_bgview];
    _actview  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actview.frame = CGRectMake(0, 0, 100, 100);
    _actview.center = _bgview.center;
    [_bgview addSubview:_actview];
    [_actview startAnimating];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *indexpath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexpath2 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *indexpath3 = [NSIndexPath indexPathForRow:0 inSection:2];
    if (indexPath == indexpath1) {
        HeardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[HeardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        MovieModel *model;
        if (vedioarray.count >0) {
            model = vedioarray[indexpath1.row];
        }
        NSURL *url = [NSURL URLWithString:model.video];
        [cell.imagview setImageWithURL:url];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (indexPath == indexpath2){
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[TextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        MovieModel *model;
        if (textarray.count > 0) {
            model = textarray[indexpath2.row];
        }
        NSURL *url = [NSURL URLWithString:model.web_url];
        [cell.imageview setImageWithURL:url];
        cell.auter.text = model.user_name;
        [cell.auter sizeToFit];
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *data = [format dateFromString:model.input_date];
        [format setDateFormat:@"MMM.dd.yyyy"];
        NSString *time = [format stringFromDate:data];
        cell.datatime.text = time;
        [cell.datatime sizeToFit];
        cell.list.text = model.title;
        cell.list.numberOfLines = 0;
        [cell.list sizeToFit];
        cell.text.delegate = self;
        webview = cell.text;
        cell.text.scrollView.bounces = NO;
        cell.text.scrollView.scrollEnabled = NO;
        if (choice != 2) {
            _bgview.hidden = NO;
            [_actview startAnimating];
            [cell.text loadHTMLString:model.content baseURL:nil];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (indexPath == indexpath3) {
        ImagineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[ImagineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSArray *array = @[cell.lable1,cell.lable2,cell.lable3,cell.lable4,cell.lable5];
        for (int i = 0; i < keyword.count; i++) {
            UILabel *lable = array[i];
            lable.text = keyword[i];
//            lable.backgroundColor = [UIColor whiteColor];
        }
        MovieModel *model;
        if (vedioarray.count>0) {
            model = vedioarray[indexpath3.row];
        }
        for (int i = 0; i < model.photo.count; i++) {
            UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(i * KscreenWidth/2, 0, KscreenWidth/2, 200)];
            NSURL *url = [NSURL URLWithString:model.photo[i]];
            [imageview setImageWithURL:url];
            [cell.scrollview addSubview:imageview];
        }
        cell.scrollview.bounces = NO;
        cell.scrollview.hidden = YES;
        scrolview = cell.scrollview;
        cell.scrollview.contentSize = CGSizeMake(model.photo.count * KscreenWidth/2, 0);
        cell.lable6.text = model.info;
        cell.lable6.hidden = YES;
        _lable1 = cell.lable6;
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            
        }
        MovieModel *model;
        if (comentarry.count > 0) {
            model = comentarry[indexPath.section - 3];
        }
        NSURL *url = [NSURL URLWithString:model.web_url];
        [cell.imageview setImageWithURL:url];
        cell.auter.text = model.user_name;
        [cell.auter sizeToFit];
        NSDateFormatter *formate = [[NSDateFormatter alloc]init];
        [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formate dateFromString:model.input_date];
        [formate setDateFormat:@"yyyy.MM.dd"];
        NSString *time = [formate stringFromDate:date];
        cell.datatime.text = time;
        [cell.datatime sizeToFit];
        cell.score.text = model.score;
        cell.listen.text = model.praisenum;
        cell.list.text = model.content;
        cell.list.numberOfLines = 0;
        CGRect rect = [model.content boundingRectWithSize:CGSizeMake(KscreenWidth - 10, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
        CGRect frame = cell.list.frame;
        frame.size.height = rect.size.height;
        frame.size.width = rect.size.width;
        cell.list.frame = frame;
        _height1 = 85 + rect.size.height;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selected = NO;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return comentarry.count + 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return _height + 150;
    }else if(indexPath.section == 0 || indexPath.section == 2){
    return 200;
    }else{
        return _height1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if (section == 1){
        return 50;
    }else if (section == 2 || section == 3){
        return 50;
    }else{
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
        lable.font = [UIFont systemFontOfSize:15];
        lable.text = @"电影故事";
        [view addSubview:lable];
        return view;
    }else if (section == 2){
        UIView *view = [[UIView alloc]init];
        _lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
        _lable.font = [UIFont systemFontOfSize:15];
        _lable.text = @"一个 电影列表";
        [view addSubview:_lable];
        button1 = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(KscreenWidth/2 - 40, 10, 50, 30);
        [button1 setTitle:@"相关" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button1.backgroundColor = [UIColor cyanColor];
        [view addSubview:button1];
        button2 = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(CGRectGetMaxX(button1.frame) + 35, 10, 50, 30);
        [button2 setTitle:@"剧照" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button2.backgroundColor = [UIColor cyanColor];
        [view addSubview:button2];
        button3 = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(CGRectGetMaxX(button2.frame) + 35, 10, 50, 30);
        [button3 setTitle:@"人员" forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button3.backgroundColor = [UIColor cyanColor];
        [view addSubview:button3];
        return view;
    }else if (section == 3){
        UIView *view = [[UIView alloc]init];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
        lable.font = [UIFont systemFontOfSize:15];
        lable.text = @"评论列表";
        [view addSubview:lable];
        return view;
    }
//        UIView *vie = [[UIView alloc]init];
    return nil;
}
-(void)buttonAction:(UIButton *)sender{
    if (sender == button1) {
        _lable.text = @"一个 电影列表";
        scrolview.hidden = YES;
        _lable1.hidden = YES;
    }else if (sender == button2){
        _lable.text = @"剧照";
        scrolview.hidden = NO;
        _lable1.hidden = YES;
    }else if (sender == button3){
        _lable.text = @"演职人员";
        _lable1.hidden = NO;
        scrolview.hidden = YES;
    }
}
#pragma mark------------requestdata
-(void)requestData{
    _bgview.hidden = NO;
    [_actview startAnimating];
    NSString *string = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/detail/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *image = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:image parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        vedioarray = [NSMutableArray array];
        MovieModel *model = [[MovieModel alloc]init];
        NSDictionary * data = responseObject[@"data"];
        model.video = data[@"detailcover"];
        model.keywords = data[@"keywords"];
        keyword = [model.keywords componentsSeparatedByString:@";"];
        model.photo = data[@"photo"];
        model.info = data[@"info"];
        [vedioarray addObject:model];
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    NSString *mostring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/%@/story/1/0?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *movie = [mostring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:movie parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        textarray = [NSMutableArray array];
        NSDictionary *data = responseObject[@"data"];
        NSArray *array = data[@"data"];
        for (NSDictionary *dic in array) {
            MovieModel *model = [[MovieModel alloc]init];
            NSDictionary *user = dic[@"user"];
            model.user_name = user[@"user_name"];
            model.web_url = user[@"web_url"];
            model.input_date = dic[@"input_date"];
            model.praisenum = dic[@"praisenum"];
            model.content = dic[@"content"];
            model.title = dic[@"title"];
            [textarray addObject:model];
        }
        choice = 1;
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    NSString *comtring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/movie/%@/0?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *coment = [comtring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:coment parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        comentarry = [NSMutableArray array];
        NSDictionary *data = responseObject[@"data"];
        NSArray *array = data[@"data"];
        for (NSDictionary *dic in array) {
            MovieModel *model = [[MovieModel alloc]init];
            NSDictionary *user = dic[@"user"];
            model.web_url = user[@"web_url"];
            model.user_name = user[@"user_name"];
            model.score =[NSString stringWithFormat:@"%@",dic[@"score"]];
            NSLog(@"%@",model.score);
            model.input_date = dic[@"input_date"];
            model.praisenum = [NSString stringWithFormat:@"%@",dic[@"praisenum"]];
            model.content = dic[@"content"];
            [comentarry addObject:model];
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    choice = 2;
     CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    CGRect frame = webview.frame;
    frame.size.height = height;
    webview.frame = frame;
    _height = frame.size.height;
    [_tableview reloadData];
    _bgview.hidden = YES;
    [_actview stopAnimating];
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
