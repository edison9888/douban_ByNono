//
//  NLReviewDetailViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLReviewDetailViewController.h"

@interface NLReviewDetailViewController ()

@end

@implementation NLReviewDetailViewController
@synthesize reviewId,douban;
- (void)dealloc
{
    [reviewId release];
    [douban release];
    [super dealloc];
}


-(void) fetchNet
{
    
    [douban ReViewDetailById:reviewId delegate:nil];
    
}

- (void)initData
{
    self.douban = [[NLDouban alloc]init];
    [douban release];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.title = @"评论详情";
    
    
    
    [self fetchNet];
    
	// Do any additional setup after loading the view.
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
