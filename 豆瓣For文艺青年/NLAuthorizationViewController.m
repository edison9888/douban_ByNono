//
//  NLAuthorizationViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLAuthorizationViewController.h"

@interface NLAuthorizationViewController ()

@end

@implementation NLAuthorizationViewController
//自定义的重定向url
NSString *_redirect = @"https://www.nono_lilith.com";
NSString *_api_key = @"0bd73c44ae7f55d72385b4ce0b7e0185";
NSString *_douban_register =  @"http://www.douban.com/accounts/register";
NSString *_resure_url =  @"https://www.nono_lilith.com/?error=access_denied";


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
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 397)];
    [self.view addSubview:webView];
    webView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    webView.scalesPageToFit=YES;
    [webView release];
    
    NSString *urlpath = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=token&display=popup",_api_key,_redirect];
    NSURL *url=[NSURL URLWithString:urlpath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    [webView loadRequest:request];
    
	// Do any additional setup after loading the view.
}

#pragma mark UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL b = YES;
    
    NSString *targetUrl = request.URL.absoluteString;
    if ([_douban_register isEqualToString:targetUrl]) {//注册，直接跳转浏览器
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_douban_register]];
        b = NO;
    }else if ([targetUrl isEqualToString:_resure_url]) {//拒绝授权
        b = NO;
        [self back];
    }
    
    NSRange range = [targetUrl rangeOfString:@"https://www.nono_lilith.com/#access_token="];
    if (range.length > 0) {//点击了授权，并且成功了
        NSString *tokenMore = [targetUrl substringFromIndex:range.location+range.length];
        NSString *token = [[tokenMore componentsSeparatedByString:@"&"] objectAtIndex:0];
        NSLog(@"获取的token = %@",token);
        _delegate = (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
        _delegate.isLogin = YES;
        _delegate.token = token;
        b = NO;
        [self back];
    }
    
    return b;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSString *url =  webView.request.URL.absoluteString;
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
