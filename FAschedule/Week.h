//
//  Week.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Week : NSObject {
    NSMutableArray *week;
}

@property (nonatomic, strong) NSMutableArray *week;

- (void)loadWeek;
- (NSArray *)loadOneDay:(int) i;

@end
