//
//  HomeModel.h
//  项目三
//
//  Created by wxhl on 16/11/24.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(copy,nonatomic) NSString *hp_img_original_url;//图片
@property(copy,nonatomic) NSString *hp_title;//编号
@property(copy,nonatomic) NSString *hp_author;//作者
@property(copy,nonatomic) NSString *hp_content;//文字
@property(copy,nonatomic) NSString *hp_makettime;//时间
@property(copy,nonatomic) NSString *praisenum;//点赞数

@end
