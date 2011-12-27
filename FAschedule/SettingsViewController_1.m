//
//  SettingsViewController_1.m
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController_1.h"
#import "SettingsViewController_2.h"
#import "LunchViewController.h"
#import "StudentSchedStore.h"
#import "StudentSched.h"
#import "CustomColors.h"
#import "FAscheduleAppDelegate.h"
#import "UINavigationBar+fadeBar.h"
#import "Week.h"

#define LUNCH_LANDSCAPE CGRectMake(3,414,320,768)


@implementation SettingsViewController_1

@synthesize svc_1_Delegate;
@synthesize tv;
@synthesize lunchNavBar;

- (id) init
{  
    self = [super initWithNibName:@"SettingsView_1" bundle:nil];
    if (self) {
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    UIBarButtonItem *lunchButton = [[UIBarButtonItem alloc] initWithTitle:@"Lunch" style:UIBarButtonItemStylePlain target:self action:@selector(lunchSettings:)];
    self.navigationItem.rightBarButtonItem = lunchButton; 
    [self.tv reloadData];
    [[self tv] setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [super viewDidLoad];
}

- (void)schedule:(id)sender
{
    [svc_1_Delegate settingsViewController_1_DidPressSchedule];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)lunchSettings:(id)sender
{
    LunchViewController *lunchvc = [[LunchViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:lunchvc animated:YES];
}

- (IBAction)save: (id) sender
{
    for (int i=0; i<10; i++)
        [store setLunchPeriod:[[segmentedControls objectAtIndex:i] selectedSegmentIndex]+1 forIndex:i];
    FAscheduleAppDelegate *appDelegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appDelegate bothWeeks] loadWeek];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lunch periods saved." 
                                                    message:nil
                                                   delegate:self 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

- (void)viewWillAppear:(BOOL)animated
{       
    store = [StudentSchedStore defaultStore];
    [self.tv reloadData];
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    return io == UIInterfaceOrientationPortrait;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section) ? 7 : 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *main = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    
    [main setFont:[UIFont boldSystemFontOfSize:20]];
    [main setBackgroundColor:[UIColor clearColor]];
    [main setTextColor:[UIColor whiteColor]];
    [main setTextAlignment:UITextAlignmentCenter];
    if (section) 
        [main setText:@"alternate blocks"];
    else
        [main setText:@"main blocks"];
    return main;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *letter;
    letter = [[store keys] objectAtIndex:[indexPath row]+[indexPath section] * 8];
    NSString *s = [[[store allStudentsScheds] objectForKey:letter] subject];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", letter, s];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bc = [[store keys] objectAtIndex:[indexPath row]+[indexPath section] * 8];
    SettingsViewController_2 *svc2 = [[SettingsViewController_2 alloc] initWithNibName:@"SettingsView_2" bundle:nil];
    [svc2 setTitle: [bc stringByAppendingString:@" Block"]];
    svc2.blockCode = bc;
    [self.navigationController pushViewController:svc2 animated:YES];
}

- (void)viewDidUnload {
    [self setLunchNavBar:nil];
    [super viewDidUnload];
}
@end
