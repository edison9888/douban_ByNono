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
#import "EGORefreshTableHeaderView.h"
@class NLFriendsShuoShuoData;
@interface NLMyHomeViewController : UIViewController<SlidingTabsControlDelegate,UITableViewDelegate,UITableViewDataSource,NLDoubanRequestDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *tabV;
    NLUserInfoView *contentView;
    NLFriendsShuoShuoData *data;
    
    EGORefreshTableHeaderView *refresView;
    NSMutableArray *miniArr;
    BOOL isLoading;
    
}
@property(retain,nonatomic)UITableView *tabV;
@property(retain,nonatomic)NLUserInfoView *contentView;
@property(retain,nonatomic)NLFriendsShuoShuoData *data;
@property(retain,nonatomic)NSMutableArray *miniArr;
@property(retain,nonatomic) EGORefreshTableHeaderView *refresView;
@end
