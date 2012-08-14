//
//  NLRootViewController.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-29.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLRootViewController.h"
#import "GradientButton.h"
#import "NLMyHomeViewController.h"
#import "NLReviewViewController.h"
#import "NLAuthorizationViewController.h"
#import "NLAboutViewController.h"
#import "NLDouUViewController.h"
@interface NLRootViewController ()

@end

//+ (UIColor *)groupTableViewBackgroundColor;
//+ (UIColor *)viewFlipsideBackgroundColor;
//+ (UIColor *)scrollViewTexturedBackgroundColor __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_2);
//+ (UIColor *)underPageBackgroundColor __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_5_0);
@implementation NLRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return self;
}
#pragma mark 添加四个导航按钮
-(void)addButton
{
   
    
    GradientButton *about = [GradientButton buttonWithType:UIButtonTypeCustom];
    about.frame = CGRectMake(180, 220, 40, 40);
    [about setTitle:@"设置" forState:UIControlStateNormal];
    about.titleLabel.font = [UIFont systemFontOfSize:12];
    [about useRedDeleteStyle];
    about.tag = 101;
    [about addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:about];
    
    GradientButton *douU = [GradientButton buttonWithType:UIButtonTypeCustom];
    douU.frame = CGRectMake(220, 220, 40, 40);
    [douU setTitle:@"豆油" forState:UIControlStateNormal];
    douU.titleLabel.font = [UIFont systemFontOfSize:12];
    [douU useSimpleOrangeStyle];
    douU.tag = 103;
    [douU addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:douU];
    
       
    GradientButton *myHome = [GradientButton buttonWithType:UIButtonTypeCustom];
    myHome.frame = CGRectMake(180, 140, 80, 80);
    [myHome setTitle:@"广播" forState:UIControlStateNormal];
    myHome.titleLabel.font = [UIFont systemFontOfSize:20];
    [myHome useGreenConfirmStyle];
    myHome.tag = 100;
    [myHome addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myHome];
    
    GradientButton *review = [GradientButton buttonWithType:UIButtonTypeCustom];
    review.frame = CGRectMake(60, 140, 120, 120);
    [review setTitle:@"评论资讯" forState:UIControlStateNormal];
    review.titleLabel.font = [UIFont systemFontOfSize:26];
    [review useAlertStyle];
    review.tag = 102;
    [review addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:review];


}

- (void)viewDidLoad
{
    //获取应用名作为title
    NSString *_appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    self.title = _appName;
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleBordered target:self action:@selector(login)]; 

    self.navigationItem.rightBarButtonItem = barItem;
    [barItem release];
    
    _delegate = (NLAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [self addButton];
       
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)login
{
    NLAuthorizationViewController  *targetVc=[[NLAuthorizationViewController alloc ]init];
    [self.navigationController pushViewController:targetVc animated:YES];
    [targetVc release];
}

-(void)select:(id)sender
{
    if (![sender isKindOfClass:[GradientButton class]]) {
        return;
    }
    
//    if(!_delegate.isLogin){
//        //未登录则
//    }
    int tag = ((GradientButton*)sender).tag;
    
    UIViewController *targetVc;
    switch (tag) {
        case 100:{
            //首页
            
           targetVc =[[NLMyHomeViewController alloc]init];
            
            break;
        }
            
        case 101:
            //关于
            targetVc = [[NLAboutViewController alloc]init];
            break;
        case 102:
            //最新评论
            targetVc =[[NLReviewViewController alloc]init];
            
            break;
        case 103:
            //豆油
            targetVc =[[NLDouUViewController alloc]init];
            break;
            
        case 104:
            //登陆
        {
             targetVc=[[NLAuthorizationViewController alloc ]init];
            break;
        }
    }
    
    [self.navigationController pushViewController:targetVc animated:YES];
    [targetVc release];
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
