//
//  NLAppDelegate.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-29.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    BOOL isLogin;
    NSString *token;
}
@property(nonatomic)BOOL isLogin;
@property (retain,nonatomic)UINavigationController *nav;
@property (strong, nonatomic) UIWindow *window;
@property(retain,nonatomic)NSString *token;

@end
