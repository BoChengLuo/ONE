//
//  DataViewController.m
//  项目三
//
//  Created by wxhl on 16/11/5.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "DataViewController.h"
#import "OneTableViewCell.h"
#import "ZeroTableViewCell.h"
#import "SectionOneTableViewCell.h"
#import "OtherTableViewCell.h"
#import "ReadModel.h"
#import <AVFoundation/AVFoundation.h>

@interface DataViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_passage;
    NSMutableArray *_propose;
    NSMutableArray *_comment;
    CGFloat height1;
    CGFloat height2;
    CGFloat height3;
    AVPlayer *_player;
    NSInteger state;
    UISwipeGestureRecognizer *swip1;
    UISwipeGestureRecognizer *swip2;
    UIView *_view;
    UIActivityIndicatorView *_actiview;
    
}

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self requestData];
    [self creatGestrue];
    state = 1;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    _view = [[UIView alloc]initWithFrame:self.view.bounds];
    _view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view];
    _actiview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actiview.frame = CGRectMake(0, 0, 100, 100);
    _actiview.center = _view.center;
    [_view addSubview:_actiview];
    [_actiview startAnimating];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    if (indexPath == index1) {
        ZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        //    cell.backgroundColor = [UIColor cyanColor];
        if ( !cell) {
        cell = [[ZeroTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        ReadModel *model;
        if (_passage.count > 0) {
            model = _passage[index1.row];
        }
        NSURL *url = [NSURL URLWithString:model.web_url];
        //        头像
        [cell.imageview setImageWithURL:url];
        //        作者
        cell.auter.text = model.hp_author;
        [cell.auter sizeToFit];
        //        日期
        NSString *string = model.last_update_date;
        NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateformat dateFromString:string];
        [dateformat setDateFormat:@"MMM.dd,yyyy"];
        NSString *time = [dateformat stringFromDate:date];
        cell.datatime.text = time;
        [cell.datatime sizeToFit];
        //        收听按钮
        NSURL *musicurl = [NSURL URLWithString:model.audio];
        _player = [[AVPlayer alloc]initWithURL:musicurl];
        [cell.listenbut addTarget:self action:@selector(musicPlay:) forControlEvents:UIControlEventTouchUpInside];
        [cell.listenbut setImage:[UIImage imageNamed:@"playing_btn_play_n@2x"] forState:UIControlStateNormal];

        //        标题

        cell.list.text = model.hp_title;
        [cell.list sizeToFit];
        //        正文
        CGRect frame = cell.text.frame;
        cell.text.text = model.hp_content;
        [cell.text setUserInteractionEnabled:NO];
        [cell.text sizeToFit];
        CGRect rect = [model.hp_content boundingRectWithSize:CGSizeMake(KscreenWidth -15, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.155]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
        CGRect editor = cell.editor.frame;
        editor.origin.y = CGRectGetMaxY(frame);
        cell.editor.frame = editor;
        cell.editor.text = model.hp_author_introduce;
        [cell.editor sizeToFit];
        height1 = 162 + rect.size.height;
        return cell;
    }else if(indexPath == index2){
        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if ( !cell) {
                cell = [[OneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        ReadModel *model;
        if (_passage.count > 0) {
            
            model = _passage[index2.section];
        }
        
        //        头像

        NSURL *url = [NSURL URLWithString:model.web_url];
        [cell.imageview setImageWithURL:url];
        cell.imageview.layer.cornerRadius = 25;
        //        作者
        cell.auter.text = model.hp_author;;
        [cell.auter sizeToFit];
//        //        出版
        cell.datatime.text = model.auth_it;
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [cell.datatime.text boundingRectWithSize:CGSizeMake(KscreenWidth - 60, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        CGRect frame = cell.datatime.frame;
        frame.size.height = rect.size.height;
        frame.size.width = rect.size.width;
        cell.datatime.frame = frame;
        [cell.datatime sizeToFit];
//        weiboname
        cell.weiboname.text = [NSString stringWithFormat:@"weibo:%@",model.wb_name];
        [cell.weiboname sizeToFit];
        CGRect webfram = cell.weiboname.frame;
        webfram.origin.y = CGRectGetMaxY(frame);
        cell.weiboname.frame = webfram;
        return cell;
    }else if (indexPath.section == 1){
        SectionOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if ( !cell) {
                cell = [[SectionOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        }
        ReadModel *modle;
        if (_propose.count >0) {
            modle = _propose[indexPath.row];
            
        }
//        //        标题
        cell.list.text = modle.hp_title;
        [cell.list sizeToFit];
        cell.auther.text = modle.user_name;
        [cell.auther sizeToFit];
//        //        正文
        CGRect frame = cell.text.frame;
        cell.text.text = modle.guide_word;
        [cell.text sizeToFit];
        CGRect rect = [cell.text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
        height2 = 70 + rect.size.height;
        return cell;
        
    }else{
        OtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if ( !cell) {
                cell = [[OtherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            
        }
        ReadModel *model;
        if (_comment.count > 0) {
            model = _comment[indexPath.section -2];
            
        }
        //        头像
        NSURL *url = [NSURL URLWithString:model.web_url];
        [cell.imageview setImageWithURL:url];
//        //        作者
        cell.auter.text = model.user_name;
        [cell.auter sizeToFit];
//        [self.contentView addSubview:_auter];
//        //        日期
        NSString *time = model.input_date;
        NSDateFormatter *dataformat = [[NSDateFormatter alloc]init];
        [dataformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dataformat dateFromString:time];
        [dataformat setDateFormat:@"yyyy.MM.dd"];
        NSString *timstring = [dataformat stringFromDate:date];
        cell.datatime.text = timstring;
//        _datatime.text = @"nov.04.2016";
        [cell.datatime sizeToFit];
//        //        点赞人数lable
        cell.listen.text = model.praisenum;
//        //        评论
//        _list.textColor = [UIColor blackColor];
        cell.list.text = model.content;
        cell.list.numberOfLines = 0;
        [cell.list sizeToFit];
        CGRect frame = cell.list.frame;
//        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [model.content boundingRectWithSize:CGSizeMake(KscreenWidth - 20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}context:nil];
        frame.size.height = rect.size.height;
        frame.size.width = rect.size.width;
        cell.list.frame = frame;
        height3 = rect.size.height;
        return cell;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return _propose.count;
   
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _comment.count + 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if(section == 1){
        if (_propose.count>0) {
            
            return 45;
        }else{
            return 0.01;
        }
    }else if(section == 2){
        return 45;
    }else{
        return 20;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 15)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"相关推荐";
        [label sizeToFit];
        [view addSubview:label];
        label.hidden = YES;
        if (_propose.count>0) {
            label.hidden = NO;
        }
        return view;
    }else if(section == 2){
        UIView *view = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 0, 15)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"评论列表";
        [label sizeToFit];
        [view addSubview:label];
        return view;
        
    }
    UIView *view = [[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:1 inSection:0];
    if (indexPath == index) {
        return height1;
    }else if (indexPath == index1){
        return 150;
    }else if (indexPath.section == 1){
        return height2;
    }else{
    return height3 + 85;
    }
}
#pragma mark---------------requestData
-(void)requestData{
    NSString *urlstring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/essay/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *string = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"Status" : @"Complete" };
    [manager GET:string parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ReadModel *model = [[ReadModel alloc]init];
        _passage = [NSMutableArray array];
        NSDictionary *dic = responseObject[@"data"];
        NSArray *arry = dic[@"author"];
        NSDictionary *autor = arry[0];
        NSString *web_url = autor[@"web_url"];
        model.web_url = web_url;
        model.hp_author = dic[@"hp_author"];
        model.last_update_date = dic[@"last_update_date"];
        model.audio = dic[@"audio"];
        model.hp_title = dic[@"hp_title"];
//        model.hp_content = dic[@"hp_content"];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dic[@"hp_content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSString *str = attrStr.string;
        model.hp_content = str;
        model.hp_author_introduce = dic[@"hp_author_introduce"];
        model.auth_it = dic[@"auth_it"];
        model.wb_name = autor[@"wb_name"];
        [_passage addObject:model];
        [_tableview reloadData];
        _view.hidden = YES;
        [_actiview stopAnimating];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _view.hidden = NO;
        [_actiview stopAnimating];
    }];
//    推荐
    NSString *url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/related/essay/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *prose = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:prose parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _propose = [NSMutableArray array];
        NSArray *arry = responseObject[@"data"];
        if (arry != nil) {
            
            for (NSDictionary *dic in arry) {
                ReadModel *modle = [[ReadModel alloc]init];
                modle.hp_title = dic[@"hp_title"];
                NSArray *author = dic[@"author"];
                NSDictionary *audic = author[0];
                modle.user_name = audic[@"user_name"];
                modle.guide_word = dic[@"guide_word"];
                [_propose addObject:modle];
                
            }
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
//    评论
    NSString *urlcomment = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/essay/%@/0?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *comment =[urlcomment stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:comment parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _comment = [NSMutableArray array];
        NSDictionary *data = responseObject[@"data"];
        NSArray *arry = data[@"data"];
        for (NSDictionary *dic in arry) {
            ReadModel *model = [[ReadModel alloc]init];
            NSDictionary *image = dic[@"user"];
            model.web_url = image[@"web_url"];
            model.user_name = image[@"user_name"];
            model.input_date = dic[@"input_date"];
            model.praisenum = [NSString stringWithFormat:@"%@",dic[@"praisenum"]];
            model.content = dic[@"content"];
            [_comment addObject:model];
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)musicPlay:(UIButton *)sender{
    UIButton *button = sender;
    if (state == 1) {
        [button setImage:[UIImage imageNamed:@"playing_btn_pause_n@2x"] forState:UIControlStateNormal];
        [_player play];
        state = 2;
    }else if (state == 2){
       [button setImage:[UIImage imageNamed:@"playing_btn_play_n@2x"] forState:UIControlStateNormal];
        [_player pause];
        state = 1;
    }
}
#pragma mark-------------gestrue
-(void)creatGestrue{
    swip1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ActionSwip:)];
    
    swip2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ActionSwip:)];
    swip1.direction = UISwipeGestureRecognizerDirectionLeft;
    swip2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip1];
    [self.view addGestureRecognizer:swip2];
}
-(void)ActionSwip:(UISwipeGestureRecognizer *)swiper{
    if (self.choice == 1) {
        if (swiper == swip1) {
            if (self.index >= 0 && self.index < self.arry.count -1) {
                CATransition *transition = [[CATransition alloc]init];
                transition.type = @"reveal";
                transition.subtype = kCATransitionFromRight;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:nil];
                [_actiview startAnimating];
                _view.hidden = NO;
                self.index++;
                ReadModel *model = self.arry[self.index];
                self.conten_id = model.content_id;
                [self requestData];
            }
        }else if (swiper == swip2){
            if (self.index > 0 && self.index < self.arry.count) {
                CATransition *transition = [[CATransition alloc]init];
                transition.type = @"reveal";
                transition.subtype = kCATransitionFromLeft;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:nil];
                [_actiview startAnimating];
                _view.hidden = NO;
                self.index--;
                ReadModel *model = self.arry[self.index];
                self.conten_id = model.content_id;
                [self requestData];
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
