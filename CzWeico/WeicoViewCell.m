//
//  WeicoViewCell.m
//  CZWeico
//
//  Created by Charles on 15/5/12.
//  Copyright (c) 2015年 Charles. All rights reserved.
//

#import "WeicoViewCell.h"
#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "Weico.h"
#import "UserModel.h"


@implementation WeicoViewCell
#define CELL_CONTENT_MARGIN     10.0f
#define CELL_CONTENT_WIDTH 320.0f
#define FONT_SIZE_14            14




-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if(self){
                  }
    return self ;

}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * resultImage = [[UIImage alloc] init];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    resultImage = [UIImage imageWithData:data];
    return resultImage;
}


-(void)setUpCell:(Weico *)weibo
{
    //=======================User===================//
    //图片
    if(weibo!=nil){
    CGRect imgRect = CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, 40.0f, 40.0f) ;
    _headImgView = [[UIImageView alloc] initWithFrame:imgRect] ;
    _headImgView.tag = headImgTag ;
    //为图片添加边框
    CALayer *layer = [_headImgView layer] ;
    layer.cornerRadius = 8;
    layer.borderColor = [[UIColor whiteColor]CGColor];
    layer.borderWidth = 1;
    layer.masksToBounds = YES;
    _headImgView.image = [UIImage imageNamed:@"navigationbar_search_voice_hl"];
    [self.contentView addSubview:_headImgView];
    
    //名字
    CGRect nameRect = CGRectMake(60, 10, 100, 20) ;
    
    _namelabel = [[UILabel alloc] initWithFrame:nameRect];
    _namelabel.tag = nameTag;
    _namelabel.font = [UIFont systemFontOfSize:13];
    //UserModel *user  = weibo.user;
    //[_namelabel setText:user.name];
    [_namelabel setText:@"Charles"];
    [self.contentView addSubview:_namelabel] ;
    
    //Source
    CGRect sourceRect = CGRectMake(60, 30, 100, 20) ;
    _sourcelabel = [[UILabel alloc] initWithFrame:sourceRect];
    _sourcelabel.tag = dateSourceTag;
    _sourcelabel.font = [UIFont systemFontOfSize:9];
    [_sourcelabel setText:@"来自星星客户端！"];
    [self.contentView addSubview:_sourcelabel];
    
    //低栏高度设置
    CGFloat yHeight = 0.0 ;
    
    //text
    //CGRect textRect = CGRectMake(10, 45, 320, 40) ;
    _textlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textlabel.tag = textTag;
    _textlabel.font = [UIFont systemFontOfSize:14];
    _textlabel.numberOfLines = 0;
    _textlabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textlabel.backgroundColor = [UIColor clearColor];
    [_textlabel setText:@"Hello world"];
    [self.contentView addSubview:_textlabel];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_WIDTH*2), MAXFLOAT);
    CGSize size = [@"Hello world" sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
   
    yHeight = _textlabel.frame.origin.y+ _textlabel.frame.size.height ;
    
    if(weibo.oldWeibo!=nil){
    //if(1==1){
        NSString *retwitterContentText = [NSString stringWithFormat:@"%@:@%",weibo.oldWeibo.user.name,weibo.oldWeibo.text] ;
       // CGRect oldTextRect = CGRectMake(10, 80, 320, 40) ;
        _oldTextlabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _oldTextlabel.tag = oldTextTag;
        _oldTextlabel.font = [UIFont systemFontOfSize:14];
        _oldTextlabel.numberOfLines = 0;
        _oldTextlabel.lineBreakMode = UILineBreakModeWordWrap;
        _oldTextlabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_oldTextlabel];
        
        
        CGSize textSize =CGSizeMake(CELL_CONTENT_WIDTH-(CELL_CONTENT_MARGIN*2), MAXFLOAT) ;
        CGSize size = [retwitterContentText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_14] constrainedToSize:textSize lineBreakMode:NSLineBreakByCharWrapping ];
         _oldTextlabel.Text = retwitterContentText ;
        [_oldTextlabel setFrame:CGRectMake(6, _textlabel.frame.origin.y+_textlabel.frame.size.height+CELL_CONTENT_MARGIN,
                                           CELL_CONTENT_WIDTH, size.height)];
        
        if(weibo.pic_urls.count>0){
            
            _weicoImgView= [[UIImageView alloc] initWithFrame:CGRectZero];
            __block UIImage *retwitterImage = [[UIImage alloc] init];
            
            NSString *urlStr =weibo.pic_urls[0];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                _weicoImgView = [self getImageFromURL:urlStr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    CGSize retwitterImageSize = CGSizeMake(retwitterImage.size.width, retwitterImage.size.height);
                    [_weicoImgView setFrame:CGRectMake((CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN *2) - retwitterImageSize.width)/2, _oldTextlabel.frame.origin.y + _oldTextlabel.frame.size.height + CELL_CONTENT_MARGIN, retwitterImageSize.width, retwitterImageSize.height)];
                    [_weicoImgView setImage:retwitterImage];
                    [[self contentView] addSubview:_weicoImgView];
                });
            });
            yHeight += 120;
        
        }else{
            if(weibo.pic_urls.count>0){
                    _weicoImgView= [[UIImageView alloc] initWithFrame:CGRectZero];
                    __block UIImage *retwitterImage = [[UIImage alloc] init];
                    //NSString *urlStr =weibo.pic_urls[0];
                    NSString *urlStr =@"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg";
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        _weicoImgView = [self getImageFromURL:urlStr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            CGSize retwitterImageSize = CGSizeMake(retwitterImage.size.width, retwitterImage.size.height);
                            [_weicoImgView setFrame:CGRectMake((CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN *2) - retwitterImageSize.width)/2, _textlabel.frame.origin.y + _textlabel.frame.size.height + CELL_CONTENT_MARGIN, retwitterImageSize.width, retwitterImageSize.height)];
                            [_weicoImgView setImage:retwitterImage];
                            [[self contentView] addSubview:_weicoImgView];
                        });
                    });
                    yHeight += 120;
            }
        }
        yHeight +=CELL_CONTENT_MARGIN ;
    }
}

    //=======================User===================//
    //simple weicoImg
    CGRect weicoImgRect = CGRectMake(10, 110, 100, 100) ;
    _weicoImgView = [[UIImageView alloc] initWithFrame:weicoImgRect] ;
    _weicoImgView.tag = weicoImgTag;
    [self.contentView addSubview:_weicoImgView];
    
    //多个微博图片
    CGRect someSrcRect = CGRectMake(0, 110, 320, 200) ;
    _someSrcView = [[UIView alloc] initWithFrame:someSrcRect] ;
    SDPhotoGroup *photoGroup = [[SDPhotoGroup alloc] initWithFrame:someSrcRect] ;
    photoGroup.tag = someSrcTag;
    [_someSrcView addSubview:photoGroup] ;
    [self.contentView addSubview:_someSrcView] ;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.textlabel.frame);
}


- (void)awakeFromNib {
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
