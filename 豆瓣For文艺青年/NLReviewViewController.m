//
//  NLReviewViewController.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-2.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLReviewViewController.h"
#import "TBXML.h"
#import "NLRssInfo.h"
#import "NLRSSData.h"
#import "NLReviewCell.h"
#import "UIImageView+NLDispatchLoadImage.h"
#import "NLReviewDetailViewController.h"
@interface NLReviewViewController ()

@end

@implementation NLReviewViewController
@synthesize dataArr,douban;
- (void)dealloc
{
    [dataArr release];
    [douban release];
    [super dealloc];
}
-(void) fetchNet
{
    
    [douban RssReviewWithTag:currentTAG delegate:self];
    
}

- (void)initData
{
    currentTAG = @"latest";
    intTag = 0;
    self.dataArr = [NSMutableArray array];
    self.douban = [[NLDouban alloc]init];
    [douban release];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.title = @"评论TOP20";
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
    [overlayView setBackgroundColor:[UIColor colorWithRed:108/255.0f green:108.0/255.0f blue:108.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar addSubview:overlayView]; // navBar is your UINavigationBar instance
    [overlayView release];
    
    SlidingTabsControl* tabs = [[SlidingTabsControl alloc] initWithTabCount:4 delegate:self];
    [tabs selectedIndex:1];
    [self.view addSubview:tabs];
    
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, 376)];
    tv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tv.tag = 100;
    tv.dataSource = self;
    tv.delegate = self;
    tabV = tv;
    [self.view addSubview:tabV];
    
    [self fetchNet];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - slid
- (UILabel*) labelFor:(SlidingTabsControl*)slidingTabsControl atIndex:(NSUInteger)tabIndex
{
    UILabel* label = [[[UILabel alloc] init] autorelease];
    switch (tabIndex) {
        case 0:
            label.text = [NSString stringWithFormat:@"最新评论", tabIndex+1];
            break;
            
        case 1:
            label.text = [NSString stringWithFormat:@"最新书评", tabIndex+1];
            break;
        case 2:
            label.text = [NSString stringWithFormat:@"最新影评", tabIndex+1];
            break;
            
        case 3:
            label.text = [NSString stringWithFormat:@"最新乐评", tabIndex+1];
            break;
    }
    
    return label;
    
}
- (void) touchUpInsideTabIndex:(NSUInteger)tabIndex
{
    if (intTag ==tabIndex)
        return;
    [self.dataArr removeAllObjects];
    [tabV reloadData];
    intTag = tabIndex;
    
    switch (tabIndex) {
        case 0:
            currentTAG = @"latest";
            break;
            
        case 1:
            currentTAG = @"book";
            break;
        case 2:
            
            currentTAG = @"movie";
            break;
        case 3:
            
            currentTAG = @"music";
            break;
    }
    
[self fetchNet ];
}
- (void) touchDownAtTabIndex:(NSUInteger)tabIndex
{
    
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *identifier = @"reCell";
    
    NLReviewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NLReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NLRssInfo *info = [self.dataArr objectAtIndex:indexPath.row];
    
    cell.title.text= info.title;
    cell.who.text = info.dc_creator;
    cell.content.text = info.description;
    cell.Time.text  = info.pubDate;
    NSString *imgrsc = info.img;
    [cell.imageV setImageFromUrl:imgrsc];
    
    return cell;
}

#pragma mark - UITableViewDalegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NLRssInfo *info = [self.dataArr objectAtIndex:indexPath.row];
    
    NLReviewDetailViewController *vc = [[NLReviewDetailViewController alloc] init];
    vc.reviewId = info.link;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}


#pragma mark delagate methods
-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
    if (code == 200) {
      //  NSLog(response);
        NLRSSData *data = [[NLRSSData alloc]init];
        BOOL b = [data parser:response];
        if (b) {
            self.dataArr =  data.rssArr;
        }
        [data release];
        [tabV reloadData];
    }
}

////递归子方法
//- (void)recurrence:(TBXMLElement *)element {
//    
//    NSString *eleName = [TBXML elementName:element]; 
//    NSString *eleText = [TBXML textForElement:element];
//    if ([eleName isEqualToString:@"item"]) {
//        self recurrence:element
//    }
//    
//    
//    
//    
//    do {
//        
//        NSString *eleName = [TBXML elementName:element]; 
//        NSString *eleText = [TBXML textForElement:element]; 
//        
//        //递归处理子树
//        if (element->firstChild) {
//            NSLog(@"<%@>:",eleName);// Display the name of the element
//            
//            [self recurrence:element->firstChild];
//        }else {
//            NSLog(@"<%@>:%@",eleName,eleText);// Display the name of the element
//            
//            TBXMLElement *parent = element->parentElement;
//            if ([[TBXML elementName:parent] isEqualToString:@"item"]) {
//                NLRssInfo *info = [[[NLRssInfo alloc]init] autorelease];
//                
//                if ([eleName isEqualToString:@"title"]) {
//                    info.title = eleText; 
//                }
//                
//                
//                [dataArr addObject:info];
//            }
//            
//        }
//        
//        
//        //迭代处理兄弟树
//    } while ((element = element->nextSibling));
//}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
