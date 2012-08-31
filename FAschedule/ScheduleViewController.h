
//
//  ScheduleViewController.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCell;
@class ExtensionCell;

NSString *weekFromDayNum(int d);

@interface ScheduleViewController : UITableViewController {
    NSMutableArray *schedule;
    NSMutableArray *today;
    int dayNum; // 0=Monday,...,4=Friday
    IBOutlet CustomCell *loadingCell;
    IBOutlet ExtensionCell *extLoadingCell;
}

@property (nonatomic) int dayNum;
@property (nonatomic, strong) NSMutableArray *schedule;
@property (nonatomic, strong) NSMutableArray *today;

- (void) updateContent;

@end

