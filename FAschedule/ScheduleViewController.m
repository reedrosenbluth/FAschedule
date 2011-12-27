//
//  ScheduleViewController.m
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CustomCell.h"
#import "FAscheduleAppDelegate.h"
#import "StudentSched.h"
#import "Week.h"
#import "Block.h"
#import "Time.h"
#import "CustomColors.h"
#import "UINavigationBar+fadeBar.h"

NSString *weekFromDayNum(int d)
{
    if ((d%10) < 5)
        return @"A";
    else
        return @"B";
}

@implementation ScheduleViewController

@synthesize dayNum;
@synthesize schedule;
@synthesize today;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.tableView.separatorColor = [UIColor blackColor];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    return io == UIInterfaceOrientationPortrait;
}

- (void) viewDidLoad
{  
    UIImage *backgroundImage = [UIImage imageNamed:@"tableBG.png"];
    [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    [[self tableView] setShowsVerticalScrollIndicator:NO];
    [super viewDidLoad];
}
- (void) viewWillAppear:(BOOL)animated
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:animated];
    UINavigationBar *nb = [[self navigationController] navigationBar];
    [nb setTintColor:[UIColor graniteColor] animated:YES];
    [self updateContent];
    [super viewWillAppear:animated];
}

- (void) updateContent
{
    NSArray *weekDaysArray = weekDays();
    FAscheduleAppDelegate *delegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setSchedule:[[delegate bothWeeks] week]];
    [self setToday:[schedule objectAtIndex:dayNum]];
    [[self tableView] reloadData];
    NSString *title = [NSString stringWithFormat:@"%@ - %@",[weekDaysArray objectAtIndex:(dayNum % 5)], weekFromDayNum(dayNum)];
    [self setTitle:title];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [today count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCellIdendtifier";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = loadingCell;
        loadingCell = nil;
    }
    NSString *startString = [[[today objectAtIndex:[indexPath row]] startTime] hhmmString];
    NSString *endString = [[[today objectAtIndex:[indexPath row]] endTime] hhmmString];
    NSString *timeString = [NSString stringWithFormat:@"%@ - %@",startString,endString];
    cell.timeLabel.text = timeString;
    cell.blockLabel.text  = [[today objectAtIndex:[indexPath row]] blockCode];
    cell.roomLabel.text = [[today objectAtIndex:[indexPath row]] room];
    cell.subjectLabel.text = [[today objectAtIndex:[indexPath row]] subject];
    if ((cell.roomLabel.text == nil) || ([cell.roomLabel.text isEqualToString: @""]))
        cell.roomHeading.hidden = YES;
    else
        cell.roomHeading.hidden = NO;
    int dayOfWeek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
    if ((dayOfWeek - 2) == dayNum && [[today objectAtIndex:[indexPath row]] isCurrentBlock])
        cell.subjectLabel.textColor = [UIColor salmonColor];
    else
        cell.subjectLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - Table view delegate

@end
