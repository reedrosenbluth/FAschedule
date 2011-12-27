//
//  StudentSchedStore.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StudentSched;

@interface StudentSchedStore : NSObject

@property (nonatomic, strong, readonly) NSArray *keys;
@property (nonatomic, strong, readonly) NSDictionary *blackOutDays;
@property (nonatomic, strong) StudentSched *tempSched;

+ (StudentSchedStore *)defaultStore;

- (NSDictionary *)allStudentsScheds;
- (NSArray *)lunchPeriods;

- (void)setBlock:(StudentSched *)s forKey:(NSString *)k;
- (void)loadTempSchedWithBlock:(NSString *)blockCode;
- (StudentSched *)blockForKey:(NSString *)k;
- (void)setLunchPeriod:(int)n forIndex: (int) i;
- (int)lunchPeriodForIndex:(int) i;
- (NSString *) dataFilePath;
- (BOOL)saveChanges;

@end
