//
//  Time.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDateAdjust 0*3600

@interface Time : NSObject {
    int totalSeconds;
    int hours;
    int minutes;
    int seconds;
}

@property (nonatomic) int totalSeconds;
@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;


// takes a time string and initializes a time object with the data.
- (id) initWithTimeString: (NSString *) aString;

// init form an NSDate object.
- (id) initWithDate: (NSDate *) aDate;

// return the time formatted as hh:mm.
- (NSString *) hhmmString;

// is the time inbetween aTime and bTime.
- (BOOL) isAfter: (Time *) aTime before: (Time *) bTime;

// total seconds until aTime
- (int) secondsUntil: (Time *) aTime;

@end
