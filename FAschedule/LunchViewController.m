//
//  LunchViewController.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LunchViewController.h"
#import "StudentSchedStore.h"
#import "FAscheduleAppDelegate.h"
#import "Week.h"

@implementation LunchViewController
@synthesize aM;
@synthesize aT;
@synthesize aW;
@synthesize aTh;
@synthesize aF;
@synthesize bM;
@synthesize bT;
@synthesize bW;
@synthesize bTh;
@synthesize bF;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
        [[self navigationItem] setRightBarButtonItem:bbi];
    }
    return self;
}

- (void)viewDidLoad
{             
    segmentedControls = [[NSMutableArray alloc] initWithObjects:aM,aT,aW,aTh,aF,bM,bT,bW,bTh,bF,nil];
    [super viewDidLoad];
}

- (void)viewWillAppear: (BOOL) animated
{
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    for (int i=0; i<10; i++) 
        [[segmentedControls objectAtIndex:i] setSelectedSegmentIndex:([store lunchPeriodForIndex:i]-1)];
    [super viewWillAppear:animated];

}

- (void)save: (id) sender
{
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    for (int i=0; i<10; i++)
        [store setLunchPeriod:[[segmentedControls objectAtIndex:i] selectedSegmentIndex]+1 forIndex:i];
    FAscheduleAppDelegate *appDelegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appDelegate bothWeeks] loadWeek];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setAM:nil];
    [self setAT:nil];
    [self setAW:nil];
    [self setATh:nil];
    [self setAF:nil];
    [self setBM:nil];
    [self setBT:nil];
    [self setBW:nil];
    [self setBTh:nil];
    [self setBF:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
