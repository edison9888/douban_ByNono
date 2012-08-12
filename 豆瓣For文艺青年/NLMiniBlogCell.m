//
//  NLMiniBlogCell.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMiniBlogCell.h"

@implementation NLMiniBlogCell
@synthesize imageV,title,Time,who;

- (void)dealloc
{
    [imageV release];
    [Time release];
    [title release];
    [who release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        // Initialization code
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 53, 53)];
        [self.contentView addSubview:imageV];
        [imageV release];
      
        self.who = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 100, 20)];
        who.font = [UIFont systemFontOfSize:15];
        who.textColor = [UIColor redColor];
        [self.contentView addSubview:who];
        [who release];
        
        
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 240, 50)];
        title.font = [UIFont systemFontOfSize:13];
        title.numberOfLines =0; //this is used to determine how many lines this label will have.if =3,it means this  label's text will show 3 lines.if =0 ,it means that this label's text will show the line whate it needs.no limit.
        title.lineBreakMode = UILineBreakModeWordWrap;// sys will change the line by word.aslo can be by character  for another value. 
        [self.contentView addSubview:title];
        [title release];
        
        
        self.Time = [[UILabel alloc]initWithFrame:CGRectMake(200, 80, 100, 20)];
        Time.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:Time];
        [Time release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
