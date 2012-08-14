//
//  NLAboutViewController.h
//  豆瓣骚年
//
//  Created by Nono on 12-8-14.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLAboutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tabV;
}
@property(retain,nonatomic)UITableView *_tabV;

@end
