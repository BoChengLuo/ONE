//
//  ImagineTableViewCell.m
//  项目三
//
//  Created by wxhl on 16/11/11.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ImagineTableViewCell.h"

@implementation ImagineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
        _view.layer.borderColor = [UIColor cyanColor].CGColor;
        _view.layer.borderWidth = 2.0f;
        [self.contentView addSubview:_view];
        _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, (KscreenWidth-10)/3, 95)];
        _lable1.textAlignment = NSTextAlignmentCenter;
        _lable1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lable1];
        _lable2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lable1.frame), 5, (KscreenWidth-10)/3, 95)];
        _lable2.textAlignment = NSTextAlignmentCenter;
        _lable2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lable2];
        _lable3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lable2.frame), 5, (KscreenWidth-10)/3, 95)];
        _lable3.textAlignment = NSTextAlignmentCenter;
        _lable3.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lable3];
        _lable4 = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_lable1.frame), (KscreenWidth-10)/2, 95)];
        _lable4.textAlignment = NSTextAlignmentCenter;
        _lable4.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lable4];
        _lable5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lable4.frame), CGRectGetMaxY(_lable1.frame), (KscreenWidth-10)/2, 95)];
        _lable5.textAlignment = NSTextAlignmentCenter;
        _lable5.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lable5];
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
        [self.contentView addSubview:_scrollview];
        _lable6 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 200)];
        _lable6.font = [UIFont systemFontOfSize:13];
        _lable6.numberOfLines = 0;
        _lable6.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_lable6];

    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    [self drawShapeRect];
    [self drawLine];
    [self drawLine1];
    [self drawLine2];
    [self drawLine3];

}
-(void)drawShapeRect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10));
    [[UIColor cyanColor] setStroke];
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}
-(void)drawLine{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 5, self.bounds.size.height/2);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width - 5, self.bounds.size.height/2);
    CGContextAddPath(context, path);
    [[UIColor cyanColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}
-(void)drawLine1{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, (KscreenWidth - 10) / 3 + 5, 5);
    CGPathAddLineToPoint(path, NULL, (KscreenWidth - 10)/3 + 5, self.bounds.size.height/2);
    CGContextAddPath(context, path);
    [[UIColor cyanColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}
-(void)drawLine2{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, (KscreenWidth - 10)/3 * 2 +5, 5);
    CGPathAddLineToPoint(path,NULL, (KscreenWidth -10)/3 *2 +5, self.bounds.size.height/2);
    CGContextAddPath(context, path);
    [[UIColor cyanColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}
-(void)drawLine3{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, (KscreenWidth - 10)/2 +5, self.bounds.size.height/2);
    CGPathAddLineToPoint(path, NULL, (KscreenWidth - 10)/2 + 5, self.bounds.size.height - 5);
    CGContextAddPath(context, path);
    [[UIColor cyanColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
