//
//  SettingsViewController_2.m
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController_2.h"
#import "SettingsViewController_3.h"
#import "StudentSchedStore.h"
#import "StudentSched.h"
#import "Week.h"
#import "CustomColors.h"


@implementation SettingsViewController_2

@synthesize roomField;
@synthesize subjectsTable;
@synthesize subjectLabel;
@synthesize subjects;
@synthesize keys;
@synthesize blockCode;
@synthesize subject;
@synthesize room;
@synthesize days;
@synthesize svc3Title;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (IBAction) textFieldDidEndEditing:(UITextField *)textField
{
    self.room = [textField text];
    [textField resignFirstResponder];
    StudentSched *ts = [[StudentSchedStore defaultStore] tempSched];
    [ts setRoom:[self room]];
}


#pragma mark - View lifecycle
 
- (void)viewDidLoad
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Subjects" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.subjects = dict;
    NSArray *array = [[subjects allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.keys = array;
    [super viewDidLoad];
}

- (void) setDays: (id) sender 
{
    self.room = [roomField text];
    [roomField resignFirstResponder];
    StudentSched *ts = [[StudentSchedStore defaultStore] tempSched];
    [ts setDays:[self days]];
    svc3 = [[SettingsViewController_3 alloc] initWithStyle:UITableViewStylePlain];
    [svc3 setTitle:svc3Title];
    svc3.blockCode = self.blockCode;
    [[self navigationController] pushViewController:svc3 animated:YES];
}

- (void)showBlock
{
    int r = 0;
    int s = 0;
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    StudentSched *sched = [store blockForKey:blockCode];
    days = [sched days];
    self.subject = (sched == nil) ? @"Subject" : [sched subject];
    self.room = (sched == nil) ? @"Room ?" : [sched room];
    [self.roomField setText:self.room];
    [self.subjectLabel setText:self.subject];
    for (int j=0; j<[self.keys count]; j++) {
        for (int i=0; i<[[self.subjects objectForKey:[self.keys objectAtIndex:j]] count]; i++) {
            NSString *currentSubject = [[self.subjects objectForKey:[self.keys objectAtIndex:j]] objectAtIndex:i];
            if ([currentSubject isEqualToString: self.subject]) {
                r = i;
                s = j;
            }
        }
    } 
    NSIndexPath *path = [NSIndexPath indexPathForRow:r inSection:s];
    [self.subjectsTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)viewDidUnload
{
    self.subjects = nil;
    self.keys = nil;
    self.roomField = nil;
    self.subjectsTable = nil;
    self.subjectLabel = nil;
    [super viewDidUnload];
}

- (void) viewDidAppear:(BOOL)animated   
{
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"days" style:UIBarButtonItemStylePlain target:self action:@selector(setDays:)];
    self.navigationItem.rightBarButtonItem = settingsButton;
    [self showBlock];
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keys count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    NSArray * subjectSection = [subjects objectForKey:key];
    return [subjectSection count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section];
    NSArray *subjectSection = [subjects objectForKey:key];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier];
    }
    cell.textLabel.text = [subjectSection objectAtIndex:row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [NSArray arrayWithObjects:@"A",@"C",@"D",@"E",@"F",@"G",@"H",@"L",@"M",@"P",@"R",@"S",@"T", nil];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    switch (index) {
        case 7:
        case 8:
            return index + 1;  
        case 9:
        case 10:
        case 11:
            return index + 2;
        case 12:
        case 13:
        case 14:
            return index + 3;
        default:
            return index;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentSched *ts = [[StudentSchedStore defaultStore] tempSched];
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section];
    NSArray *subjectSection = [subjects objectForKey:key];
    self.svc3Title = [subjectSection objectAtIndex:row];
    self.subject = [subjectSection objectAtIndex:row];
    [self.subjectLabel setText:self.subject];
    
    // For some reason the following line does not work the cell reappers highlighted when
    // it returns to the view, but the next line does? go figure.
    //[[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ts setSubject:[self subject]];
}


@end
