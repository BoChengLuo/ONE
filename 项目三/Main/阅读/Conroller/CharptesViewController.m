//
//  CharptesViewController.m
//  项目三
//
//  Created by wxhl on 16/11/6.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "CharptesViewController.h"
#import "CharpOneCell.h"
#import "CharpTwoCell.h"
#import "CharpThreeCell.h"
#import "CharpFourCell.h"
#import "ReadModel.h"

@interface CharptesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_passage;
    NSMutableArray *_propose;
    NSMutableArray *_comment;
    CGFloat  height1;
    CGFloat height2;
    CGFloat height3;
    UISwipeGestureRecognizer *swip1;
    UISwipeGestureRecognizer *swip2;
    UIView *_view;
    UIActivityIndicatorView *_actview;
}

@end

@implementation CharptesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    height1 = [NSMutableArray array];
    [self creatTableview];
    [self requestData];
    [self creatGesture];
//    self.view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
//    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
    _view = [[UIView alloc]initWithFrame:self.view.bounds];
    _view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view];
    _actview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actview.frame = CGRectMake(0, 0, 100, 100);
    _actview.center = _view.center;
    [_view addSubview:_actview];
    [_actview startAnimating];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    cell.backgroundColor = [UIColor cyanColor];
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    if (indexPath == index1) {
        CharpOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[CharpOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
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

        
        //        标题
        
        cell.list.text = model.hp_title;
        [cell.list sizeToFit];
        //        正文
        CGRect frame = cell.text.frame;
        cell.text.text = model.hp_content;
        [cell.text setUserInteractionEnabled:NO];
        [cell.text sizeToFit];
        CGRect rect = [model.hp_content boundingRectWithSize:CGSizeMake(KscreenWidth -15, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.2]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
        CGRect editor = cell.editor.frame;
        editor.origin.y = CGRectGetMaxY(frame);
        cell.editor.frame = editor;
        cell.editor.text = model.charge_edt;
        [cell.editor sizeToFit];
        height1 = 162 + rect.size.height;
        return cell;
    }else if(indexPath == index2){
        CharpTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[CharpTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
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
        cell.datatime.text = model.summary;
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [cell.datatime.text boundingRectWithSize:CGSizeMake(KscreenWidth - 60, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        CGRect frame = cell.datatime.frame;
        frame.size.height = rect.size.height;
        frame.size.width = rect.size.width;
        cell.datatime.frame = frame;
        [cell.datatime sizeToFit];

        return cell;
    }else if (indexPath.section == 1){
        CharpThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[CharpThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
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
        cell.text.text = modle.excerpt;
        [cell.text sizeToFit];
        CGRect rect = [cell.text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
        height2 = 50 + rect.size.height;
        return cell;
    }else{
        CharpFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[CharpFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
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
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [cell.list.text boundingRectWithSize:CGSizeMake(KscreenWidth - 20, KscreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        frame.size.height = rect.size.height;
        frame.size.width = rect.size.width;
        cell.list.frame = frame;
        height3 = 85 + rect.size.height;
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
    NSIndexPath *index1 = [NSIndexPath indexPathForItem:1 inSection:0];
    if (indexPath == index) {
        return height1;
    }else if (indexPath == index1){
        return 150;
    }else if (indexPath.section == 1){
        return height2;
    }else{
        return height3;
    }
}
#pragma mark---------------requestData
-(void)requestData{
    NSString *urlstring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/serialcontent/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *string = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"Status" : @"Complete" };
    [manager GET:string parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ReadModel *model = [[ReadModel alloc]init];
        _passage = [NSMutableArray array];
        NSDictionary *dic = responseObject[@"data"];
//        NSArray *arry = dic[@"author"];
        NSDictionary *autor = dic[@"author"];
        NSString *web_url = autor[@"web_url"];
        model.web_url = web_url;
        model.hp_author = autor[@"user_name"];
        model.last_update_date = dic[@"last_update_date"];
        model.hp_title = dic[@"title"];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dic[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSString *str = attrStr.string;
        model.hp_content = str;
        model.charge_edt= dic[@"charge_edt"];
        model.summary= dic[@"summary"];
        model.wb_name = autor[@"wb_name"];
        [_passage addObject:model];
        [_tableview reloadData];
        _view.hidden = YES;
        [_actview stopAnimating];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _view.hidden = NO;
        [_actview stopAnimating];
    }];
    //    推荐
    NSString *url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/related/serial/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *prose = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:prose parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _propose = [NSMutableArray array];
        NSArray *arry = responseObject[@"data"];
        if (arry != nil) {
            
            for (NSDictionary *dic in arry) {
                ReadModel *modle = [[ReadModel alloc]init];
                modle.hp_title = dic[@"title"];
//                NSArray *author = dic[@"author"];
                NSDictionary *audic = dic[@"author"];
                modle.user_name = audic[@"user_name"];
                modle.excerpt= dic[@"excerpt"];
                [_propose addObject:modle];
                
            }
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    //    评论
    NSString *urlcomment = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/0?version=v3.5.3&platform=ios&user_id=",self.conten_id];
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
#pragma mark------------gestrue
-(void)creatGesture{
    swip1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ActionSwiper:)];
    swip2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ActionSwiper:)];
    swip1.direction = UISwipeGestureRecognizerDirectionLeft;
    swip2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip1];
    [self.view addGestureRecognizer:swip2];
}
-(void)ActionSwiper:(UISwipeGestureRecognizer *)swiper{
    if (self.choice == 1) {
        if (swiper == swip1) {
            if (self.index >=0 && self.index < self.arry.count -1) {
                CATransition *transition = [[CATransition alloc]init];
                transition.type = @"suckEffect";
                transition.subtype = kCATransitionFromLeft;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:nil];
                [_actview startAnimating];
                _view.hidden = NO;
                self.index ++;
                ReadModel *model = self.arry[self.index];
                self.conten_id = model.content_id;
                [self requestData];
            }
        }else if (swiper == swip2){
            if (self.index > 0 && self.index < self.arry.count) {
                CATransition *transition = [[CATransition alloc]init];
                transition.type = @"suckEffect";
                transition.subtype = kCATransitionFromRight;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:nil];
                [_actview startAnimating];
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
