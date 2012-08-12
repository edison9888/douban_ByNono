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
    GradientButton *myHome = [GradientButton buttonWithType:UIButtonTypeCustom];
    myHome.frame = CGRectMake(180, 220, 40, 40);
    [myHome setTitle:@"说说" forState:UIControlStateNormal];
    myHome.titleLabel.font = [UIFont systemFontOfSize:12];
    [myHome useRedDeleteStyle];
    myHome.tag = 100;
    [myHome addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myHome];
    
    GradientButton *friends = [GradientButton buttonWithType:UIButtonTypeCustom];
    friends.frame = CGRectMake(220, 220, 40, 40);
    [friends setTitle:@"友邻" forState:UIControlStateNormal];
    friends.titleLabel.font = [UIFont systemFontOfSize:12];
    [friends useSimpleOrangeStyle];
    friends.tag = 101;
    [friends addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friends];
    
    GradientButton *review = [GradientButton buttonWithType:UIButtonTypeCustom];
    review.frame = CGRectMake(180, 140, 80, 80);
    [review setTitle:@"最新评论" forState:UIControlStateNormal];
    review.titleLabel.font = [UIFont systemFontOfSize:18];
    [review useGreenConfirmStyle];
    review.tag = 102;
    [review addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:review];
    
    GradientButton *myCity = [GradientButton buttonWithType:UIButtonTypeCustom];
    myCity.frame = CGRectMake(60, 140, 120, 120);
    [myCity setTitle:@"同城活动" forState:UIControlStateNormal];
    myCity.titleLabel.font = [UIFont systemFontOfSize:26];
    [myCity useAlertStyle];
    myCity.tag = 103;
    [myCity addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myCity];

}

- (void)viewDidLoad
{
    //获取应用名作为title
    NSString *_appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    self.title = _appName;
    loginBtn = [GradientButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 4, 60, 30);
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [loginBtn useBlackStyle];
    loginBtn.tag = 104;
    [loginBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:loginBtn];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
    _delegate = (NLAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [self addButton];
       
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
            //友邻
            break;
        case 102:
            //最新评论
            targetVc =[[NLReviewViewController alloc]init];
            
            break;
        case 103:
            //同城
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
