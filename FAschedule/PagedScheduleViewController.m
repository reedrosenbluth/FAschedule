//
//  PagedScheduleViewController.m
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 9/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PagedScheduleViewController.h"
#import "ScheduleViewController.h"


@implementation PagedScheduleViewController

@synthesize scrollView;
@synthesize leftView, centerView, rightView;
@synthesize weekNum, dayNum;

- (id) init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    return io == UIInterfaceOrientationPortrait;
}

#pragma mark - View lifecycle

- (void) viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"newInstallation"] boolValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hint" 
                                                        message:@"Scroll left or right to change day"
                                                       delegate:self 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [defaults setBool:NO forKey:@"newInstallation"];
        [alert show];
    }
}
- (void)loadView
{
    NSArray *weekDaysArray = weekDays();
    CGRect scrollRect = CGRectMake(0, 0, 320, 416);
    CGRect leftRect = CGRectMake(0, 0, 320, 416);
    CGRect centerRect = CGRectMake(320, 0, 320, 416);
    CGRect rightRect = CGRectMake(640, 0, 320, 416);

    scrollView = [[UIScrollView alloc] initWithFrame:scrollRect];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.contentOffset = CGPointMake(320, 0);
        
    svc0 = [[ScheduleViewController alloc] initWithStyle:UITableViewStylePlain];
    svc0.dayNum = dayNum;
    svc0.tableView.frame = centerRect;
    
    svcR = [[ScheduleViewController alloc] initWithStyle:UITableViewStylePlain];
    svcR.dayNum = (dayNum + 1) % 10;
    svcR.tableView.frame = rightRect;
    
    svcL = [[ScheduleViewController alloc] initWithStyle:UITableViewStylePlain];
    svcL.dayNum = (dayNum + 9) % 10;
    svcL.tableView.frame = leftRect;

    NSString *title = [NSString stringWithFormat:@"%@ - %@",[weekDaysArray objectAtIndex:(dayNum % 5)], weekFromDayNum(dayNum)];
    [self setTitle:title];
    
    //If not running IOS 5 or greater we have to call viewWillAppear manually;
    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending) {
        [self addChildViewController:svc0];
        [self addChildViewController:svcR];
        [self addChildViewController:svcL];
    } else {
        [svcR updateContent];
        [svc0 updateContent];
        [svcL updateContent];
    }
    
    centerView = [svc0 view]; 
    leftView = [svcL view];
    rightView = [svcR view];
    [scrollView addSubview:leftView];
    [scrollView addSubview:centerView];
    [scrollView addSubview:rightView];
    [self setView:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sv
{    
    CGRect centerRect = CGRectMake(320, 0, 320, 416);
    NSArray *weekDaysArray = weekDays();
    int page = floor((scrollView.contentOffset.x - 160) / 320)+1;
    if (fabs((scrollView.contentOffset.x - 160) / 320) >= 0.5) {
        if (page == 2)
            dayNum++;
        else if (page == 0)
            dayNum += 9;
        [svcR setDayNum:(dayNum+1)%10];
        [svcR updateContent];
        [svc0 setDayNum:(dayNum)%10];
        [svc0 updateContent];
        [svcL setDayNum:(dayNum-1)%10];
        [svcL updateContent];
        [sv scrollRectToVisible:centerRect animated:NO];
        NSString *title = [NSString stringWithFormat:@"%@ - %@",[weekDaysArray objectAtIndex:((dayNum) % 5)], weekFromDayNum(dayNum)];
        [self setTitle:title];
    }
}

@end
