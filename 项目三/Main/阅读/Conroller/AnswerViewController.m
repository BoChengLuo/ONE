//
//  AnswerViewController.m
//  项目三
//
//  Created by wxhl on 16/11/6.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnsOneCell.h"
#import "AnsTwoCell.h"
#import "AnsThreeCell.h"
#import "AnsFourCell.h"
#import "ReadModel.h"

@interface AnswerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_passage;
    NSMutableArray *_propose;
    NSMutableArray *_comment;
    CGFloat height1;
    CGFloat height2;
    CGFloat height3;
    CGFloat height4;
    UISwipeGestureRecognizer *swip1;
    UISwipeGestureRecognizer *swip2;
    UIView *_view;
    UIActivityIndicatorView *_actiview;
}

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self requestData];
    [self creatGesture];
//    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
        AnsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[AnsOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        ReadModel *model;
        if (_passage.count > 0) {
            
            model = _passage[index1.row];
        }

//        //        标题
        cell.list.text = model.question_title;
        cell.list.numberOfLines = 0;
        [cell.list sizeToFit];
//        [cell.contentView addSubview:list];
//        //        正文
        CGRect frame = cell.text.frame;
        cell.text.text = model.question_content;
        cell.text.numberOfLines = 0;
        [cell.text sizeToFit];
        CGRect rect = [cell.text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.1]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
        height1 = 60 + rect.size.height;
//        [cell.contentView addSubview:text];
        return cell;
//        //        编辑
    }else if(indexPath == index2){
        AnsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[AnsTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        ReadModel *model;
        if (_passage.count > 0) {
            
            model = _passage[index2.section];
        }
//        //        标题
        cell.list.text = model.answer_title;
        cell.list.numberOfLines = 0;
        [cell.list sizeToFit];

//        //        日期
        NSString *string = model.question_makettime;
        NSDateFormatter *dateform = [[NSDateFormatter alloc]init];
        [dateform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateform dateFromString:string];
        [dateform setDateFormat:@"MMM.dd.yyyy"];
        cell.datatime.text = [dateform stringFromDate:date];
        [cell.datatime sizeToFit];
//        //        正文
        CGRect frame = cell.text.frame;
//        text.font = [UIFont systemFontOfSize:18];
        cell.text.text = model.answer_content;
        [cell.text setUserInteractionEnabled:NO];
        [cell.text sizeToFit];
        CGRect rect = [cell.text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 15, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.2]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
//        //        编辑
        cell.editor.text = model.charge_edt;
        [cell.editor sizeToFit];
        CGRect edit = cell.editor.frame;
        edit.origin.y = CGRectGetMaxY(frame);
        cell.editor.frame = edit;
        height2 = 92 + rect.size.height;
        return cell;
    }else if (indexPath.section == 1){
        AnsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[AnsThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        }
        ReadModel *model;
        if (_propose.count > 0) {
            model = _propose[indexPath.row];
        }
//        //        标题
        cell.list.text = model.question_title;
        [cell.list sizeToFit];
        cell.auther.text = model.answer_title;
        [cell.auther sizeToFit];

        CGRect frame = cell.text.frame;
        cell.text.text = model.answer_content;
        [cell.text sizeToFit];
        CGRect rect = [cell.text.text boundingRectWithSize:CGSizeMake(KscreenWidth - 20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.text.frame = frame;
        height3 = 65 + rect.size.height;
        return cell;
    }else{
        AnsFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[AnsFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
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
        height4 = 85 + rect.size.height;
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
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
        return height2;
    }else if(indexPath.section == 1){
    return height3;
    }else{
        return height4;
    }
}
#pragma mark----------requestData-
-(void)requestData{
    NSString *urlstring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/question/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *string = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"Status" : @"Complete" };
    [manager GET:string parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _passage = [NSMutableArray array];
        NSDictionary *dic = responseObject[@"data"];
        ReadModel *model = [[ReadModel alloc]init];
        model.question_title = dic[@"question_title"];
        model.question_content = dic[@"question_content"];
        model.answer_title = dic[@"answer_title"];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dic[@"answer_content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        model.answer_content = attrStr.string;
        model.charge_edt = dic[@"charge_edt"];
        model.question_makettime = dic[@"question_makettime"];
        [_passage addObject:model];
        [_tableview reloadData];
        _view.hidden = YES;
        [_actiview stopAnimating];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _view.hidden = NO;
        [_actiview stopAnimating];
    }];
    NSString *prosestring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/related/question/%@?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *prose = [prosestring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:prose parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _propose = [NSMutableArray array];
        NSArray *arry = responseObject[@"data"];
        for (NSDictionary *dic in arry) {
            ReadModel *model = [[ReadModel alloc]init];
            model.question_title = dic[@"question_title"];
            model.answer_title = dic[@"answer_title"];
            model.answer_content = dic[@"answer_content"];
            [_propose addObject:model];
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    NSString *comentring = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/question/%@/0?version=v3.5.3&platform=ios&user_id=",self.conten_id];
    NSString *comnet = [comentring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [manager GET:comnet parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject[@"data"];
        NSArray *arry = data[@"data"];
        _comment = [NSMutableArray array];
        for (NSDictionary *dic in arry) {
            ReadModel *model = [[ReadModel alloc]init];
            NSDictionary *logo = dic[@"user"];
            model.web_url = logo[@"web_url"];
            model.user_name = logo[@"user_name"];
            model.input_date = dic[@"input_date"];
            model.praisenum = [NSString stringWithFormat:@"%@",dic[@"praisenum"]];
            model.content = dic[@"content"];
            [_comment addObject:model];
        }
        [_tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark-------------gesture
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
                transition.type = @"cube";
                transition.subtype = kCATransitionFromRight;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:nil];
                [_actiview startAnimating];
                _view.hidden = NO;
                self.index ++;
                ReadModel *model = self.arry[self.index];
                self.conten_id = model.content_id;
                [self requestData];
            }
        }else if (swiper == swip2){
            if (self.index > 0 && self.index < self.arry.count) {
                CATransition *transition = [[CATransition alloc]init];
                transition.type =@"cube";
                transition.subtype = kCATransitionFromLeft;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:nil];
                [_actiview startAnimating];
                _view.hidden = NO;
                self.index --;
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
