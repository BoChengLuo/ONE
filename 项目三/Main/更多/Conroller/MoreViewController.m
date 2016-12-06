//
//  MoreViewController.m
//  项目三
//
//  Created by wxhl on 16/10/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "ThemeManager.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    UIAlertController *_alertcontr;
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    [self creatAlertcontrol];
    // Do any additional setup after loading the view.
}
-(void)creatTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.bounces = NO;
    _tableview.backgroundColor = [UIColor clearColor];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"关于我";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        
        MoreCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cel"];
        if (!cell) {
            cell = [[MoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        }

    if (indexPath.section == 1) {
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"缓存清理";
        cell.cachelable.text =[NSString stringWithFormat:@"%.2lfM",[self filepath]];
        cell.swich.hidden = YES;
    }else{
        cell.textLabel.text = @"主题切换";
        [cell.swich addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}
-(void)switchAction:(UISwitch *)sender{
    ThemeManager *manager = [[ThemeManager alloc]init];
    UISwitch *swic = sender;
    BOOL isswitch = [swic isOn];
    if (isswitch) {
        [manager notificationoff];
    }else{
        [manager notificationturn];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    }else if (indexPath.section == 1){
        [self presentViewController:_alertcontr animated:YES completion:nil];
    }else if (indexPath.section == 2){
    }
}
#pragma mark-------clearcache
//显示缓存大小
-(float)filepath{
    NSString * cachpath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachpath];
}
//计算单个文件大小
-(long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0;
}
//遍历文件夹，并计算返回大小
-(float)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator * childfiumerat = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * filname;
    long long folderSize = 0;
    while ((filname = [childfiumerat nextObject]) != nil) {
        NSString * fileabsoPath = [folderPath stringByAppendingPathComponent:filname];
        folderSize += [self fileSizeAtPath:fileabsoPath];
    }
    return folderSize/(1024.0*1024.0);
}
//清理
-(void)clearCeache{
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray * files = [[NSFileManager defaultManager]subpathsAtPath:cachPath];
    for (NSString * pa in files) {
        NSError * error = nil;
        NSString *path = [cachPath stringByAppendingPathComponent:pa];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
    [self performSelectorOnMainThread:@selector(clearSuccess) withObject:nil waitUntilDone:YES];
}
-(void)clearSuccess{
    
}
#pragma mark----alert
-(void)creatAlertcontrol{
    _alertcontr = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"是否清理缓存" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clearCeache];
        [_tableview reloadData];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_tableview reloadData];
    }];
    [_alertcontr addAction:okAction];
    [_alertcontr addAction:cancel];
    
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
