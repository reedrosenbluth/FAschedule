//
//  DayViewController.m
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/25/11.
//  Copyright 2011 __ApplauseCode__. All rights reserved.
//

#import "DayViewController.h"
#import "ScheduleViewController.h"
#import "PagedScheduleViewController.h"
#import "SettingsViewController_1.h"
#import "HelpViewController.h"
#import "FAscheduleAppDelegate.h"
#import "Week.h"
#import "Block.h"
#import "Time.h"
#import "CustomColors.h"
#import "UINavigationBar+fadeBar.h"
#import "Time.h"


@implementation DayViewController

@synthesize tableView_x;
@synthesize nowDynamicLabel;
@synthesize nextDynamicLabel;
@synthesize nowDynamicRoom;
@synthesize nextDynamicRoom;
@synthesize classProgress;
@synthesize tableData;
@synthesize ab_x;
@synthesize dayNum;

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

- (void) update: (NSTimer *) timer;
{
    [self currentClass];
    [self.tableView_x reloadData];
    nowDynamicLabel.text = currentSubject;
    nowDynamicRoom.text = currentRoom;
    nextDynamicLabel.text = nextSubject;
    nextDynamicRoom.text = nextRoom;
    Time *nowSec = [[Time alloc] initWithDate:[NSDate dateWithTimeIntervalSinceNow:kDateAdjust]];
    float percentageProgress;
    percentageProgress = ([startSec secondsUntil:endSec]>0) ? (float)[startSec secondsUntil:nowSec]/(float)[startSec secondsUntil:endSec] : 0;
    [classProgress setProgress:percentageProgress];
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    UINavigationBar *nb = [[self navigationController] navigationBar];
    [nb setTintColor:[UIColor darkRedColor] animated:YES];
    
}
- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    UINavigationBar *nb = [[self navigationController] navigationBar];
    [nb setTintColor:[UIColor darkRedColor] animated:YES];
    tableView_x.delegate = self;
    tableView_x.dataSource = self;
    tableView_x.scrollEnabled = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button addTarget:self action:@selector(help:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [[self navigationItem] setLeftBarButtonItem:infoItem];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settings1:)];
	self.navigationItem.rightBarButtonItem = settingsButton;
    tableData = weekDays();
    // Check every second to see what current and next class will be.
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update:) userInfo:nil repeats:YES]; 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [ab_x setSelectedSegmentIndex: [defaults integerForKey:@"a_or_b"]];
    [super viewDidLoad];    
}

- (void)viewDidUnload
{
    [self setTableData:nil];
    [self setAb_x:nil];
    [self setTableView_x:nil];
    [self setNowDynamicLabel:nil];
    [self setNextDynamicLabel:nil];
    [self setNowDynamicRoom:nil];
    [self setNextDynamicRoom:nil];
    [self setClassProgress:nil];
    [super viewDidUnload];
}

#pragma mark - Current & Next class

-(void) settings1 : (id) sender
{
    SettingsViewController_1 *svc1 = [[SettingsViewController_1 alloc] init];
    [svc1 setTitle:@"settings"];
    [[self navigationController] pushViewController:svc1 animated:YES];
}

- (NSString *) subjectString: (Block *) b
{
    if ([b startTime])
        return [NSString stringWithFormat:@"%@ - %@:  %@",[[b startTime] hhmmString], [[b endTime] hhmmString], [b subject]];
    else
        return kEmptyString;
}


- (void) currentClass
{ 
    // Start current and next subject and room at 'No Class' and ''.
    currentSubject = [NSString stringWithFormat:kClassDefault];
    currentRoom = [NSString stringWithFormat:kRoomDefault];
    nextSubject = [NSString stringWithFormat:kClassDefault];
    nextRoom = [NSString stringWithFormat:kRoomDefault];
    int index;
    // Get the day of the week.
    int dayOfWeek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
       // No Class on weekends.
    if (dayOfWeek == 1 || dayOfWeek == 7) {
        return;
    }
    // Adjust day of week so monday is 0, tuesday is 1, etc.
    dayOfWeek = dayOfWeek - 2;
    int weekNum = [ab_x selectedSegmentIndex];
    int dn = dayOfWeek + (5 * weekNum);
    FAscheduleAppDelegate *delegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    Week *w;
    w = [delegate bothWeeks];
    NSMutableArray *today = [[w week] objectAtIndex:dn];
    // Find the current and next class periods.
    for (Block *block in today) {
        if ([block isCurrentBlock]) {
            currentSubject = [self subjectString:block];
            startSec = [block startTime];
            endSec = [block endTime];
            ([block room]) ? currentRoom = [NSString stringWithFormat:@"%@  ",[block room]]: kEmptyString;
            index = [today indexOfObjectIdenticalTo:block]+1;
            if (index < [today count]) {
                Block *nextBlock = [today objectAtIndex:[today indexOfObjectIdenticalTo:block] + 1];
                nextSubject = [self subjectString:nextBlock];
                ([nextBlock room]) ? nextRoom = [NSString stringWithFormat:@"%@  ",[nextBlock room]]: kEmptyString;
            }
            return;
        }    
    }
    return;
}

- (void)help:(id)sender {
    HelpViewController *h = [[HelpViewController alloc] init];
    [[self navigationController] presentModalViewController:h animated:YES];
}

- (IBAction)abPressed:(id)sender 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[ab_x selectedSegmentIndex] forKey:@"a_or_b"];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [tableData objectAtIndex:[indexPath row]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    int dayOfWeek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday]-2;
    cell.textLabel.textColor = (dayOfWeek == [indexPath row]) ? [UIColor blueColor] : [UIColor blackColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int dn = [indexPath row] + (5 * [ab_x selectedSegmentIndex]);
    PagedScheduleViewController *psvc = [[PagedScheduleViewController alloc] init];
    [psvc setDayNum: dn];
    [[self navigationController] pushViewController:psvc animated:YES];
    
}

@end
    
    
