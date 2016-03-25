//
//  WeicoViewCell.h
//  CZWeico
//
//  Created by Charles on 15/5/12.
//  Copyright (c) 2015年 Charles. All rights reserved.
//

//WeiboCell
#define headImgTag          1
#define nameTag             2
#define dateSourceTag       3
#define textTag             4
#define weicoImgTag         5
#define oldTextTag          6
#define someSrcTag             7
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Weico.h"

@interface WeicoViewCell : UITableViewCell
@property (nonatomic,strong) NSArray *srcStringArray ;
@property (nonatomic,strong) UILabel *namelabel ;
@property (nonatomic,strong) UIImageView *headImgView ;
@property (nonatomic,strong) UILabel *sourcelabel ;
@property (nonatomic,strong) IBOutlet UILabel *textlabel ;
@property (nonatomic,strong) UILabel *oldTextlabel ;
@property (nonatomic,strong)  UIImageView *weicoImgView ;
@property (nonatomic,strong) UIView *someSrcView ;
@property (nonatomic,strong) Weico *weico ;


-(void)setUpCell:(Weico *)weiboModel ;
+(CGFloat)heightForDynamicCell:(NSString *)dynamic ;
@end
