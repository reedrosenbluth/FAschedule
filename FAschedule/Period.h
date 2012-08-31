//
//  Period.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Period : NSObject
{
    NSString *blockCode;
    NSString *startTime;
    NSString *endTime;
}

@property (nonatomic, copy) NSString *blockCode;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@end
