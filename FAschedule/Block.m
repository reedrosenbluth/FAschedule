//
//  Block.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Block.h"
#import "Time.h"

@implementation Block

@synthesize blockCode;
@synthesize subject;
@synthesize room;
@synthesize startTime;
@synthesize endTime;

- (id) initWithBlockCode : (NSString *) _blockCode
                      subject : (NSString *) _subject 
                         room : (NSString *) _room
                  startString : (NSString *) _startString 
                    endString : (NSString *) _endString 
{
    self = [super init];
    if (self) {
        [self setStartTime:[[Time alloc] initWithTimeString:_startString]];
        [self setEndTime:[[Time alloc] initWithTimeString:_endString]];
        [self setBlockCode:_blockCode];
        [self setSubject:_subject];
        [self setRoom:_room];
    }
    return self;
}

- (BOOL) isCurrentBlock
{
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:kDateAdjust];
    Time *now = [[Time alloc] initWithDate:today];
    return [now isAfter:startTime before:endTime];
}

- (BOOL) isFutureBlock
{
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:kDateAdjust];
    Time *now = [[Time alloc] initWithDate:today];
    int above = now.totalSeconds - startTime.totalSeconds;
    if (above < 0)
        return YES;
    else 
        return NO;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@: %@: %@: %@: %@: ", blockCode, subject, room, [startTime hhmmString], [endTime hhmmString]];
}



@end
