//
//  MusicViewController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicZeroTableViewCell.h"
#import "MusicOneTableViewCell.h"
#import "MusicOtherTableViewCell.h"
#import "ListMusicViewController.h"
#import "MusicModel.h"

@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate>
{
    UITableView *_tableview;
    UISwipeGestureRecognizer *_swipe1;
    UISwipeGestureRecognizer *_swipe2;
    NSArray *datacount;
    NSMutableArray *musicmodel;
    NSMutableArray *comenmodel;
    CGFloat height1;
    CGFloat height2;
    NSString *textring;
    UIView *_view;
    UIActivityIndicatorView *_actiview;
    UIActivityIndicatorView *_musicview;
    UIView *_musview;
}
@property(assign,nonatomic)CGFloat height;

@end
static NSInteger A = 0;
static NSInteger B = 1;
@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self requestDataCount];
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.backgroundColor  = [UIColor clearColor];
    //    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
    _swipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(Actionswipe:)];
    _swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(Actionswipe:)];
    _swipe2.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_swipe2];
    [self.view addGestureRecognizer:_swipe1];
    _view = [[UIView alloc]initWithFrame:self.view.bounds];
    _view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view];
    _actiview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actiview.frame = CGRectMake(0, 0, 100, 100);
    _actiview.center = _view.center;
    [_view addSubview:_actiview];
    [_actiview startAnimating];
}
-(void)Actionswipe:(UISwipeGestureRecognizer *)swipe{
    if (swipe == _swipe1) {
        if (A > 0 && A < datacount.count) {
            
            CATransition *transition = [[CATransition alloc]init];
            transition.type = @"rippleEffect";
            transition.duration = 0.5;
            [self.view.layer addAnimation:transition forKey:nil];
            A--;
            _view.hidden = NO;
            [_actiview startAnimating];
            [self requestDataCount];
        }
    }else if(swipe == _swipe2){
        if (A >= 0 && A <= datacount.count) {
            A++;
            if (A < datacount.count) {
                
                CATransition *transition = [[CATransition alloc]init];
                transition.type = @"rippleEffect";
                transition.duration = 0.5;
                [self.view.layer addAnimation:transition forKey:nil];
                _view.hidden = NO;
                [_actiview startAnimating];
                [self requestDataCount];
            }
            if (A == datacount.count) {
                A--;
                ListMusicViewController *contr = [[ListMusicViewController alloc]init];
                contr.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:contr animated:YES];
            }
        }

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:1 inSection:0];
    if (indexPath == index1) {
        MusicZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        //    cell.backgroundColor = [UIColor cyanColor];
        if ( !cell) {
            cell = [[MusicZeroTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        MusicModel *model;
        if (musicmodel.count > 0) {
            model = musicmodel[index1.row];
        }
        NSURL *url =[NSURL URLWithString:model.cover];
        [cell.imageview setImageWithURL:url];
        NSURL *heard = [NSURL URLWithString:model.web_url];
        [cell.heardview setImageWithURL:heard];
        cell.auter.text = model.user_name;
        [cell.auter sizeToFit];
        cell.abaut.text = model.summary;
        [cell.abaut sizeToFit];
        NSDateFormatter *dateform = [[NSDateFormatter alloc]init];
        [dateform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateform dateFromString:model.maketime];
        [dateform setDateFormat:@"MMM.dd.yyyy"];
        NSString *time = [dateform stringFromDate:date];
        cell.datatime.text = time;
        [cell.datatime sizeToFit];
        cell.list.text = model.title;
        [cell.list sizeToFit];
        self.height = cell.cellheight;
        [cell.text addTarget:self action:@selector(ActionButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.text.tag = 201;
        [cell.lyrics addTarget:self action:@selector(ActionButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.lyrics.tag = 202;
        [cell.mation addTarget:self action:@selector(ActionButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.mation.tag = 203;
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if(indexPath == index2){
        MusicOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        //    cell.backgroundColor = [UIColor cyanColor];
        if ( !cell) {
            cell = [[MusicOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        MusicModel *model;
        if (musicmodel.count > 0) {
            model = musicmodel[index2.section];
        }
        cell.webview.delegate = self;
        NSURL *url = [NSURL URLWithString:model.url];
        cell.webview.scrollView.bounces = NO;
        cell.webview.scrollView.scrollEnabled = NO;
        if (B != 2) {
            cell.view.hidden = NO;
            [cell.acwebview startAnimating];
            _musicview = cell.acwebview;
            _musview = cell.view;
            [cell.webview loadRequest:[NSURLRequest requestWithURL:url]];
        }
        cell.auter.text = model.story_author;
        [cell.auter sizeToFit];
        cell.list.text = model.story_title;
        [cell.list sizeToFit];
        cell.text.text = textring;
        [cell.text setUserInteractionEnabled:NO];
        [cell.text sizeToFit];
        CGRect rect = [textring boundingRectWithSize:CGSizeMake(KscreenWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.2]} context:nil];
        CGRect frame = cell.text.frame;
        frame.size.height = rect.size.height;
        frame.size.width = rect.size.width;
        cell.text.frame = frame;
        cell.editor.text = model.charge_edt;
        [cell.editor sizeToFit];
        CGRect editor = cell.editor.frame;
        editor.origin.y = CGRectGetMaxY(frame);
        cell.editor.frame = editor;
        height1 = rect.size.height;
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        MusicOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        //    cell.backgroundColor = [UIColor cyanColor];
        if ( !cell) {
            cell = [[MusicOtherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        }
        MusicModel *model;
        if (comenmodel.count > 0) {
            model = comenmodel[indexPath.section - 1];
        }
        NSURL *url = [NSURL URLWithString:model.web_url];
        [cell.imageview setImageWithURL:url];
        cell.auter.text = model.user_name;
        [cell.auter sizeToFit];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateformat dateFromString:model.input_date];
        [dateformat setDateFormat:@"yyyy.MM.dd"];
        NSString *time = [dateformat stringFromDate:date];
        cell.datatime.text = time;
        [cell.datatime sizeToFit];
        cell.listen.text = model.praisenum;
        [cell.listen sizeToFit];
        cell.list.text = model.content;
        cell.list.numberOfLines = 0;
        CGRect rect = [model.content boundingRectWithSize:CGSizeMake(KscreenWidth -20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        CGRect frame = cell.list.frame;
        frame.size.width = rect.size.width;
        frame.size.height = rect.size.height;
        cell.list.frame = frame;
        height2 = rect.size.height;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return comenmodel.count + 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 45;
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
        return self.height;
    }else if (indexPath == index1){
        return KscreenHeight/2 - 50 + height1 + 106;
    }else{
    return height2 + 90;
    }
}

#pragma mark------------requestData
-(void)requestDataCount{
    NSString *urltring = @"http://v3.wufazhuce.com:8000/api/music/idlist/0?version=v3.5.3&platform=ios&user_id=";
    NSString *url = [urltring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        datacount = responseObject[@"data"];
        [self reuqestDta];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _view.hidden = NO;
        [_musicview stopAnimating];
    }];
}
-(void)reuqestDta{
    if (datacount.count > 0) {
        musicmodel = [NSMutableArray array];
        NSString * string = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/music/detail/%@?version=v3.5.3&platform=ios&user_id=",datacount[A]];
        NSString *url = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            MusicModel *model = [[MusicModel alloc]init];
            NSDictionary *data = responseObject[@"data"];
            model.cover = data[@"cover"];
            NSDictionary *author = data[@"author"];
            model.web_url = author[@"web_url"];
            model.user_name = author[@"user_name"];
            model.summary = author[@"summary"];
            model.title = data[@"title"];
            model.maketime = data[@"maketime"];
            model.url = data[@"web_url"];
            NSAttributedString *attibu = [[NSAttributedString alloc] initWithData:[data[@"story"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            model.story = attibu.string;
            model.lyric = data[@"lyric"];
            model.info = data[@"info"];
            NSDictionary *story_author = data[@"story_author"];
            model.story_author = story_author[@"user_name"];
            model.story_title = data[@"story_title"];
            model.charge_edt = data[@"charge_edt"];
            textring = attibu.string;
            [musicmodel addObject:model];
            [_tableview reloadData];
            _view.hidden = YES;
            [_actiview stopAnimating];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        NSString *coment = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/music/%@/0?version=v3.5.3&platform=ios&user_id=",datacount[A]];
        NSString *comentring = [coment stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [manager GET:comentring parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *data = responseObject[@"data"];
            NSArray *arry = data[@"data"];
            comenmodel = [NSMutableArray array];
            for (NSDictionary *dic in arry) {
                MusicModel *model = [[MusicModel alloc]init];
                NSDictionary *user = dic[@"user"];
                model.user_name = user[@"user_name"];
                model.web_url = user[@"web_url"];
                model.input_date = dic[@"input_date"];
                model.praisenum = [NSString stringWithFormat:@"%@",dic[@"praisenum"]];
                model.content = dic[@"content"];
                [comenmodel addObject:model];
            }
            [_tableview reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_musicview stopAnimating];
    _musview.hidden = YES;
}
-(void)ActionButton:(UIButton *)sender{
    MusicModel *model = musicmodel[0];
    if (sender.tag == 201) {
        B = 2;
        textring = model.story;
        [_tableview reloadData];
    }else if (sender.tag == 202){
        B = 2;
        textring = model.lyric;
        [_tableview reloadData];
    }else if(sender.tag == 203){
        B = 2;
        textring = model.info;
        [_tableview reloadData];
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

