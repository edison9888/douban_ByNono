//
//  NLMyHomeViewController.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-30.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMyHomeViewController.h"
#import "SlidingTabsControl.h"
#import "NLUserInfoView.h"
#import "NLDouban.h"
#import "NLMiniBlogData.h"
#import "NLMiniBlogInfo.h"
#import "NLMiniBlogCell.h"
#import "NLCommonHelper.h"
@interface NLMyHomeViewController ()
@property(retain,nonatomic)NLDouban *douban;
@end

@implementation NLMyHomeViewController
@synthesize contentView,tabV,data,miniArr,douban;

- (void)dealloc
{
    [contentView release];
    [tabV release];
    [data release];
    [douban release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initdata
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    self.miniArr = a;
    [a release];
}

- (void)initMyView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, 376)];
    tv.tag = 100;
    tv.dataSource = self;
    tv.delegate = self;
     self.tabV = tv;
    [self.view addSubview:tabV];
    [tv release];
    
}
- (void)viewDidLoad
{
    self.title = @"豆瓣广播";
   
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
    [overlayView setBackgroundColor:[UIColor colorWithRed:108.0/255.0f green:108.0/255.0f blue:108.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar addSubview:overlayView]; // navBar is your UINavigationBar instance
    [overlayView release];
    
    SlidingTabsControl* tabs = [[SlidingTabsControl alloc] initWithTabCount:2 delegate:self];
    [tabs selectedIndex:1];
    [self.view addSubview:tabs];
    
    
    [self initdata];
    [self initMyView];
    
    [super viewDidLoad];
    
    
    self.douban = [[NLDouban alloc]init];
    [douban getAuthorizationmFriendsMiniBlogWithData:nil delegate:self];
    [douban release];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.miniArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *identifier = @"cell";

    NLMiniBlogCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NLMiniBlogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NLMiniBlogInfo *info = [self.miniArr objectAtIndex:indexPath.row];
    
    cell.Time.text = [NLCommonHelper timeFormat:info.publishedTime];
    cell.title.text = info.title;
    cell.who.text = info.userName;

return cell;
}

#pragma mark - UITableViewDalegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -SlidingTabsControlDelegate methods
- (UILabel*) labelFor:(SlidingTabsControl*)slidingTabsControl atIndex:(NSUInteger)tabIndex
{
    UILabel* label = [[[UILabel alloc] init] autorelease];
    switch (tabIndex) {
        case 0:
            label.text = [NSString stringWithFormat:@"友邻广播", tabIndex+1];
            break;
            
        case 1:
            label.text = [NSString stringWithFormat:@"我的说说", tabIndex+1];
            break;
    }
    
    return label;
}


- (void) touchUpInsideTabIndex:(NSUInteger)tabIndex
{
    NSLog(@"tag is %d",tabIndex);
    
    switch (tabIndex) {
      
            
        case 1:{
            self.douban = [[NLDouban alloc]init];
            [douban getAuthorizationMiniBlogWithData:nil delegate:self];
            [douban release];
            break;
        }
        case 0:{
            self.douban = [[NLDouban alloc]init];
            [douban getAuthorizationmFriendsMiniBlogWithData:nil delegate:self];
            [douban release];
            break;
        }
    }
    
}


- (void) touchDownAtTabIndex:(NSUInteger)tabIndex
{
    
}

#pragma mark delagate methods
-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
    if (code == 200) {
        [self.data jsonString2Bean:response];
        NSArray *arr = [self.data arrInfo];
        [self.miniArr addObjectsFromArray:arr];
        [tabV reloadData];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
