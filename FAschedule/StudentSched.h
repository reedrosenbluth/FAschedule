//
//  StudentSched.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentSched : NSObject <NSCoding>
{
    NSString *subject;
    NSString *room;
    NSMutableArray *days;
}

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, strong) NSMutableArray *days;

- (id) initWithSubject:(NSString *)_subject room:(NSString *)_room days:(NSArray *)_days;
- (void) setDayToNo: (int) d;

@end
