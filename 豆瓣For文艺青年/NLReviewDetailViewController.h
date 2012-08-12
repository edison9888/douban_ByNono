//
//  NLReviewDetailViewController.h
//  豆瓣骚年
//
//  Created by Nono on 12-8-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLDouban.h"
@interface NLReviewDetailViewController : UIViewController

{
    NSString *reviewId;
      NLDouban *douban;
}
@property(retain,nonatomic)NSString *reviewId;
@property(retain,nonatomic) NLDouban *douban;
@end
