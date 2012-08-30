//
//  WeekAB.m
//  WeekNumber
//
//  Created by Jeffrey Rosenbluth on 8/20/12.
//  Copyright (c) 2012 Jeffrey Rosenbluth. All rights reserved.
//

#import "WeekAB.h"

@implementation WeekAB

+ (BOOL)isB:(NSDate *)date {
    NSString *ab = @"0101010010100101010101000000000000001010101010110100";
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    int weekNum = [[gregorian components: NSWeekCalendarUnit fromDate:date] week];
    unichar c = [ab characterAtIndex:weekNum-1];
    NSString *s = [NSString stringWithFormat:@"%C", c];
    return [s boolValue];
}

@end
