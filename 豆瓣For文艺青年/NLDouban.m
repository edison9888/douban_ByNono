//
//  NLDouban.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLDouban.h"
#import "ASIHTTPRequest.h"
#import "NLMiniBlogData.h"
#import "NLModelObject.h"
#import "ASIFormDataRequest.h"
#import "NLDouBanConfiguration.h"
#import "NLAppDelegate.h"
@implementation NLDouban
@synthesize _delegate;

- (id)init
{
    if (self == [super init]) {
        
    }
    
    return self;
}
- (void)MiniBlog:(NLMiniBlogData *)data delegate:(NSObject<NLDoubanRequestDelegate> *)delegate
{
    self._delegate = delegate;
    NSString *userid = data.userId;
    NSString *urlString = [NSString stringWithFormat:@"http://api.douban.com/people/%@/miniblog?alt=json",userid];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)RssReviewWithTag:(NSString*)RssTag delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = [NSString stringWithFormat:@"http://www.douban.com/feed/review/%@",RssTag];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];

}

-(void)getAuthorizationMiniBlogWithData: (NLFriendsShuoShuoData*)data  delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    NSString *urlString = @"https://api.douban.com/shuo/statuses/user_timeline";
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];
    request.delegate = self;
    [request startAsynchronous];
}

//获取授权用户关注的广播
-(void)getAuthorizationmFriendsMiniBlogWithData: (NLFriendsShuoShuoData*)data  delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{//@"http://api.douban.com/people/nonoforever/miniblog/contacts";
    NSString *urlString = @"https://api.douban.com/shuo/statuses/home_timeline";
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)AuthorizationWithUser:(id)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    NSString *name = @"316946356@qq.com";
    NSString *ps = @"1314520ck";

    NSString *urlString = [NSString stringWithFormat:@"https://api.douban.com/auth2/token?client_id=0993242d124692cb1cb96c8736d3b861&client_secret=b996445a44408900&redirect_uri=http://www.douban.com&grant_type=password&username=%@&password=$@",name,ps];
  //  urlString = @"https://api.douban.com/people/@me";
//    ASIFormDataRequest *formDataRequest = [ASIFormDataRequest requestWithURL:nil]; 
//    urlString = [formDataRequest encodeURL:urlString];
    
    
//   urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
//    [dic setObject:@"Bearer 7a497254e1d681616edc56fea5838423" forKey:@"Authorization"];
//    [request setRequestHeaders:dic];
    [request setRequestMethod:@"POST"];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)ReViewDetailById:(NSString*)reviewId delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = [NSString stringWithFormat:@"http://api.douban.com/review/%@",reviewId];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    request.delegate = self;
    [request startAsynchronous];
}




#pragma mark- request delegate Methods
- (void)requestFinished:(ASIHTTPRequest *)request
{
    int code = [request responseStatusCode];
    NSData *responseData = [request responseData];
    NSString *respString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"服务端返回内容%@",respString);
    
    [_delegate handleReponse:respString ResponseStatusCode:code];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
//    [_delegate handleReponse];
}
@end
