//
//  Block.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Time;

typedef enum {kNo, kYes, kYes1, kYes2} BlockMatch;

@interface Block : NSObject {
    NSString *blockCode;
    NSString *subject;
    NSString *room;
    Time *startTime;
    Time *endTime;
}

@property (nonatomic, copy) NSString *blockCode;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, strong) Time *startTime;
@property (nonatomic, strong) Time *endTime;


// a block is like a period, it has a number (chronological) a code (key), a subject (course)
// a room, a start and end time. This method initializes a block.
- (id) initWithBlockCode:(NSString *) _blockCode
                subject:(NSString *) _subject room:(NSString *) _room
            startString:(NSString *) _startString endString:(NSString *) _endString;

// Checks to see if this block is scheduled at the present time.
- (BOOL) isCurrentBlock;

// Checks if the block is later that day.
- (BOOL) isFutureBlock;

@end
