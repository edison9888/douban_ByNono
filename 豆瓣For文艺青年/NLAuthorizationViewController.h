//
//  NLAuthorizationViewController.h
//  豆瓣骚年
//
//  Created by Nono on 12-8-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLAppDelegate.h"
@interface NLAuthorizationViewController : UIViewController<UIWebViewDelegate>

{
    NLAppDelegate *_delegate;
}
@end
