//
//  Time.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Time.h"


@implementation Time

@synthesize totalSeconds;
@synthesize hours;
@synthesize minutes;
@synthesize seconds;

- (id) initWithTimeString: (NSString *) aString
{
    if (!(self = [super init]))
        return self;
    NSArray *hhmmss = [aString componentsSeparatedByString:@":"];
    hours = [[hhmmss objectAtIndex:0] intValue];
    minutes = [[hhmmss objectAtIndex:1] intValue];
    if ([hhmmss count] == 3)
        seconds = [[hhmmss objectAtIndex:2] intValue];
    else
        seconds = 0;
    totalSeconds = 60 * ((60 * self.hours) + self.minutes) + seconds;
    return self;
}

- (id) initWithDate:(NSDate *)aDate
{
    //if (!(self = [super init]))
    //    return self;
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    NSString *aString = [timeFormat stringFromDate:aDate];
    return [self initWithTimeString:aString];
}

- (NSString *) hhmmString
{
    int hh = self.hours % 12;
    if (hh == 0) hh = 12;
    NSString *aString = [NSString stringWithFormat:@"%d:%02d",hh, self.minutes];
    return aString;
}

- (BOOL) isAfter:(Time *)aTime before:(Time *)bTime
{
    if ((totalSeconds >= aTime.totalSeconds) && (totalSeconds <= bTime.totalSeconds))
        return YES;
    else
        return NO;
}

- (int) secondsUntil: (Time *) aTime
{
    return aTime.totalSeconds - self.totalSeconds;
}

@end
