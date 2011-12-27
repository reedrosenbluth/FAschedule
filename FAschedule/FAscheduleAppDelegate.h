//
//  FAscheduleAppDelegate.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Week;
@interface FAscheduleAppDelegate : NSObject <UIApplicationDelegate> {
    
    Week *bothWeeks;
    NSMutableArray *lunch;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) Week *bothWeeks;

@end