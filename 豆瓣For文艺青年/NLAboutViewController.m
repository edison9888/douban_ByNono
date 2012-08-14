//
//  NLAboutViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-14.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLAboutViewController.h"

@interface NLAboutViewController ()

@end

@implementation NLAboutViewController
@synthesize _tabV;

- (void)dealloc
{
    [_tabV release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    self._tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tabV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    [self.view addSubview:_tabV];
    [_tabV release];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *str = @"cell";
    UITableViewCell *cell ;
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = @"测试";

    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
