//
//  ChoiceViewController.m
//  项目三
//
//  Created by wxhl on 16/11/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ChoiceViewController.h"
#import "DataViewController.h"
#import "CharptesViewController.h"
#import "AnswerViewController.h"
#import "ReadModel.h"
#import "ChoiceCell.h"

@interface ChoiceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    //    cell上面的lable
    //    标题
    NSArray *_choicarry;
    NSMutableArray *_esay;
    NSMutableArray *_serial;
    NSMutableArray *_question;
    CGFloat _height;
}

@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self requestData];
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
//    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_choice == 1) {
        
        return _esay.count;
    }else if (_choice == 2){
        return _serial.count;
    }else{
        return _question.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //    右边label
    if (self.choice == 1) {
        cell.rightlabel.text = @"连载";
    }else if(self.choice == 2){
        cell.rightlabel.text = @"短篇";
    }else if(self.choice == 3){
        cell.rightlabel.text = @"问题";
    }

    ReadModel *model;
    if (_choice == 1) {
        model = _esay[indexPath.row];
    }else if (_choice == 2){
        model = _serial[indexPath.row];
    }else if (_choice == 3){
        model = _question[indexPath.row];
    }
    //    标题
    CGRect frame = cell.heading.frame;
//    _heading.font = [UIFont systemFontOfSize:18];
    if (_choice == 1) {
        cell.heading.text = model.hp_title;
    }else if (_choice == 2){
        cell.heading.text = model.title;
    }else if (_choice == 3){
        cell.heading.text = model.question_title;
    }
    cell.heading.numberOfLines = 0;
    CGRect rect = [cell.heading.text boundingRectWithSize:CGSizeMake(CGRectGetMinX(cell.rightlabel.frame) - 20, cell.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
    frame.size.width = rect.size.width;
    frame.size.height = rect.size.height;
    cell.heading.frame = frame;
    _height += rect.size.height;
    [cell.heading sizeToFit];
    //    作者
    CGRect auterframe = cell.auther.frame;
    auterframe.origin.y = CGRectGetMaxY(frame);
    cell.auther.frame = auterframe;
    if (_choice == 1) {
        cell.auther.text = model.user_name;
    }else if (_choice == 2){
        cell.auther.text = model.user_name;
    }
    [cell.auther sizeToFit];
    if (_choice == 3) {
        cell.auther.hidden = YES;
    }
    _height += auterframe.size.height;
    //    内容

    CGRect textframe = cell.textlabel.frame;
    cell.textlabel.font = [UIFont systemFontOfSize:15];
    cell.textlabel.numberOfLines = 0;
    if (_choice == 1) {
        cell.textlabel.text = model.guide_word;
    }else if (_choice == 2){
        cell.textlabel.text = model.excerpt;
    }else if (_choice == 3){
        cell.textlabel.text = model.answer_title;
    }
    CGRect textrect = [cell.textlabel.text boundingRectWithSize:CGSizeMake(cell.bounds.size.width -10, cell.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    [cell.textlabel sizeToFit];
    textframe.size.width = textrect.size.width;
    textframe.size.height = textrect.size.height;
    textframe.origin.y = CGRectGetMidY(auterframe) + 10;
    cell.textlabel.frame = textframe;
    _height += textrect.size.height;
//    [cell.contentView addSubview:_textlabel];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.choice == 1) {
        ReadModel *model = _esay[indexPath.row];
        DataViewController *contr = [[DataViewController alloc]init];
        contr.hidesBottomBarWhenPushed = YES;
        contr.conten_id = model.content_id;
        contr.choice = 2;
        [self.navigationController pushViewController:contr animated:YES];
    }else if (self.choice == 2){
        ReadModel *model = _serial[indexPath.row];
        CharptesViewController *contr = [[CharptesViewController alloc]init];
        contr.hidesBottomBarWhenPushed = YES;
        contr.conten_id = model.content_id;
        contr.choice = 2;
        [self.navigationController pushViewController:contr animated:YES];
    }else if (self.choice == 3){
        ReadModel *model = _question[indexPath.row];
        AnswerViewController *contr = [[AnswerViewController alloc]init];
        contr.hidesBottomBarWhenPushed = YES;
        contr.conten_id = model.content_id;
        contr.choice = 2;
        [self.navigationController pushViewController:contr animated:YES];
    }
}
-(void)requestData{
    _choicarry = @[@"essay",@"serialcontent",@"question"];
    NSString *url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/%@/bymonth/%@?version=v3.5.3&platform=ios&user_id=",_choicarry[self.choice -1],self.arry[_index]];
    NSString *str = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"Status" : @"Complete"};
    [manager GET:str parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arry = responseObject[@"data"];
        if (_choice == 1) {
            
            _esay = [NSMutableArray array];
            for (NSDictionary *essay in arry) {
                ReadModel *model = [[ReadModel alloc]init];
                model.hp_title = essay[@"hp_title"];
                model.guide_word = essay[@"guide_word"];
                NSArray *arry = essay[@"author"];
                NSDictionary *auter = arry[0];
                model.user_name = auter[@"user_name"];
                model.content_id = essay[@"content_id"];
                [_esay addObject:model];
            }
        }else if (_choice == 2){
        _serial = [NSMutableArray array];
        for (NSDictionary *serial in arry) {
            ReadModel *model = [[ReadModel alloc]init];
            model.title = serial[@"title"];
            model.excerpt = serial[@"excerpt"];
            NSDictionary *author = serial[@"author"];
            model.user_name = author[@"user_name"];
            model.content_id = serial[@"id"];
            [_serial addObject:model];
        }
        }else if(_choice == 3){
        _question = [NSMutableArray array];
        for (NSDictionary *question in arry) {
            ReadModel *model = [[ReadModel alloc]init];
            model.question_title = question[@"question_title"];
            model.answer_title = question[@"answer_title"];
            model.answer_content = question[@"answer_content"];
            model.content_id = question[@"question_id"];
            [_question addObject:model];
        }
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
