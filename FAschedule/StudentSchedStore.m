//
//  StudentSchedStore.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StudentSchedStore.h"
#import "StudentSched.h"

@interface StudentSchedStore () 
{
    NSMutableDictionary *allStudentScheds;
    NSMutableArray *lunchPeriods;
    NSArray *archiveArray;
}
@property (nonatomic, strong, readwrite) NSArray *keys;
@property (nonatomic, strong, readwrite) NSDictionary *blackOutDays;
@end

static StudentSchedStore *defaultStore = nil;

@implementation StudentSchedStore

@synthesize keys;
@synthesize blackOutDays;
@synthesize tempSched;

+ (StudentSchedStore *)defaultStore
{
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return defaultStore;
}

- (NSString *) dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"archive"];
}

- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    self = [super init];
    if (self) {
        self.keys = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"P",
                @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"p", nil];
        NSArray *badDays = [[NSArray alloc] initWithObjects:
                            [NSNumber numberWithInt:3],
                            [NSNumber numberWithInt:6],
                            [NSNumber numberWithInt:1],
                            [NSNumber numberWithInt:8],
                            [NSNumber numberWithInt:2],
                            [NSNumber numberWithInt:4],
                            [NSNumber numberWithInt:9],
                            [NSNumber numberWithInt:0],
                            [NSNumber numberWithInt:3],
                            [NSNumber numberWithInt:6],
                            [NSNumber numberWithInt:1],
                            [NSNumber numberWithInt:8],
                            [NSNumber numberWithInt:2],
                            [NSNumber numberWithInt:4],
                            [NSNumber numberWithInt:9],
                            [NSNumber numberWithInt:0],
                            nil];
        self.blackOutDays = [[NSDictionary alloc] initWithObjects:badDays forKeys:keys];
        archiveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePath]];
        if (archiveArray) {
            allStudentScheds = [archiveArray objectAtIndex:0];
            lunchPeriods = [archiveArray objectAtIndex:1];
        } else {
            allStudentScheds = [[NSMutableDictionary alloc] init];
            StudentSched *s;
            for (id k in keys) {
                s = [[StudentSched alloc] init];
                [s setDayToNo:[[blackOutDays objectForKey:k] intValue]];
                if ([k isEqualToString:[k lowercaseString]]) {
                    for (int i=0; i<10; i++) {
                        [s setDayToNo:i];
                    }
                }
                [self setBlock:s forKey:k];
            }
            lunchPeriods = [[NSMutableArray alloc] initWithCapacity:10];
            for (int i=0; i<10; i++) {
                NSNumber *one = [NSNumber numberWithInt:1];
                [lunchPeriods addObject:one];
            }
        }
        [self setTempSched:[[StudentSched alloc] init]];
    }
    return self;
}

- (void)loadTempSchedWithBlock:(NSString *)blockCode
{
    StudentSched *sched = [allStudentScheds objectForKey:blockCode];
    [tempSched setSubject:[sched subject]];
    [tempSched setRoom:[sched room]];
    [tempSched setDays:[sched days]];
}

- (NSDictionary *)allStudentsScheds
{
    return allStudentScheds;
}

- (NSArray *)lunchPeriods
{
    return lunchPeriods;
}

- (void) setBlock:(StudentSched *)s forKey:(NSString *)k
{
    [allStudentScheds setObject:s forKey:k];
}

- (StudentSched *)blockForKey:(NSString *)k
{
    return [allStudentScheds objectForKey:k];
}

- (void)setLunchPeriod:(int)n forIndex:(int)i
{
    NSNumber *num = [NSNumber numberWithInt:n];
    [lunchPeriods replaceObjectAtIndex:i withObject:num];
}

- (int)lunchPeriodForIndex:(int) i;
{
    return [[lunchPeriods objectAtIndex:i] intValue];
}

- (BOOL)saveChanges
{
    archiveArray = [NSArray arrayWithObjects:allStudentScheds,lunchPeriods, nil];
    return [NSKeyedArchiver archiveRootObject:archiveArray toFile:[self dataFilePath]];
}

@end
