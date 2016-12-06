//
//  ReadModel.h
//  项目三
//
//  Created by wxhl on 16/11/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject
@property(copy,nonatomic)NSString *cover;//图片
@property(copy,nonatomic) NSString *hp_title;//esay标题
@property(copy,nonatomic) NSString *user_name;//作者名字
@property(copy,nonatomic) NSString *guide_word;//正文
@property(copy,nonatomic) NSString *title;//serial标题
@property(copy,nonatomic) NSString *excerpt;//正文
@property(copy,nonatomic) NSString *question_title;//question标题
@property(copy,nonatomic) NSString *answer_title;//提问者
@property(copy,nonatomic) NSString *answer_content;//回答
@property(copy,nonatomic) NSString *content_id;//文章编号
//短篇
@property(copy,nonatomic) NSString *hp_author;//作者
@property(copy,nonatomic) NSString *web_url;//头像
@property(copy,nonatomic) NSString *last_update_date;//日期
@property(copy,nonatomic) NSString *audio;//音乐
@property(copy,nonatomic) NSString *hp_content;//正文
@property(copy,nonatomic) NSString *hp_author_introduce;//编辑
@property(copy,nonatomic) NSString *auth_it;//出版
@property(copy,nonatomic) NSString *wb_name;//微博id
@property(copy,nonatomic) NSString *input_date;//日期
@property(copy,nonatomic) NSString *content;//评论内容
@property(copy,nonatomic) NSString *praisenum;//点赞次数
//连载
@property(copy,nonatomic) NSString *charge_edt;//编辑
@property(copy,nonatomic) NSString *summary;//工作
//问题
@property(copy,nonatomic) NSString *question_content;//问题内容
@property(copy,nonatomic) NSString *question_makettime;//时间


@end
