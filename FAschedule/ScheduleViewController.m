//
//  ScheduleViewController.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CustomCell.h"
#import "ExtensionCell.h"
#import "FAscheduleAppDelegate.h"
#import "StudentSched.h"
#import "Week.h"
#import "Block.h"
#import "Time.h"
#import "CustomColors.h"
#import "UINavigationBar+fadeBar.h"
#import "SettingsViewController_1.h"
#import "RootViewController.h"
#import "WeekAB.h"

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
    UIImage *backgroundImage = [UIImage imageNamed:@"tableBG2.png"];
    [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    [[self tableView] setShowsVerticalScrollIndicator:NO];
    
    UIImage *cogImage = [UIImage imageNamed:@"cog"];
    UIButton *cogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cogButton.bounds = CGRectMake( 0, 0, cogImage.size.width, cogImage.size.height );
    [cogButton setBackgroundImage:cogImage forState:UIControlStateNormal];
    [cogButton addTarget:self action:@selector(pushSettingsView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cogButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cogButton];
    [cogButton setShowsTouchWhenHighlighted:YES];
    UIImage *calImage = [UIImage imageNamed:@"today"];
    UIButton *todayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.bounds = CGRectMake(0, 0, calImage.size.width, calImage.size.height-2);
    [todayButton setBackgroundImage:calImage forState:UIControlStateNormal];
    [todayButton addTarget:self action:@selector(goToToday) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *todayItem = [[UIBarButtonItem alloc] initWithCustomView:todayButton];
    [todayButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = 15;
    NSArray *rightBarButtons = [NSArray arrayWithObjects:cogButtonItem, space, todayItem, nil];
    [[self navigationItem] setRightBarButtonItems:rightBarButtons];
    
    UIImage *lines = [UIImage imageNamed:@"menu"];
    UIButton *slideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    slideButton.bounds = CGRectMake(0, 0, lines.size.width, lines.size.height);
    [slideButton setBackgroundImage:lines forState:UIControlStateNormal];
    [slideButton addTarget:self action:@selector(chooseDay) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *slideItem = [[UIBarButtonItem alloc] initWithCustomView:slideButton];
    [slideButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpace.width = 8;
    NSArray *leftBarButtons = [NSArray arrayWithObjects:leftSpace, slideItem, nil];
    [[self navigationItem] setLeftBarButtonItems:leftBarButtons];
    
    [super viewDidLoad];
}

- (void)chooseDay {
    PaperFoldState state = [[(RootViewController *)[self.navigationController parentViewController] paperFoldView] state];
    if (state == PaperFoldStateLeftUnfolded) {
        [[(RootViewController *)[self.navigationController parentViewController] paperFoldView] setPaperFoldState:PaperFoldStateRightUnfolded];
    } else {
        [[(RootViewController *)[self.navigationController parentViewController] paperFoldView] setPaperFoldState:PaperFoldStateLeftUnfolded];
    }
}

- (void)pushSettingsView {
    SettingsViewController_1 *svc1 = [[SettingsViewController_1 alloc] init];
    [svc1 setTitle:@"settings"];
    [[self navigationController] pushViewController:svc1 animated:YES];
    [[(RootViewController *)[self.navigationController parentViewController] paperFoldView] setEnableLeftFoldDragging:NO];
}

- (void)goToToday {
    NSArray *weekDaysArray = weekDays();
    int dayOfWeek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
    // No Class on weekends.
    if (dayOfWeek == 1 || dayOfWeek == 7) {
        dayOfWeek = 2;
    }
    // Adjust day of week so monday is 0, tuesday is 1, etc.
    dayOfWeek = dayOfWeek - 2;
    int weekNum = ([WeekAB isB:[NSDate date]]) ? 1 : 0;
    int dn = dayOfWeek + (5 * weekNum);
    [self setToday:[schedule objectAtIndex:dn]];
    [[self tableView] reloadData];
    NSString *title = [NSString stringWithFormat:@"%@ - %@",[weekDaysArray objectAtIndex:(dn % 5)], weekFromDayNum(dn)];
    [self setTitle:title];
    self.dayNum = dn;
}

- (void) viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
    [[(RootViewController *)[self.navigationController parentViewController] paperFoldView] setEnableLeftFoldDragging:YES];
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
    if ([[[today objectAtIndex:[indexPath row]] blockCode] isEqualToString:@"ex"]) {
        ExtensionCell *extCell = (ExtensionCell *)[tableView dequeueReusableCellWithIdentifier:@"ExtensionCellIdentifier"];
        if (extCell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"ExtensionCell" owner:self options:nil];
            extCell = extLoadingCell;
            extLoadingCell = nil;
        }
        extCell.subjectLabel.text = @"Extension";
        NSString *startString = [[[today objectAtIndex:[indexPath row]] startTime] hhmmString];
        NSString *endString = [[[today objectAtIndex:[indexPath row]] endTime] hhmmString];
        NSString *timeString = [NSString stringWithFormat:@"%@ - %@",startString,endString];
        extCell.timeLabel.text = timeString;
        int dayOfWeek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
        if ((dayOfWeek - 2) == dayNum && [[today objectAtIndex:[indexPath row]] isCurrentBlock])
            extCell.subjectLabel.textColor = [UIColor salmonColor];
        else
            extCell.subjectLabel.textColor = [UIColor whiteColor];
        return extCell;
    }
    
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
    cell.subjectLabel.text = [[today objectAtIndex:[indexPath row]] subject];
    cell.blockLabel.text  = [[today objectAtIndex:[indexPath row]] blockCode];
    cell.timeLabel.text = timeString;
    cell.roomLabel.text = [[today objectAtIndex:[indexPath row]] room];
    
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
    if ([[[today objectAtIndex:[indexPath row]] blockCode] isEqualToString:@"ex"]) {
        return 30;
    }
    return 60;
}

#pragma mark - Table view delegate

@end
