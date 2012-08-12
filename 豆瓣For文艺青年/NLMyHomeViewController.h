//
//  NLMyHomeViewController.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-30.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "SlidingTabsControl.h"
#import "NLUserInfoView.h"
#import "NLDouban.h"
#import "NLMiniBlogData.h"
@interface NLMyHomeViewController : UIViewController<SlidingTabsControlDelegate,UITableViewDelegate,UITableViewDataSource,NLDoubanRequestDelegate>
{
    UITableView *tabV;
    NLUserInfoView *contentView;
    NLMiniBlogData *data;
    
    NSMutableArray *miniArr;
    
}
@property(retain,nonatomic)UITableView *tabV;
@property(retain,nonatomic)NLUserInfoView *contentView;
@property(retain,nonatomic)NLMiniBlogData *data;
@property(retain,nonatomic)NSMutableArray *miniArr;

@end
