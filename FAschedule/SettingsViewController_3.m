//
//  SettingsViewController_3.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FAscheduleAppDelegate.h"
#import "SettingsViewController_3.h"
#import "StudentSchedStore.h"
#import "StudentSched.h"
#import "Week.h"
#import "CustomColors.h"
#import "SettingsViewController_1.h"


@implementation SettingsViewController_3
@synthesize dataSource;
@synthesize blockCode;
@synthesize tempDays;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    dataSource = weekDays();
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clear:)];

    NSArray *items = [NSArray arrayWithObjects:saveButton, clearButton, nil];
    [self.navigationItem setRightBarButtonItems:items];
    [super viewDidLoad];
}

- (void)clear:(id)sender {
    FAscheduleAppDelegate *appDelegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    StudentSched *sched = [store blockForKey: blockCode];
    [sched setSubject:@""];
    [sched setRoom:@""];
       [[appDelegate bothWeeks] loadWeek];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];

}

- (void) save:(id)sender
{
    FAscheduleAppDelegate *appDelegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    NSSet *mainBlocks = [NSSet setWithObjects: @"A",@"B",@"C",@"D",@"E",@"F",@"G",nil];
    StudentSched *ts = [store tempSched];
    StudentSched *sched = [store blockForKey: blockCode];
    StudentSched *alt;
    [sched setSubject:[ts subject]];
    [sched setRoom:[ts room]];
    [sched setDays:tempDays];
    if ([mainBlocks containsObject:blockCode]) {
        alt = [store blockForKey:[blockCode lowercaseString]];
        for (int i=0; i<10; i++) {
            if ([[[sched days] objectAtIndex:i] boolValue]) {
                [alt setDayToNo:i];
            }
        }
    }
    else if ([mainBlocks containsObject:[blockCode uppercaseString]]) {
        alt = [store blockForKey:[blockCode uppercaseString]];
        for (int i=0; i<10; i++) {
            if ([[[sched days] objectAtIndex:i] boolValue]) {
                [alt setDayToNo:i];
            }
        }
    }
    [[appDelegate bothWeeks] loadWeek];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    StudentSched *ts = [[StudentSchedStore defaultStore] tempSched];
    tempDays =  [[NSMutableArray alloc] initWithArray:[ts days] copyItems:YES];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [dataSource objectAtIndex:[indexPath row]];
    NSUInteger index = [indexPath row] + (5 * [indexPath section]);
    if ([[tempDays objectAtIndex:index] boolValue])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[[store blackOutDays] objectForKey:blockCode] intValue] == index)
        [[cell textLabel] setTextColor: [UIColor lightGrayColor]];
    else 
        [[cell textLabel] setTextColor: [UIColor blackColor]];
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"A Week";
    else
        return @"B Week";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    NSUInteger index = [indexPath row] + (5 * [indexPath section]);
    if ([[[store blackOutDays] objectForKey:blockCode] intValue] == index)
        return ;   
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        [tempDays replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
    } else {
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
            [tempDays replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
    }
}

@end
