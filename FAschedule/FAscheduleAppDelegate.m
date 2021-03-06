//
//  FAscheduleAppDelegate.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FAscheduleAppDelegate.h"
#import "StudentSchedStore.h"
#import "ScheduleViewController.h"
#import "Week.h"
#import "Block.h"
#import "CustomColors.h"
#import "RootViewController.h"


@implementation FAscheduleAppDelegate


@synthesize window=_window;
@synthesize bothWeeks;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    bothWeeks = [[Week alloc] init];
    [bothWeeks loadWeek];
    RootViewController *rootViewController = [[RootViewController alloc] init];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [masterNav setNavigationBarHidden:YES];
    [self.window setBackgroundColor:[UIColor blackColor]];
    [self.window setRootViewController:masterNav];
    [self.window makeKeyAndVisible];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    NSNumber *n = [NSNumber numberWithBool:YES];
    NSNumber *c = [NSNumber numberWithInt:0];
    NSDictionary *appDefaults = [[NSDictionary alloc] initWithObjectsAndKeys:n, @"newInstallation",
                                 c, @"a_or_b", nil];
    [defaults registerDefaults:appDefaults]; 
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[StudentSchedStore defaultStore] saveChanges];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[StudentSchedStore defaultStore] saveChanges];
}


@end
