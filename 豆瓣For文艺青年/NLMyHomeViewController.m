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
@end

@implementation NLMyHomeViewController
@synthesize contentView,tabV,data,miniArr;

- (void)dealloc
{
    [contentView release];
    [tabV release];
    [data release];
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
//    tabV.hidden = YES;
    [self.view addSubview:tabV];
    [tv release];
    
    
//    NLUserInfoView *uv = [[NLUserInfoView alloc]initWithFrame:CGRectMake(0,40, 320, 376)];
//    
//    self.contentView = uv;
//    uv.nameLabel.text = @"我不是二当家";
//    uv.addressLabel.text = @"常住:北京";
//    [uv release];    
//    //初始化下加载content;
//    [self.view addSubview:contentView];
    
}
- (void)viewDidLoad
{
    self.title = @"豆瓣广播";
   
//    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
//    self.navigationController.navigationItem.backBarButtonItem.title = @"Back";
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
    
    
    NLDouban *douban = [[NLDouban alloc]init];
   [douban getAuthorizationmFriendsMiniBlogWithdelegate:self];
   
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
//           UIView * self.view viewWithTag:@"100";
            
//            if (tabV.hidden == YES) {
//                tabV.hidden = NO;
//                contentView.hidden = YES;
//            }
//            [tabV reloadData];
            
            break;
        }
        case 0:{
//            
//            if (contentView.hidden == YES) {
//                contentView.hidden = NO;
//                tabV.hidden = YES;
//            }
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
