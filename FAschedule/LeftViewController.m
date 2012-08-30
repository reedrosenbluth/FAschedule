//
//  LeftViewController.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/11/12.
//
//

#import "LeftViewController.h"
#import "RootViewController.h"
#import "FAscheduleAppDelegate.h"
#import "Time.h"
#import "Week.h"
#import "Block.h"
#import "WeekAB.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) update: (NSTimer *) timer;
{
    [self currentClass];
    _nowDynamicLabel.text = currentSubject;
    _nowDynamicRoom.text = currentRoom;
    _nextDynamicLabel.text = nextSubject;
    _nextDynamicRoom.text = nextRoom;
    Time *nowSec = [[Time alloc] initWithDate:[NSDate dateWithTimeIntervalSinceNow:kDateAdjust]];
    float percentageProgress;
    percentageProgress = ([startSec secondsUntil:endSec]>0) ? (float)[startSec secondsUntil:nowSec]/(float)[startSec secondsUntil:endSec] : 0;
    [_classProgress setProgress:percentageProgress];
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
    int weekNum  = ([WeekAB isB:[NSDate date]]) ? 1 : 0;
    int dn = dayOfWeek + (5 * weekNum);
    FAscheduleAppDelegate *faDelegate = (FAscheduleAppDelegate *)[[UIApplication sharedApplication] delegate];
    Week *w;
    w = [faDelegate bothWeeks];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [self setDayButtons:nil];
    [super viewDidUnload];

    [self setNowDynamicLabel:nil];
    [self setNextDynamicLabel:nil];
    [self setNowDynamicRoom:nil];
    [self setNextDynamicRoom:nil];
    [self setClassProgress:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)switchDay:(UIButton *)sender {
    [_delegate switchToDay:sender.tag];
}
@end
