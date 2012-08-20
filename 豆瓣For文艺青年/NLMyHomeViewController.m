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
#import "NLFriendsShuoInfo.h"
#import "NLFriendsShuoShuoData.h"
#import "UIImageView+NLDispatchLoadImage.h"
@interface NLMyHomeViewController ()
@property(retain,nonatomic)NLDouban *douban;
@end

@implementation NLMyHomeViewController
@synthesize contentView,tabV,data,miniArr,douban,refresView;

- (void)dealloc
{
    [contentView release];
    [tabV release];
    [data release];
    [douban release];
    [refresView release];
    [super dealloc];
}

- (void)fetchFriendsMiniBlog
{
    if (!douban) {
        self.douban = [[NLDouban alloc]init];
        [douban release];
    }
    self.data = [[NLFriendsShuoShuoData alloc] init];
    [data release];
    isLoading = YES;
    [douban getAuthorizationmFriendsMiniBlogWithData:nil delegate:self];
    
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
    [tv setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:tabV];
    [tv release];
    
    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tv.bounds.size.height, self.view.frame.size.width, tv.bounds.size.height)];
    view.delegate = self;
    [tv addSubview:view];
    self.refresView = view;
    [view release];
    
}
- (void)viewDidLoad
{  [super viewDidLoad];
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
    
    [self fetchFriendsMiniBlog];
    
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.miniArr.count;
}


- (void)cellReset:(NLMiniBlogCell*)cell
{
   
    cell.imageV.image = nil;
    cell.imageV.backgroundColor = [UIColor blueColor];
    
    cell.who.text = nil;
    cell.short_title.text = nil;
    cell.title.text = nil;
    cell.content.text = nil;
    cell.text.text = nil;
}
-(void)computerCellFrame:(NLMiniBlogCell *)cell content:(NLFriendsShuoInfo*)info
{
    [self cellReset:cell];
    CGFloat xPos = 45;
    CGFloat yPos = 5;
    CGFloat bgY = 5;
    CGFloat enY = 5;
    [cell.imageV setImageFromUrl:info.userImageLink];
    
    
    NSString *who = info.username;
    CGSize size = CGSizeMake(320,2000);
    CGSize Wholasize = [who sizeWithFont:cell.who.font constrainedToSize:size];
    [cell.who setFrame:CGRectMake(xPos, 5, Wholasize.width, Wholasize.height)];
    cell.who.text = who;
    
    
      xPos += Wholasize.width;
    xPos += 5;
    
    yPos += Wholasize.height;
    yPos += 5;
    bgY = yPos;
    
    NSString *short_title = info.short_title;
    CGSize short_title_size = [short_title sizeWithFont:cell.short_title.font constrainedToSize:size];
    [cell.short_title setFrame:CGRectMake(xPos, 5, short_title_size.width, short_title_size.height)];
    cell.short_title.text = short_title;
    
    
    NSString *title = info.title;
    CGSize title_size = [title sizeWithFont:cell.title.font constrainedToSize:CGSizeMake(260, 2000)];
    [cell.title setFrame:CGRectMake(50, yPos, title_size.width, title_size.height)];
    cell.title.text = title;
    
      title_size.height > 0 ? yPos += title_size.height+5:yPos;
    
    NSString *content = info.content;
    CGSize content_size = [content sizeWithFont:cell.content.font constrainedToSize:CGSizeMake(260, 2000)];
    [cell.content setFrame:CGRectMake(50, yPos, content_size.width, content_size.height)];
    cell.content.text = content;
    
    
    content_size.height > 0 ? yPos += content_size.height+5:yPos;   
    [cell.contentGg setFrame:CGRectMake(45, bgY, 270, yPos - bgY)];
    

    NSString *text = info.text;
    CGSize text_size = [text sizeWithFont:cell.text.font constrainedToSize:CGSizeMake(260, 2000)];   
    [cell.text setFrame:CGRectMake(50, yPos, text_size.width, text_size.height)];
    cell.text.text = text;

//     NSLog(@"布局后高度为：：%f",i);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *identifier = @"cell";

    NLMiniBlogCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NLMiniBlogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    
    NLFriendsShuoInfo *info = [self.miniArr objectAtIndex:indexPath.row];
    [self computerCellFrame:cell content:info];
    return cell;
}

-(CGFloat)computerHeight:(NLFriendsShuoInfo*)info
{
    CGFloat h = 0;
    CGSize size ;
    size = CGSizeMake(320,2000);
    UIFont *font;
    
    h+=5;
    font =[UIFont systemFontOfSize:13];
    NSString *who = info.username;
    CGSize Wholasize = [who sizeWithFont:font constrainedToSize:size];
    h+= Wholasize.height;
    
    h+=5;
    size = CGSizeMake(260, 2000);
    font =[UIFont systemFontOfSize:14];
    NSString *title = info.title;
    CGSize titlesize = [title sizeWithFont:font constrainedToSize:size];
    h+= titlesize.height;
    
    h+= 5;
    font =[UIFont systemFontOfSize:12];
    NSString *content = info.content;
    CGSize contentsize = [content sizeWithFont:font constrainedToSize:size];
    h+= contentsize.height;
    h+= 5;
    
    font =[UIFont systemFontOfSize:13];
    NSString *text= info.text;
    CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(260, 2000)];
    h+= textSize.height;
    h+= 5;
    
    NSLog(@"高度为：：%f",h);
    return h;
}

#pragma mark - UITableViewDalegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self computerHeight:[self.miniArr objectAtIndex:indexPath.row]];
    return h;
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
    isLoading = NO;
    if (code == 200) {
        [self.data jsonString2Bean:response];
        NSArray *arr = [self.data arrInfo];
        [self.miniArr addObjectsFromArray:arr];
        [tabV reloadData];
    }
    [refresView egoRefreshScrollViewDataSourceDidFinishedLoading:tabV];
}


#pragma mark - EGO deleagteMethods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{//实现触发刷新操作
   
    [self fetchFriendsMiniBlog];
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{//返回loading状态
    return isLoading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{//返回刷新时间
    return [NSDate date];
    
}

#pragma mark - scrollView delegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView          //scrollview拖动时 调用ego。。。。view中的方法
{
    [refresView  egoRefreshScrollViewDidScroll:scrollView];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate   //结束拖动的时候 调用ego。。。view中的方法
{
    [refresView egoRefreshScrollViewDidEndDragging:scrollView];
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
