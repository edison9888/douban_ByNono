//
//  NLReviewDetailViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLReviewDetailViewController.h"
#import "NLAppDelegate.h"
@interface NLReviewDetailViewController ()
@property(retain,nonatomic)UIActivityIndicatorView *activityView;
@property(retain,nonatomic)UIBarButtonItem *refreshBtn;

@end

@implementation NLReviewDetailViewController
@synthesize reviewId,douban,webView,activityView,refreshBtn;
- (void)dealloc
{
    [reviewId release];
    [douban release];
    [webView release];
    [activityView release];
    [refreshBtn release];
    [super dealloc];
}


-(void)isNet
{
    if (![NLAppDelegate shareAPPDelegate].isAvailableNet) {
        UIAlertView * a = [[ UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
        [a release];
    }
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (activityView.isAnimating) {
        [activityView stopAnimating];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.title = @"评论详情";
   
 
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?(416-44+88):(416-44))];
    [self.view addSubview:webView];
    webView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    webView.scalesPageToFit=YES;
    [webView release];
    
    NSString *urlpath = [NSString stringWithString:reviewId];
    NSURL *url=[NSURL URLWithString:urlpath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
    
    
    //工具栏
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,iPhone5?(416+88):416, 320, 44)];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:toolbar];
    [toolbar release];
    
    UIBarButtonItem *front = [[UIBarButtonItem alloc] initWithTitle:@"上一页" style:UIBarButtonItemStyleBordered target:self action:@selector(front)];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *fixspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixspace.width = 20;
    
    
    //刷新标签
   self.refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    NSArray *arr = [NSArray arrayWithObjects:front,next,space,refreshBtn,fixspace,nil];
    
    [toolbar setItems:arr];
    
    [front release];
    [space release];
    [next release];
    [refreshBtn release];
    [fixspace release];
    //loading指示器
    self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame =CGRectMake(260, 0, 40, 40);
    [self.navigationController.navigationBar addSubview:activityView];
    
    [activityView release];
    
    
    
   // toolbar 
	// Do any additional setup after loading the view.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refresh
{
    [webView reload];
}
//前一页
-(void)front
{
    if (webView.canGoBack) {
        [webView goBack];
    }
    
}

//后一页
-(void)next
{
    if (webView.canGoForward) {
        [webView goForward];
    }
}


#pragma mark UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self isNet];
    return YES;

}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    refreshBtn
  [activityView startAnimating];   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    NSString *url =  webView.request.URL.absoluteString;
    
     [activityView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityView stopAnimating];
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
