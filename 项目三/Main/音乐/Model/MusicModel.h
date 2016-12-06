//
//  MusicModel.h
//  项目三
//
//  Created by wxhl on 16/11/30.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
@property (copy,nonatomic) NSString *cover;//图片
@property(copy,nonatomic)NSString *user_name;//歌手
@property(copy,nonatomic) NSString *web_url;//头像
@property(copy,nonatomic) NSString *summary;//乐队
@property(copy,nonatomic) NSString *maketime;//日期
@property(copy,nonatomic) NSString *title;//歌名
@property(copy,nonatomic) NSString *url;//网页
@property(copy,nonatomic) NSString *story;//故事
@property(copy,nonatomic) NSString *lyric;//歌词
@property(copy,nonatomic) NSString *info;//歌曲信息
@property(copy,nonatomic) NSString *story_author;//故事作者
@property(copy,nonatomic) NSString *story_title;//标题
@property(copy,nonatomic) NSString *charge_edt;//编辑
@property(copy,nonatomic) NSString *input_date;//评论时间
@property(copy,nonatomic) NSString *praisenum;//点赞数
@property(copy,nonatomic) NSString *content;//评论
@property(copy,nonatomic) NSString *music_id;//相应id

@end
