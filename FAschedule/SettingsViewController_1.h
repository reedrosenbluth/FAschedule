//
//  SettingsViewController_1.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StudentSchedStore;
@class SettingsViewCell;
@interface SettingsViewController_1 : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
    StudentSchedStore *store;
    NSMutableArray *segmentedControls;
}

@property (nonatomic, assign) id svc_1_Delegate;
@property (nonatomic, strong) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UINavigationBar *lunchNavBar;

-(IBAction)save:(id)sender;

@end

@protocol SettingsViewController_1_Delegate

- (void)settingsViewController_1_DidSelectBlock:(NSString *)blockCode;
- (void)settingsViewController_1_DidPressSchedule;

@end