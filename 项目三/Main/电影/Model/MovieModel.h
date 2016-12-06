//
//  MovieModel.h
//  项目三
//
//  Created by wxhl on 16/12/3.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject
@property(copy,nonatomic) NSString *cover;//图片
@property(copy,nonatomic) NSString *conten_id;//文章id
@property(copy,nonatomic) NSString *video;//文章图片
@property(copy,nonatomic) NSString *keywords;//五个lable内容
@property(copy,nonatomic) NSString *info;//人员介绍
@property(strong,nonatomic) NSArray *photo;//相关照片
@property(copy,nonatomic) NSString *charge_edt;//编辑
@property(copy,nonatomic) NSString *user_name;//作者
@property(copy,nonatomic) NSString *web_url;//头像
@property(copy,nonatomic) NSString *input_date;//时间
@property(copy,nonatomic) NSString *praisenum;//点赞数
@property(copy,nonatomic) NSString *title;//标题
@property(copy,nonatomic) NSString *content;//正文
@property(copy,nonatomic) NSString *score;//评论所给分数

@end
