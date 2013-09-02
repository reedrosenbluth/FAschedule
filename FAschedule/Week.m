//
//  Week.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Week.h"
#import "StudentSchedStore.h"
#import "StudentSched.h"
#import "Block.h"
#import "Period.h"

@implementation Week
@synthesize week;


- (id) init
{
    self = [super init];
    if (self) {
        week = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)loadWeek
{
    StudentSchedStore *store = [StudentSchedStore defaultStore];
    NSDictionary *subjectDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Assembly", @"Assembly",
                                 @"Meeting for Worship", @"Worship",
                                 @"Advisory", @"Advisory",
                                 @"Bonus", @"Bonus",
                                 @"Extension", @"ex",
                                 nil];
    NSDictionary *roomDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"Theater", @"Assembly",
                              @"Meeting House", @"Worship",
                              @"Home Room", @"Advisory",
                              @"", @"Bonus",
                              @"", @"ex",
                              nil];
    NSSet *set = [NSSet setWithArray:[subjectDict allKeys]];
    [week removeAllObjects];
    for (int i=0; i<10; i++) {
        NSArray *day = [[NSArray alloc] initWithArray:[self loadOneDay:i]];
        NSMutableArray *d = [[NSMutableArray alloc] init];
        for (Period *period in day) {
            NSString *key = [period blockCode];
            NSString *lowerCaseKey = [key lowercaseString];
            Block *b;
            b = [[Block alloc] initWithBlockCode:[period blockCode]
                                         subject:@"" 
                                            room:@"" 
                                     startString:[period startTime] 
                                       endString:[period endTime]];   
            if ([set containsObject:key]) {
                b = [[Block alloc] initWithBlockCode:[period blockCode]
                                             subject:[subjectDict objectForKey:key] 
                                                room:[roomDict objectForKey:key] 
                                         startString:[period startTime] 
                                           endString:[period endTime]];
            } else {
                if ([[[[store blockForKey:lowerCaseKey] days] objectAtIndex:i] boolValue]) {
                    b = [[Block alloc] initWithBlockCode:[period blockCode]
                                                 subject:[[store blockForKey:lowerCaseKey] subject] 
                                                    room:[[store blockForKey:lowerCaseKey] room] 
                                             startString:[period startTime] 
                                               endString:[period endTime]];
                }
                if ([[[[store blockForKey:key] days] objectAtIndex:i] boolValue]) {
                    b = [[Block alloc] initWithBlockCode:[period blockCode]
                                                 subject:[[store blockForKey:key] subject] 
                                                    room:[[store blockForKey:key] room] 
                                             startString:[period startTime] 
                                               endString:[period endTime]];
                }
            }
            if ([[period startTime] isEqual:@"12:30"] && ([store lunchPeriodForIndex:i] == 1)) {
                [b setSubject:@"Lunch"];
                [b setRoom:@"Cafeteria"];
            }
            else if ([[period startTime] isEqual:@"13:00"] && ([store lunchPeriodForIndex:i] == 2)) {   
                [b setSubject:@"Lunch"];
                [b setRoom:@"Cafeteria"];
            }
            [d addObject:b];
        }
        [[self week] addObject:d];
    }
}

- (NSArray *)loadBlockTimeArrayForDay:(int) i
{
    return nil;
}
 
- (NSArray *)loadOneDay:(int) i
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *finalPath =[[NSBundle mainBundle] pathForResource:@"Week" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:finalPath];
    NSString *weekDay;
    NSArray *parse;
    weekDay = [NSString stringWithString:[array objectAtIndex:i]];
    parse = [weekDay componentsSeparatedByString:@","];
    int n = [parse count];
    for (int j=0; j<n; j=j+3) {
        Period *p = [[Period alloc] init];
        [p setBlockCode:[parse objectAtIndex:j]];
        [p setStartTime:[parse objectAtIndex:j+1]];
        [p setEndTime:[parse objectAtIndex:j+2]];
        [result addObject:p];
    }
    return result;
}

@end
