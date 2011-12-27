//
//  StudentSched.m
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StudentSched.h"

@implementation StudentSched

@synthesize subject;
@synthesize room;
@synthesize days;

- (id) initWithSubject:(NSString *)_subject room:(NSString *)_room days:(NSArray *)_days
{
    self = [super init];
    if (self) {
        [self setSubject:_subject];
        [self setRoom:_room];
        [self setDays: [[NSMutableArray alloc] initWithArray:_days]];
    }
    return self;
}

- (id)init
{
    NSMutableArray *d = [NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<10; i++) {
        NSNumber *y = [NSNumber numberWithBool:YES];
        [d addObject:y];
    }
    return [self initWithSubject:@"" room:@"" days:d];
}

- (void)setDayToNo:(int)d
{
    [[self days] replaceObjectAtIndex:d withObject:[NSNumber numberWithBool:NO]];
}

- (void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject:subject forKey:@"subject"];
    [encoder encodeObject:room forKey:@"room"];
    [encoder encodeObject:days forKey:@"days"];
}

- (id) initWithCoder:(NSCoder *) decoder
{
    if (!(self = [super init])) 
        return self;
    [self setSubject:[decoder decodeObjectForKey:@"subject"]];
    [self setRoom:[decoder decodeObjectForKey:@"room"]];
    [self setDays:[decoder decodeObjectForKey:@"days"]];
    return self;
}

- (NSString *)description
{
    NSString *string = [NSString stringWithFormat:@"Subject:%@, Room:%@, Days:%@",subject, room, days];
    return string;
}
@end
