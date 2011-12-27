//
//  PagedScheduleViewController.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 9/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScheduleViewController;

@interface PagedScheduleViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIView *leftView;
    UIView *centerView;
    UIView *rightView;
    ScheduleViewController *svc0;
    ScheduleViewController *svcR;
    ScheduleViewController *svcL;
    int dayNum;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic) int weekNum;
@property (nonatomic) int dayNum;

@end

