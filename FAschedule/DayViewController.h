//
//  DayViewController.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomColors.h"

#define kClassDefault @"  ----  "
#define kRoomDefault  @"  ----  "
#define kEmptyString @""

@class ScheduleViewController;
@class Time;

@interface DayViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UIButton *settings_1;
    NSString *currentSubject;
    NSString *currentRoom;
    NSString *nextSubject;
    NSString *nextRoom;
    UISegmentedControl *ab_x;
    UITableView *tableView_x;
    UILabel *nowDynamicLabel;
    UILabel *nextDynamicLabel;
    UILabel *nowDynamicRoom;
    UILabel *nextDynamicRoom;
    IBOutlet UIProgressView *classProgress;
    Time *startSec;
    Time *endSec;
}

@property (nonatomic,strong) NSArray *tableData;
@property (nonatomic, strong) IBOutlet UISegmentedControl *ab_x;
@property (nonatomic, strong) IBOutlet UITableView *tableView_x;
@property (nonatomic, strong) IBOutlet UILabel *nowDynamicLabel;
@property (nonatomic, strong) IBOutlet UILabel *nextDynamicLabel;
@property (nonatomic, strong) IBOutlet UILabel *nowDynamicRoom;
@property (nonatomic, strong) IBOutlet UILabel *nextDynamicRoom;
@property (strong, nonatomic) IBOutlet UIProgressView *classProgress;
@property (nonatomic, assign) int dayNum;

// Set the current and next class banner
- (void) currentClass;
- (void)help:(id)sender;
- (IBAction)abPressed:(id)sender;

@end