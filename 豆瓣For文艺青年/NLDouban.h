//
//  NLDouban.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@class NLFriendsShuoShuoData;
@class NLMiniBlogData;
typedef enum _RSSTAG :NSUInteger {
    RSS_LATEST = 0,
    RSS_BOOK ,
    RSS_MOVIES,
    RSS_MUSIC
    
}RSSTAG;


@protocol NLDoubanRequestDelegate <NSObject>

-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code;

@end


@interface NLDouban : NSObject

{
    id <NLDoubanRequestDelegate>  _delegate;
}
@property(assign,nonatomic) id <NLDoubanRequestDelegate>  _delegate;
//获取指定用户广播
-(void)MiniBlog:(NLMiniBlogData*)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate;

//通过rss获取最新评论
-(void)RssReviewWithTag:(NSString *)RssTag delegate:(NSObject <NLDoubanRequestDelegate>*)delegate;

//~~~~
-(void)AuthorizationWithUser:(id)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate;

//获取授权用户自己的广播
-(void)getAuthorizationMiniBlogWithData: (NLFriendsShuoShuoData*)data  delegate:(NSObject <NLDoubanRequestDelegate>*)delegate;

//获取授权用户关注的广播
-(void)getAuthorizationmFriendsMiniBlogWithData: (NLFriendsShuoShuoData*)data  delegate:(NSObject <NLDoubanRequestDelegate>*)delegate;

-(void)ReViewDetailById:(NSString*)reviewId delegate:(NSObject <NLDoubanRequestDelegate>*)delegate;
@end
